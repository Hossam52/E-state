import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Company/PresentationLayer/HomeScreen/mapGetLocation.dart';
import '../../../Shared/constants.dart';
import '../../../Shared/customBottomAppBar.dart';
import '../../../Shared/customListLabel.dart';
import '../../BussinssLogic/authCubit/auth_cubit.dart';
import '../../BussinssLogic/homeCubit/home_cubit.dart';
import '../MapScreen/units.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  var myMarkers = HashSet<Marker>();
  Completer<GoogleMapController> _mapController = Completer();

  @override
  void initState() {
    HomeCubit.get(context).myToken == null &&
            AuthCubit.get(context).userToken == null
        ? null
        : getCurrentLocation();
    super.initState();
  }

  Completer<GoogleMapController> _controller = Completer();

  static Position? position;

  Future<void> getCurrentLocation() async {
    position = await GeolocatorService.determinePosition().whenComplete(() {
      setState(() {});
    });
  }

  static final CameraPosition _kLake = CameraPosition(
      target: LatLng(30.0064196, 31.4329283),
      tilt: 59.440717697143555,
      zoom: 10);

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              child: Container(
                child: GoogleMap(
                  mapType: MapType.normal,
                  onTap: (LatLng latLng) {
                    final lat = latLng.latitude;
                    final long = latLng.longitude;
                    print("${lat};;;$long");
                  },
                  initialCameraPosition: _kLake,
                  compassEnabled: false,
                  mapToolbarEnabled: false,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController controller) async {
                    _controller.complete(controller);
                  },
                  markers: Set.from(cubit.myMarker),
                ),
              ),
            ),
            Positioned(
              child: Container(
                height: sizeFromHeight(5),
                child: Column(
                  children: [
                    CustomBottomAppBar(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 5),
                      child: Container(
                        height: sizeFromHeight(17),
                        width: sizeFromWidth(1),
                        child: UserFilterLabelsWidget(
                          num: 400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: sizeFromHeight(15),
              child: Container(
                height: sizeFromHeight(5.5),
                child: HorizontalScrollList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
