import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  final ImagePicker picker = ImagePicker();
  XFile? image;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  void pickImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image != null){
      print(image!.name); //name image
      print(image!.name.split(".").last); //image extension
      print(image!.path); //image path
    }else {
      print(image); //null
    }
    update();
  }

  Future<void> updateProfile(String uid) async{
    if(nipC.text.isNotEmpty && nameC.text.isNotEmpty && emailC.text.isNotEmpty){
    isLoading.value = true;
      try{
        Map<String, dynamic> data = {
          "name" : nameC.text,
        };
        if(image != null){          
          File file = File(image!.path);
          String extensionImage = image!.name.split(".").last;

          await storage.ref('$uid/profile.$extensionImage').putFile(file);
          String urlImage = await storage.ref('$uid/profile.$extensionImage').getDownloadURL();

          data.addAll({"photo" : urlImage}); 
        }

        await firestore.collection("pegawai").doc(uid).update(data);

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
