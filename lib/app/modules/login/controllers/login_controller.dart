import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:presence_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void login() async {
    if(emailC.text.isNotEmpty && passC.text.isNotEmpty){
      try{
        UserCredential userCredential = 
          await auth.signInWithEmailAndPassword(
            email: emailC.text,
            password: passC.text
          );
        print(userCredential);

        if(userCredential.user != null){
          if(userCredential.user!.emailVerified == true){
            Get.offAllNamed(Routes.HOME);
          }else {
            Get.defaultDialog(
              title: "Belum Terverifikasi",
              middleText: "Anda belum terverifikasi. Lakukan verifikasi di email yang terdaftar"
            );
          }
        }

      } on FirebaseAuthException catch(e){
        if(e.code == 'user-not-found'){
          Get.snackbar("Terjadi kesalahan", 'User tidak ditemukan');
        } else if (e.code == 'wrong-password'){
          Get.snackbar("Terjadi kesalahan", "Password salah");
        }
      } catch(e){
        Get.snackbar("Terjadi kesalahan", "Tidak dapat login");

      }
    }else {
      Get.snackbar("Terjadi kesalahan", "Email dan password harus diisi");
    }
  }

}
