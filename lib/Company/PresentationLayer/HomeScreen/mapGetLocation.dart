import 'dart:async';
import 'dart:collection';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Shared/constants.dart';

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

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Completer<GoogleMapController> mapController = Completer();
  List<Marker> myMarkers = [];

  Future<Uint8List> getMarker() async {
    ByteData byteData = await rootBundle.load("assets/images/maplabel.png");
    return byteData.buffer.asUint8List();
  }

  static Position? position;
  static final CameraPosition _myCurrentLocation = CameraPosition(
    bearing: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0,
    zoom: 14,
  );

  double? lat;
  double? long;

  Future<void> getCurrentLocation() async {
    position = await GeolocatorService.determinePosition().whenComplete(() {
      setState(() {});
    });
  }

  void _onMapTapped(LatLng latLng) {
    lat = latLng.latitude;
    long = latLng.longitude;
    setState(() {
      myMarkers = [];
      myMarkers.add(
        Marker(
            markerId: MarkerId(latLng.longitude.toString()), position: latLng),
      );
    });
    print("${lat}++++${long}");
  }

  Widget buildMAp() {
    return GoogleMap(
      initialCameraPosition: _myCurrentLocation,
      mapType: MapType.normal,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: false,
      myLocationEnabled: false,
      markers: Set.from(myMarkers),
      onMapCreated: (GoogleMapController _controller) async {
        mapController.complete(_controller);
      },
      onTap: _onMapTapped,
    );
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController curController = await mapController.future;
    curController
        .animateCamera(CameraUpdate.newCameraPosition(_myCurrentLocation));
  }

  @override
  void initState() {
    getCurrentLocation();
    final cubit = UnitCubit.get(context);
    final lat = cubit.latitude;
    final lng = cubit.longitude;
    if (lat != null && lng != null) {
      _onMapTapped(LatLng(lat, lng));
    }
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  lat != null
                      ? UnitCubit.get(context)
                          .getLatAndLongFromLocation(lat!, long!)
                      : null;

                  lat != null ? Navigator.pop(context) : null;
                },
                child: lat == null
                    ? Text(
                        "Pick Your Location",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        "Done",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                style: ElevatedButton.styleFrom(
                    primary: lat == null
                        ? Colors.grey
                        : ColorManager.onboardingColorDots,
                    minimumSize: Size(double.infinity, 60)),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 80),
        child: FloatingActionButton(
          onPressed: _goToMyCurrentLocation,
          child: Icon(
            Icons.place,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
