import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateProfile(String uid) async{
    if(nipC.text.isNotEmpty && nameC.text.isNotEmpty && emailC.text.isNotEmpty){
    isLoading.value = true;
      try{
        firestore.collection("pegawai").doc(uid).update({
          "name" : nameC.text
        });
        Get.back();
        Get.snackbar("Sukses", "Berhasil update profile");
      
      }catch(e){
        Get.snackbar("Terjadi Kesalahan", "Gagal mengupdate profile");
      } finally{
        isLoading.value = true;
      }
    }else {
      Get.snackbar("Terjadi Kesalahan", "Anda harus mengisi semua data");
    }
  }
}
