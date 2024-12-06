import 'dart:convert';
import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/utils/utils.dart';
import 'package:http/http.dart' as http;

class LocationApi {
  static Future<Position?> getPosition() async {
    if ((await InternetConnectionChecker().hasConnection)) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          showToast(toastMsg: 'Please enable location to get nearby shops');
          Future.delayed(
            const Duration(seconds: 3),
            () async {
              await AppSettings.openAppSettings(type: AppSettingsType.location);
            },
          );
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        showToast(toastMsg: 'Please enable location to get nearby shops');
        Future.delayed(
          const Duration(seconds: 3),
          () async {
            await AppSettings.openAppSettings(type: AppSettingsType.location);
          },
        );
        return null;
      }

      return await Geolocator.getCurrentPosition();
    } else {
      showToast(toastMsg: 'Please check your internet connection');
      return null;
    }
  }

  static Future<void> updateLocationDetails(Position position) async {
    try {
      // Reverse geocoding to get address details
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        String name = place.name ?? "Unknown";
        String zipcode = place.postalCode ?? "Unknown";
        String address = "${place.street}, ${place.locality}, ${place.country}";
        double latitude = position.latitude;
        double longitude = position.longitude;
        final token = await UserApiToken.getToken();
        // Prepare the location data
        Map<String, dynamic> locationData = {
          "api_token": token,
          "zipcode": zipcode,
          "latitude": latitude,
          "longitude": longitude,
        };

        log('Location Data: $locationData');
        await sendLocationToServer(locationData);
      }
    } catch (e) {
      log('Error fetching location details: $e');
      showToast(toastMsg: 'Failed to fetch location details.');
    }
  }

  static Future<void> sendLocationToServer(
      Map<String, dynamic> locationData) async {
    try {
      final url = Uri.parse(ApiEndPoints.updateProfile);
      final response = await http.post(
        url,
        headers: ApiEndPoints.apiHeaders,
        body: jsonEncode(locationData),
      );
      log('update location response: ${response.body}');
      if (response.statusCode == 200) {
        showToast(toastMsg: 'Location updated successfully!');
      } else {
        showToast(toastMsg: 'Failed to update location.');
      }
    } catch (e) {
      log('Error sending location to server: $e');
      handleError(error: e);
    }
  }
}
