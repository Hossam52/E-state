import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class LocationHelper {
  static Future<Position> determineCurrentLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}

class GeolocatorService {
  static Future<Position?> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}

class MyShowMap extends StatefulWidget {
  String long;
  String lat;

  MyShowMap({required this.lat,required this.long});

  @override
  _MyShowMapState createState() => _MyShowMapState();
}

class _MyShowMapState extends State<MyShowMap> {
  Completer<GoogleMapController> mapController = Completer();
  List<Marker> myMarkers = [];

  Future<Uint8List> getMarker() async {
    ByteData byteData = await rootBundle.load("assets/images/maplabel.png");
    return byteData.buffer.asUint8List();
  }

  static Position? position;

  double? lat;
  double? long;

  Future<void> getCurrentLocation() async {
    position = await GeolocatorService.determinePosition().whenComplete(() {
      setState(() {});
    });
  }

  Widget buildMAp() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        bearing: 0.0,
        target: LatLng(
          double.tryParse(widget.lat) ?? 0.0,
          double.tryParse(widget.long) ?? 0.0,
        ),
        tilt: 0.0,
        zoom: 14,
      ),
      mapType: MapType.normal,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: false,
      myLocationEnabled: false,
      markers: Set.from(myMarkers),
      onMapCreated: (GoogleMapController _controller) async {
        mapController.complete(_controller);
        setState(() {
        });
      },
      onTap: (LatLng latLng) {

        lat = latLng.latitude;
        long = latLng.longitude;
        setState(() {
          myMarkers = [];
          myMarkers.add(
            Marker(
                markerId: MarkerId(latLng.longitude.toString()),
                position: latLng),
          );
        });
      },
    );
  }


  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          position != null
              ? buildMAp()
              : Center(
            child: Container(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}