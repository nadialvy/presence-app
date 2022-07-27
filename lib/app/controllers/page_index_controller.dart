import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:presence_app/app/routes/app_pages.dart';
import 'package:geocoding/geocoding.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore =FirebaseFirestore.instance;

  void changePage(i) async {
    print('click index=$i');
    pageIndex.value = i;
    
    switch(i){
      case 1:
        
        // await Geolocator.openAppSettings();
        // await Geolocator.openLocationSettings();
        
        Map<String, dynamic> resp = await determinePosition();
        if(resp["error"] != true){
          Position position = resp["position"];

          List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
          String address = "${placemarks[2].street}, ${placemarks[0].subLocality}, ${placemarks[0].locality}";

          await updatePosition(position, address);
          // print("${placemarks[2].street}, ${placemarks[0].subLocality}, ${placemarks[0].locality}");

          Get.snackbar("${resp['message']}", address);
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

  Future<void> updatePosition(Position position, String address) async{
    String uid = await auth.currentUser!.uid;

    await firestore.collection("pegawai").doc(uid).update({
      "position" : {
        "lat" : position.latitude,
        'long' : position.longitude
      },
      "address" : address
    });

  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return {
        "message" : "Aktifkan GPS anda",
        "error" : true,
      };
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return {
          "message" : "Izin menggunakan GPS ditolak",
          "error" : true,
        };  
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return {
        "message" : "Settingan hp kamu tidak memperbolehkan untuk mengakses GPS. Ubah pada setting",
        "error" : true,
      };
    } 

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return {
      "position" : position,
      "message" : "Berhasil mendapatkan posisi device",
      "error" : false
    };
  }
}
