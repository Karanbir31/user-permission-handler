import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/user_location_controller.dart';

class UserLocationScreen extends GetView<UserLocationController> {
  const UserLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text("User Location"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SafeArea(
        child: Obx(
              () => controller.isLocationPermissionGranted.value
              ? Center(child: userCurrentLocation())
              : Center(child: requestPermission()),
        ),
      ),
    );
  }

  Widget requestPermission() {
    return ElevatedButton(
      onPressed: controller.requestLocationPermission,
      child: Text("Request location permission"),
    );
  }

  Widget userCurrentLocation() {
    controller.getUserLocation();
    return Obx(
          () => Text(
        "Location permission is granted \n${controller.userCurrentLocation.value}",
      ),
    );
  }
}
