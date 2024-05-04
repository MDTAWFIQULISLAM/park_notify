import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';


import 'package:park_notify/routes/app_routes.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  TextEditingController _searchController = TextEditingController();
  late LatLng sourceLocation;
  Position? lastPosition;
  Timer? locationTimer;

  List<LatLng> parkingLocations = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    // Start checking for location change after 5 minutes
    locationTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      _checkLocationChange();
    });

    // Load parking locations from CSV
    _loadParkingLocations();
  }

  @override
  void dispose() {
    locationTimer?.cancel();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        sourceLocation = LatLng(position.latitude, position.longitude);
        lastPosition = position;
      });
    } catch (e) {
      print("Error getting current location: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Error getting current location. Please check your location settings.'),
        ),
      );
    }
  }

  Future<void> _checkLocationChange() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (lastPosition != null &&
          (position.latitude != lastPosition!.latitude ||
              position.longitude != lastPosition!.longitude)) {
        // Update last known position
        setState(() {
          lastPosition = position;
        });
      } else {
        // Delay showing the dialog by 10 seconds
        Future.delayed(Duration(seconds: 10), () {
          if (lastPosition != null &&
              (position.latitude != lastPosition!.latitude ||
                  position.longitude != lastPosition!.longitude)) {
            // User hasn't moved, prompt "Are you parked?" dialog
            _showAreYouParkedDialog();
          }
        });
      }
    } catch (e) {
      print("Error checking location change: $e");
    }
  }

  void _showAreYouParkedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you parked?"),
          actions: <Widget>[
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                // Handle 'Yes' action
              },
            ),
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.pushNamed(
                    context, AppRoutes.confirmedParkedStatus);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (sourceLocation != null)
            GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: sourceLocation, zoom: 13),
              markers: {
                Marker(
                  markerId: MarkerId("source"),
                  position: sourceLocation,
                ),
                for (int i = 0; i < parkingLocations.length; i++)
                  Marker(
                    markerId: MarkerId("parkingLocation$i"),
                    position: parkingLocations[i],
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueAzure),
                  ),
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          Positioned(
            top: MediaQuery
                .of(context)
                .padding
                .top + 5.0,
            left: 20.0,
            child: Image.asset(
              'assets/icon/icon.png', // Change this to your app logo asset path
              width: 40,
              height: 40,
            ),
          ),
          Positioned(
            top: MediaQuery
                .of(context)
                .padding
                .top + 5.0,
            right: 20.0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.all(0.1),
              child: IconButton(
                iconSize: 20.0,
                icon: Icon(Icons.my_location),
                onPressed: _goToCurrentLocation,
                color: Colors.blueAccent,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 16.0,
            right: 16.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                color: Colors.white,
                padding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Where to?',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        _searchLocation(_searchController.text);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _searchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final LatLng latLng = LatLng(
            locations.first.latitude!, locations.first.longitude!);
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newLatLngZoom(latLng, 14));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Location not found'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error searching for location: $e'),
        ),
      );
    }
  }

  Future<void> _goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(sourceLocation, 14));
  }

  Future<void> _loadParkingLocations() async {
    final String csvString = await rootBundle.loadString(
        'assets/locations/Parking_Locations.csv');
    final List<List<dynamic>> csvData = CsvToListConverter().convert(csvString);

    for (final row in csvData) {
      final double latitude = double.parse(row[0].toString());
      final double longitude = double.parse(row[1].toString());
      parkingLocations.add(LatLng(latitude, longitude));
    }

    setState(() {});
  }
}

void main() {
  runApp(MaterialApp(
    home: MapPage(),
  ));
}
