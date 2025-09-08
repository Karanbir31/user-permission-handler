import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsController extends GetxController {
  final contactsPermission = Permission.contacts;

  RxBool isContactPermissionGranted = false.obs;
  RxList<Map<String, String>> allContacts = <Map<String, String>>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    // Check existing permission
    isContactPermissionGranted.value = await contactsPermission.isGranted;

    if (isContactPermissionGranted.value) {
      await readContactsList();
    }
  }

  /// Request permission dynamically
  Future<void> requestContactPermission() async {
    if (await contactsPermission.isPermanentlyDenied) {
      openAppSettings();
    } else if(await contactsPermission.isDenied){
      final status = await contactsPermission.request();
      isContactPermissionGranted.value = status.isGranted;

      if (isContactPermissionGranted.value) {
        await readContactsList();
      }
    }

  }

  /// Read all contacts and save to allContacts list
  Future<void> readContactsList() async {
    if (!isContactPermissionGranted.value) return;

    final contacts = await FlutterContacts.getContacts(withProperties: true);

    allContacts.clear(); // reset

    for (var contact in contacts) {
      final name = contact.displayName;
      final phone = contact.phones.isNotEmpty
          ? contact.phones.first.number
          : "N/A";

      allContacts.add({"name": name, "phone": phone});
    }
  }
}
