import 'package:get/get.dart';
import 'package:userpermission/contacts/controller/contacts_controller.dart';

class ContactsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactsController());
  }
}
