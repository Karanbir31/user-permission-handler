import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class UserLocationController extends GetxController {
  var locationPermission = Permission.locationWhenInUse;

  RxBool isLocationPermissionGranted = false.obs;

  RxString userCurrentLocation = "".obs;

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

      if (isLocationPermissionGranted.value) {
        getUserLocation();
      }
    }
  }

  Future<void> getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
    );

    userCurrentLocation.value =
        "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
  }
}
