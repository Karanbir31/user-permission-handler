import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              onPressed: () {
                Get.toNamed(NavRoutes.locationRoute);
              },
              icon: Icon(Icons.location_history),
            ),
          ),
        ],
      ),
    );
  }
}
