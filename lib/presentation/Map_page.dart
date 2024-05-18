import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

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
  Timer? locationTimer;

  List<LatLng> parkingLocations = [];
  bool isLoading = true;

  Uint8List? markerIcon;

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndGetLocation();
    locationTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      _checkLocationChange();
    });
    _loadParkingLocations();
    _loadMarkerIcon();
  }

  @override
  void dispose() {
    locationTimer?.cancel();
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

  Future<void> _checkLocationChange() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (lastPosition != null &&
          (position.latitude != lastPosition!.latitude ||
              position.longitude != lastPosition!.longitude)) {
        setState(() {
          lastPosition = position;
        });
      } else {
        Future.delayed(Duration(seconds: 10), () {
          if (lastPosition != null &&
              (position.latitude != lastPosition!.latitude ||
                  position.longitude != lastPosition!.longitude)) {
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
                // Navigate to another screen or perform action
              },
            ),
          ],
        );
      },
    );
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

  Future<void> _loadMarkerIcon() async {
    final ByteData byteData =
    await rootBundle.load('assets/images/pn_logo.png');
    markerIcon = byteData.buffer.asUint8List();
    setState(() {});
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
                    icon: markerIcon != null
                        ? BitmapDescriptor.fromBytes(markerIcon!)
                        : BitmapDescriptor.defaultMarker,
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
