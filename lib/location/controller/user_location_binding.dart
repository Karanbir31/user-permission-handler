import 'package:get/get.dart';
import 'package:userpermission/location/controller/user_location_controller.dart';

class UserLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserLocationController());
  }
}
