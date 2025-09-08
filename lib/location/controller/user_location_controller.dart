import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class UserLocationController extends GetxController {
  final locationPermission = Permission.locationWhenInUse;

  RxBool isLocationPermissionGranted = false.obs;
  RxString currentCoordinates = "".obs;
  RxString currentAddress = "".obs;
  Position? position;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLocationPermissionGranted.value = await locationPermission.isGranted;

    if (isLocationPermissionGranted.value) {
      await getUserLocation(); // only once
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
      currentCoordinates.value = "Location services are disabled.";
      return;
    }

    // Get current position
    position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.best),
    );

    currentCoordinates.value =
        "Latitude: ${position!.latitude}, Longitude: ${position!.longitude}";

    getCurrentAddress();
  }

  Future<void> getCurrentAddress() async {
    if (position == null) return;

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position!.latitude,
      position!.longitude,
    );

    Placemark place = placemarks[0];

    currentAddress.value =
        "${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
  }

  Future<void> openGoogleMaps() async {
    if (position == null) return;

    final Uri googleMapsUri = Uri.parse(
      "geo:${position!.latitude},${position!.longitude}?q=${position!.latitude},${position!.longitude}",
    );

    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri, mode: LaunchMode.externalApplication);
    } else {
      // fallback to browser
      final Uri browserUri = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=${position!.latitude},${position!.longitude}",
      );
      await launchUrl(browserUri, mode: LaunchMode.externalApplication);
    }
  }

}
