import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userpermission/contacts/controller/contacts_binding.dart';
import 'package:userpermission/contacts/presentation/contacts_screen.dart';
import 'package:userpermission/location/controller/user_location_binding.dart';
import 'package:userpermission/location/presentation/user_location_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: NavRoutes.initialRoute,

      getPages: [
        GetPage(
          name: NavRoutes.contactsRoute,
          page: () => ContactsScreen(),
          binding: ContactsBinding(),
        ),
        GetPage(
          name: NavRoutes.locationRoute,
          page: () => UserLocationScreen(),
          binding: UserLocationBinding(),
        ),
      ],
    );
  }
}

class NavRoutes {
  static String initialRoute = "/contacts";
  static String contactsRoute = "/contacts";
  static String locationRoute = "/user_location";
}
