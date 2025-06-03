import 'package:boxify/custom_widgets/elevatedbutton.dart';
import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/direction/cubit/direction_screen_cubit.dart';
import 'package:boxify/screens/direction/cubit/direction_screen_state.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionScreen extends StatefulWidget {
  const DirectionScreen({super.key});

  @override
  State<DirectionScreen> createState() => _DirectionScreenState();
}

class _DirectionScreenState extends State<DirectionScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DirectionCubit()..loadDirections(),
      child: Scaffold(
        backgroundColor: Color(0xFFF3F4F8),
        appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close, color: Colors.black),
          ),
          title: CustomText(
            data: boxName,
            fontWeight: FontWeight.w800,
            fontSize: 15.sp,
          ),
        ),
        body: BlocConsumer<DirectionCubit, DirectionState>(
          listener: (BuildContext context, DirectionState state) {},
          builder: (BuildContext context, DirectionState state) {
            var directionCubit = DirectionCubit.get(context);
            if (state is DirectionLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is DirectionLoaded) {
              return Stack(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              directionCubit.latitude,
                              directionCubit.longitude,
                            ),
                            zoom: 15,
                          ),
                          myLocationEnabled: true,
                          zoomControlsEnabled: false,
                          markers: {
                            Marker(
                              markerId: MarkerId(location),
                              position: LatLng(
                                directionCubit.latitude,
                                directionCubit.longitude,
                              ),
                            ),
                          },
                          gestureRecognizers:
                              <Factory<OneSequenceGestureRecognizer>>{
                                Factory<OneSequenceGestureRecognizer>(
                                  () => EagerGestureRecognizer(),
                                ),
                              },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 14,
                    bottom: 30,
                    child: CustomElevatedButton(
                      text: direction,
                      onPressed: () async {
                        directionCubit.openGoogleMaps();
                      },
                      backgroundColor: Color(0xFF0E7AFF),
                      textColor: Color(0xFFFFFFFF),
                    ),
                  ),
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
