import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:presence_app/app/routes/app_pages.dart';

class AddPegawaiController extends GetxController {
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? currUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  

  void addPegawai() async {
    if(nipC.text.isNotEmpty && nameC.text.isNotEmpty && emailC.text.isNotEmpty){
      try{
        UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: "password123"
        );
        
        if( userCredential.user != null){
          String uid = userCredential.user!.uid;

          await firestore.collection("pegawai").doc(uid).set({
            "nip" : nipC.text,
            "name" : nameC.text,
            "email" : emailC.text,
            "uid" : uid,
            "createdAt" : DateTime.now().toIso8601String(),
          });
          
          await userCredential.user?.sendEmailVerification();
          // userCredential.user?.emailVerified ?? Get.snackbar("Verifikasi email", "Verifikasi akun anda pada email yang sudah terkirim!");
          
        }

        print(userCredential);

      }
      on FirebaseAuthException catch(e){
        if(e.code == 'weak-password'){
          Get.snackbar("Terjadi kesalahan", "Password yang digunakan terllau singkat");
        }else if (e.code == 'email-already-in-use'){
          Get.snackbar("Terjadi kesalahan", "Email sudah terdaftar, gunakan email lain");
        }
      } catch (e){
        Get.snackbar("Terjadi kesalahan", "Tidak dapat menambahkan pegawai");
      }
    } else {
      Get.snackbar("Terjadi kesalahan", "Data tidak boleh kosong");
    }
  }
}
