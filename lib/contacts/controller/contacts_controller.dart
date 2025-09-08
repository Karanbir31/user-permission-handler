import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsController extends GetxController {
  var locationPermission = Permission.locationWhenInUse;
  var contactsPermission = Permission.contacts;
  RxBool isLocationPermissionGranted= false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    isLocationPermissionGranted.value =
        await locationPermission.status.isGranted;
  }

  Future<void> requestLocationPermission() async {
    if (await locationPermission.isDenied) {
      final result = await locationPermission.request();

      isLocationPermissionGranted.value = result.isGranted;
    }
  }

  Future<void> userCurrentLocation() async{





  }





}
