import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' show cos, sqrt, asin;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

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
  bool _hasShownParkingDialog = false; // Add this flag

  static const LatLng parkingLocation1 = LatLng(51.543350, -0.028030);
  static const LatLng parkingLocation2 = LatLng(51.549720, -0.041210);
  static const LatLng parkingLocation3 = LatLng(51.541557, -0.000093);

  static const double proximityThreshold = 0.4; // Define a threshold for proximity checking

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    // Start checking for location change every 10 seconds
    locationTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      _checkLocationChange();
    });
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
          content: Text('Error getting current location. Please check your location settings.'),
        ),
      );
    }
  }

  bool _isNearParkingLocation(Position position) {
    final LatLng currentLatLng = LatLng(position.latitude, position.longitude);
    return _calculateDistance(currentLatLng, parkingLocation1) <= proximityThreshold ||
        _calculateDistance(currentLatLng, parkingLocation2) <= proximityThreshold ||
        _calculateDistance(currentLatLng, parkingLocation3) <= proximityThreshold;
  }

  double _calculateDistance(LatLng start, LatLng end) {
    final double lat1 = start.latitude;
    final double lon1 = start.longitude;
    final double lat2 = end.latitude;
    final double lon2 = end.longitude;
    const double p = 0.017453292519943295;
    final double a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) *
            cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
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
          _hasShownParkingDialog = false; // Reset the flag when the position changes
        });
      } else {
        // Delay showing the dialog by 10 seconds
        Future.delayed(Duration(seconds: 10), () {
          if (_isNearParkingLocation(position) && !_hasShownParkingDialog) {
            // User hasn't moved and is near a parking location, prompt "Are you parked?" dialog
            _showAreYouParkedDialog();
          }
        });
      }
    } catch (e) {
      print("Error checking location change: $e");
    }
  }

  void _showAreYouParkedDialog() {
    setState(() {
      _hasShownParkingDialog = true; // Set the flag when the dialog is shown
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you parked?"),
          actions: <Widget>[
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.confirmedParkedStatus);

                // Handle 'Yes' action
              },
            ),
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _searchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final LatLng latLng = LatLng(locations.first.latitude, locations.first.longitude);
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newLatLngZoom(latLng, 14));
        // You may add a marker here to show the searched location
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

  Future<void> _zoomIn() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.zoomIn());
  }

  Future<void> _zoomOut() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.zoomOut());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (sourceLocation != null)
            GoogleMap(
              initialCameraPosition: CameraPosition(target: sourceLocation, zoom: 13),
              markers: {
                Marker(markerId: MarkerId("source"), position: sourceLocation),
                Marker(
                  markerId: MarkerId("destination1"),
                  position: parkingLocation1,
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                ),
                Marker(
                  markerId: MarkerId("destination2"),
                  position: parkingLocation2,
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                ),
                Marker(
                  markerId: MarkerId("destination3"),
                  position: parkingLocation3,
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                ),
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              zoomControlsEnabled: false, // Disable the default zoom controls
            ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 5.0,
            left: 20.0,
            child: Image.asset(
              'assets/icon/icon.png', // Change this to your app logo asset path
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
                    color: Colors.grey.withOpacity(0.3), // Soft shadow color
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2), // Adjust the position of the shadow
                  ),
                ],
              ),
              padding: EdgeInsets.all(0.1), // Adjust padding as needed
              child: IconButton(
                iconSize: 20.0, // Decrease the size of the icon
                icon: Icon(Icons.my_location),
                onPressed: _goToCurrentLocation,
                color: Colors.blueAccent, // Adjust icon color as needed
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
          // Custom zoom controls
          Positioned(
            bottom: 90, // Adjust this value to position above the search bar
            right: 16, // Adjust this value to align with the right of the search bar
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "zoomIn",
                  mini: true,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.zoom_in, color: Colors.black),
                  onPressed: _zoomIn,
                ),
                SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: "zoomOut",
                  mini: true,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.zoom_out, color: Colors.black),
                  onPressed: _zoomOut,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MapPage(),
  ));
}
