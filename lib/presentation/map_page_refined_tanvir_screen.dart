import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:park_notify/widgets/custom_search_view.dart';
import 'package:park_notify/core/app_export.dart';

class MapPageRefinedTanvirScreen extends StatefulWidget {
  MapPageRefinedTanvirScreen({Key? key}) : super(key: key);

  @override
  _MapPageRefinedTanvirScreenState createState() =>
      _MapPageRefinedTanvirScreenState();
}

class _MapPageRefinedTanvirScreenState
    extends State<MapPageRefinedTanvirScreen> {
  late GoogleMapController _mapController;
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(0, 0),
              zoom: 14,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            // Add more map options as needed
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomSearchView(
                      controller: searchController,
                      hintText: 'Search Address or Postcode',
                      onSubmitted: (value) {
                        _searchLocation(value);
                      },
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
      final LatLng latLng =
      LatLng(locations.first.latitude!, locations.first.longitude!);
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
