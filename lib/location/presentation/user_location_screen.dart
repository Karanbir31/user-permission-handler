import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/user_location_controller.dart';

class UserLocationScreen extends GetView<UserLocationController> {
  const UserLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("User Location"),
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
      child: const Text("Request location permission"),
    );
  }

  Widget userCurrentLocation() {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Location permission is granted"),
          const SizedBox(height: 16),
          Text(controller.currentCoordinates.value),
          const SizedBox(height: 8),
          Text(controller.currentAddress.value),

          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: controller.openGoogleMaps,
            child: Text("Open Map"),
          ),
        ],
      ),
    );
  }
}
