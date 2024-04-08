import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;
  TextEditingController searchController = TextEditingController();
  Position? _currentPosition;
  bool _isParked = false;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _checkIfParked(); // Check if user is parked when page initializes
  }

  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _checkIfParked() async {
    // Continuously check if the user is moving
    while (true) {
      await Future.delayed(Duration(seconds: 10)); // Check every 10 seconds
      if (_currentPosition != null) {
        // Get the user's current position
        Position currentPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        // Compare with the previous position to check movement
        if (_currentPosition!.latitude == currentPosition.latitude &&
            _currentPosition!.longitude == currentPosition.longitude) {
          // If user is not moving, show popup
          _showParkedPopup();
          break;
        }
        _currentPosition = currentPosition;
      }
    }
  }

  void _showParkedPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you parked?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Set user as parked
                setState(() {
                  _isParked = true;
                });
              },
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("No"),
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
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _currentPosition != null
                ? CameraPosition(
              target: LatLng(_currentPosition!.latitude,
                  _currentPosition!.longitude),
              zoom: 14,
            )
                : CameraPosition(
              target: LatLng(0, 0),
              zoom: 14,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            // Add more map options as needed
          ),
          Positioned(
            bottom: 20,
            left: 16.0,
            right: 16.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0), // Adjust border radius as needed
              child: Container(
                color: Colors.white,
                padding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search Address or Postcode',
                          border: InputBorder.none, // Remove TextField border
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        _searchLocation(searchController.text);
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

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  Future<void> _searchLocation(String query) async {
    List<Location> locations = await locationFromAddress(query);
    if (locations.isNotEmpty) {
      final LatLng latLng = LatLng(locations.first.latitude!,
          locations.first.longitude!);
      // Move the camera to the searched location
      _mapController.animateCamera(CameraUpdate.newLatLngZoom(latLng, 14));
    } else {
      // Handle case when no location is found
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location not found'),
        ),
      );
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: MapPage(),
  ));
}