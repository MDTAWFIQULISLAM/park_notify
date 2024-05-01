import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  TextEditingController _searchController = TextEditingController();

  static const LatLng sourceLocation = LatLng(51.5453839, -0.0410396);
  static const LatLng parkingLocation1 = LatLng(51.543350, -0.028030);
  static const LatLng parkingLocation2 = LatLng(51.549720, -0.041210);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
            CameraPosition(target: sourceLocation, zoom: 13),
            markers: {
              Marker(
                markerId: MarkerId("source"),
                position: sourceLocation,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
              ),
              Marker(
                markerId: MarkerId("destination"),
                position: parkingLocation1,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure), // Marker color #0374BA
              ),
              Marker(
                markerId: MarkerId("destination2"),
                position: parkingLocation2,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure), // Marker color #0374BA
              ),
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
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
            bottom: 20,
            left: 16.0,
            right: 16.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
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
                          hintText: 'Search Address or Postcode',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
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
        final LatLng latLng =
        LatLng(locations.first.latitude!, locations.first.longitude!);
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
}

void main() {
  runApp(MaterialApp(
    home: MapPage(),
  ));
}
