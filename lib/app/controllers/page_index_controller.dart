import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:presence_app/app/routes/app_pages.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  void changePage(i) async {
    print('click index=$i');
    pageIndex.value = i;
    
    switch(i){
      case 1:
        print('ABSEN');
        Map<String, dynamic> resp = await determinePosition();
        if(resp["error"] != true){
          Position position = resp["position"];
          Get.snackbar("${resp['message']}", "${position.latitude} - ${position.longitude}");
        }else {
          Get.snackbar("Terjadi Kesalahan", "${resp['message']}");
        } 
        break;
      case 2:
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
    }
  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the 
      // App to enable the location services.
      return {
        "message" : "Tidak dapat mengambil lokasi dari device ini",
        "error" : true,
      };
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale 
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return {
          "message" : "Izin menggunakan GPS ditolak",
          "error" : true,
        };  
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      return {
        "message" : "Settingan hp kamu tidak memperbolehkan untuk mengakses GPS. Ubah pada setting",
        "error" : true,
      };
    } 

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    return {
      "position" : position,
      "message" : "Berhasil mendapatkan posisi device",
      "error" : false
    };
  }
}
