import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:userpermission/contacts/controller/contacts_controller.dart';

import '../../main.dart';

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

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () {
                Get.toNamed(NavRoutes.locationRoute);
              },
              icon: Icon(Icons.location_history),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () {
                openAppSettings();
              },
              icon: Icon(Icons.settings),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Obx(() {
          if (!controller.isContactPermissionGranted.value) {
            return Center(child: requestPermission());
          }

          if (controller.allContacts.isEmpty) {
            return const Center(child: Text("No contacts found"));
          }

          return userContactsList();
        }),
      ),
    );
  }

  Widget requestPermission() {
    return ElevatedButton(
      onPressed: controller.requestContactPermission,
      child: const Text("Request Contacts Permission"),
    );
  }

  Widget userContactsList() {
    return Obx(
      () => ListView.builder(
        itemCount: controller.allContacts.length,
        itemBuilder: (context, index) {
          final currentContact = controller.allContacts[index];
          final name = currentContact["name"] ?? "Unknown";
          final phone = currentContact["phone"] ?? "N/A";

          return ListTile(
            leading: const Icon(Icons.person, color: Colors.blue),
            title: Text(name),
            subtitle: Text(phone),
          );
        },
      ),
    );
  }
}
