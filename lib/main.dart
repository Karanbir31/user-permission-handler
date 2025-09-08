import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userpermission/contacts/controller/contacts_binding.dart';
import 'package:userpermission/contacts/presentation/contacts_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/contacts",

      getPages: [
        GetPage(
          name: "/contacts",
          page: () => ContactsScreen(),
          binding: ContactsBinding(),
        ),
      ],
    );
  }
}
