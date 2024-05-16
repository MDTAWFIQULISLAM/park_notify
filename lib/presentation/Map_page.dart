import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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
  LatLng? sourceLocation;
  Position? lastPosition;

  List<LatLng> parkingLocations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndGetLocation();
    _loadParkingLocations();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _checkPermissionsAndGetLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location services are disabled. Please enable the services'),
        ),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Location permissions are denied'),
          ),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.'),
        ),
      );
      return;
    }

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        sourceLocation = LatLng(position.latitude, position.longitude);
        lastPosition = position;
      });
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLngZoom(sourceLocation!, 2));
    } catch (e) {
      print("Error getting current location: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error getting current location. Please check your location settings.',
          ),
        ),
      );
    }
  }

  Future<void> _loadParkingLocations() async {
    try {
      final String csvString = await rootBundle.loadString('assets/locations/Parking_Locations.csv');
      final List<List<dynamic>> csvData = CsvToListConverter().convert(csvString, eol: "\n");

      List<LatLng> locations = [];
      for (final row in csvData.skip(1)) {  // Skip header row
        try {
          final double latitude = double.parse(row[2].toString());
          final double longitude = double.parse(row[3].toString());
          locations.add(LatLng(latitude, longitude));
        } catch (e) {
          print("Error parsing row: $row, Error: $e");
        }
      }

      setState(() {
        parkingLocations = locations;
        isLoading = false;
      });
    } catch (e) {
      print("Error loading CSV: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading parking locations.'),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (sourceLocation != null)
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: sourceLocation!,
                zoom: 13,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("source"),
                  position: sourceLocation!,
                ),
                for (int i = 0; i < parkingLocations.length; i++)
                  Marker(
                    markerId: MarkerId("parkingLocation$i"),
                    position: parkingLocations[i],
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueAzure,
                    ),
                  ),
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            )
          else
            Center(child: CircularProgressIndicator()),
          if (isLoading)
            Center(child: CircularProgressIndicator()),
          Positioned(
            top: MediaQuery.of(context).padding.top + 5.0,
            left: 20.0,
            child: Image.asset(
              'assets/icon/icon.png',
              width: 40,
              height: 40,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 5.0,
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
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
          locations.first.latitude,
          locations.first.longitude,
        );
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
    if (sourceLocation != null) {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLngZoom(sourceLocation!, 14));
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: MapPage(),
  ));
}
