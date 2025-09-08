import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class UserLocationController extends GetxController {
  final locationPermission = Permission.locationWhenInUse;

  RxBool isLocationPermissionGranted = false.obs;
  RxString userCurrentLocation = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    // Check existing permission
    isLocationPermissionGranted.value = await locationPermission.isGranted;

    if (isLocationPermissionGranted.value) {
      await getUserLocation();
    }
  }

  /// Request location permission dynamically
  Future<void> requestLocationPermission() async {
    if (await locationPermission.isPermanentlyDenied) {
      await openAppSettings();
    } else if (await locationPermission.isDenied) {
      final status = await locationPermission.request();
      isLocationPermissionGranted.value = status.isGranted;

      if (isLocationPermissionGranted.value) {
        await getUserLocation();
      }
    }
  }

  /// Fetch current user location
  Future<void> getUserLocation() async {
    if (!isLocationPermissionGranted.value) return;

    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      userCurrentLocation.value = "Location services are disabled.";
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
      ),
    );

    userCurrentLocation.value =
    "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
  }
}
