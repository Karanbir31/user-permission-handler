import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userpermission/contacts/controller/contacts_controller.dart';

class ContactsScreen extends GetView<ContactsController> {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text("All Contacts"),
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
    return Text("Location permission is granted");
  }
}
