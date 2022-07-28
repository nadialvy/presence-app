import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
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
          //get lat and long then convert
          Position position = resp["position"];

          List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
          String address = "${placemarks[2].street}, ${placemarks[0].subLocality}, ${placemarks[0].locality}";
          await updatePosition(position, address);

          //cek jarak antara 2 posisi
          double distance = Geolocator.distanceBetween(-8.1244418, 111.8235724, position.latitude, position.longitude);
          print(distance);

          //presensi
          await presensi(position, address, distance);

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

  Future<void> presensi(Position position, String address, double distance) async{
    String uid = auth.currentUser!.uid;

    CollectionReference<Map<String, dynamic>> colPresence = firestore.collection("pegawai").doc(uid).collection("presence");
  
    QuerySnapshot<Map<String, dynamic>> snapPresence = await colPresence.get();

    DateTime now = DateTime.now();
    String todayDocID = DateFormat.yMd().format(now).replaceAll('/', '-');

    String status = "Di Luar Area";
    if(distance <= 200){
      // didalam area
      status = "Di Dalam Area";
    }

    if(snapPresence.docs.isEmpty){
      // ABSEN MASUK PERTAMA KALI
      await colPresence.doc(todayDocID).set({
        "date" : now.toIso8601String(),
        "masuk" : {
          "date" : now.toIso8601String(),
          "lat" : position.latitude,
          "long" : position.longitude,
          "address" : address,
          "status" : status,
          "distance" : distance
        }
      });

      Get.snackbar("Sukses", "Absen masuk anda sudah disimpan");

    } else {
      //UDAH PERNAH ABSEN SEBELUMNYA

      DocumentSnapshot<Map<String, dynamic>> todayDoc = await colPresence.doc(todayDocID).get();
      print(todayDoc.exists);

      if(todayDoc.exists == true){
        //ABSEN KELUAR ATAU UDAH 2 2 NYA
        Map<String, dynamic>? todayPresenceData = todayDoc.data();

        if(todayPresenceData!["keluar"] != null){
          //UDAH 2 2NYA
          Get.snackbar("Tidak dapat absen", "Anda sudah masuk absen dan keluar. Anda tidak dapat absen lagi untuk hari ini");
        } else {
          // ABSEN KELUAR
          print('ABSEN KELUARRR');
          await colPresence.doc(todayDocID).update({
            "keluar" : {
              "date" : now.toIso8601String(),
              "lat" : position.latitude,
              "long" : position.longitude,
              "address" : address,
              "status" : status,
              "distance" : distance
            }
          });

          Get.snackbar("Sukses", "Absen keluar anda sudah disimpan");
        }

      }else {
        // ABSEN MASUK YANG KE2 KALI DST
        print('dijalanlka');
        
        await colPresence.doc(todayDocID).set({
          "date" : now.toIso8601String(),
          "masuk" : {
            "date" : now.toIso8601String(),
            "lat" : position.latitude,
            "long" : position.longitude,
            "address" : address,
            "status" :status,
            "distance" : distance
          }
        });

      Get.snackbar("Sukses", "Absen masuk anda sudah disimpan");
      }

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
