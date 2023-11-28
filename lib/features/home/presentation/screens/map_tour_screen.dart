// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  final String lat;
  final String long;
  final String zoom;
  final String location;
  const Maps({
    Key? key,
    required this.lat,
    required this.long,
    required this.zoom,
    required this.location,
  }) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  late double lat;
  late double long;
  late double zoom;
  late LatLng showLocation;

  @override
  void initState() {
    zoom = double.parse(widget.zoom.replaceAll(RegExp('[a-zA-Z]'), ''));
    _getCurrentLocation().then((value) {
      lat = value.latitude;
      long = value.longitude;
    });
    showLocation = LatLng(double.parse(widget.lat), double.parse(widget.long));
    markers.add(Marker(
      markerId: MarkerId(showLocation.toString()),
      position: showLocation,
      infoWindow: const InfoWindow(
        title: 'Hello',
        snippet: 'Hi there',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    super.initState();
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Service is not enabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Local permission always denied");
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place on maps"),
      ),
      body: GoogleMap(
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: showLocation,
          zoom: zoom,
        ),
        markers: markers,
        mapType: MapType.normal,
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }
}
