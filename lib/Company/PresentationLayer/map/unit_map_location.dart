import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:osol/User/PresentaionLayer/notification/view.dart';

class LocationHelper {
  static Future<Position> getCurrentLocation() async {
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
    log(permission.toString());
    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          return Future.error('Location Not Available');
        }
      } else {
        throw Exception('Error');
      }
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}

class UnitMapLocation extends StatefulWidget {
  const UnitMapLocation({Key? key, required this.lat, required this.lng})
      : super(key: key);
  final double lat;
  final double lng;

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<UnitMapLocation> {
  Completer<GoogleMapController> mapController = Completer();
  List<Marker> myMarkers = [];

  Future<Uint8List> getMarker() async {
    ByteData byteData = await rootBundle.load("assets/images/maplabel.png");
    return byteData.buffer.asUint8List();
  }

  double? lat;
  double? long;

  Widget buildMAp() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        bearing: 0.0,
        target: LatLng(widget.lat, widget.lng),
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
      },
    );
  }

  @override
  void initState() {
    myMarkers.add(
      Marker(
          markerId: MarkerId(lat.toString()),
          position: LatLng(widget.lat, widget.lng)),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, 'Unit location'),
      body: Stack(
        children: [buildMAp()],
      ),
      // floatingActionButton: Container(
      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 80),
      //   child: FloatingActionButton(
      //     onPressed: _goToMyCurrentLocation,
      //     child: Icon(
      //       Icons.place,
      //       color: Colors.white,
      //     ),
      //     backgroundColor: Colors.blue,
      //   ),
      // ),
    );
  }
}
