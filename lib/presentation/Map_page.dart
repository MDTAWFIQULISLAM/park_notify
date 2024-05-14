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
  bool _isSearchBarOpen = false;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _checkIfParked(); // Check if user is parked when page initializes

    _focusNode.addListener(() {
      setState(() {
        _isSearchBarOpen = _focusNode.hasFocus;
        if (!_isSearchBarOpen) {
          // Reset the position when keyboard is closed
          _resetSearchBarPosition();
        }
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _resetSearchBarPosition() {
    setState(() {
      _isSearchBarOpen = false;
    });
    // Reset padding back to 20 after keyboard is dismissed
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _isSearchBarOpen ? 20.0 : MediaQuery.of(context).size.height - 390;
      });
    });
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
    while (true) {
      await Future.delayed(Duration(seconds: 10));
      if (_currentPosition != null) {
        Position currentPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        if (_currentPosition!.latitude == currentPosition.latitude &&
            _currentPosition!.longitude == currentPosition.longitude) {
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
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: _isSearchBarOpen ? MediaQuery.of(context).size.height - 390 : 20.0,
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
                        onTap: () {
                          setState(() {
                            _isSearchBarOpen = true;
                          });
                        },
                        focusNode: _focusNode,
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search Address or Postcode',
                          border: InputBorder.none,
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
          Positioned(
            top: MediaQuery.of(context).padding.top + 5.0,
            left: 20.0,
            child: Image.asset(
              '/Users/tanvirakhtershakib/StudioProjects/park_notify/assets/icon/icon.png', // Change this to your app logo asset path
              width: 40,
              height: 40,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 0.0,
            right: 20.0,
            child: Column(
              children: [
                SizedBox(height: 0),
                IconButton(
                  icon: Icon(Icons.zoom_in),
                  onPressed: () {
                    _mapController.animateCamera(CameraUpdate.zoomIn());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.zoom_out),
                  onPressed: () {
                    _mapController.animateCamera(CameraUpdate.zoomOut());
                  },
                ),
              ],
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
      _mapController.animateCamera(CameraUpdate.newLatLngZoom(latLng, 14));
    } else {
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
