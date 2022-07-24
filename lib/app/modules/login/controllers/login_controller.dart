import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            if(passC.text == 'password123'){
              Get.offAllNamed(Routes.NEW_PASSWORD);
            }else {
              Get.offAllNamed(Routes.HOME);
            }
          }else {
            Get.defaultDialog(
              title: "Belum Terverifikasi",
              middleText: "Anda belum terverifikasi. Lakukan verifikasi di email yang terdaftar",
              actions: [
                OutlinedButton(
                  onPressed: () => Get.back(),
                  child: Text('Batal')
                ),
                ElevatedButton(
                  onPressed: () async{
                    try{
                      await userCredential.user!.sendEmailVerification();
                      Get.back();
                      Get.snackbar("Berhasil", 'Email verifikasi sudah dikirim');
                      
                    } catch (e){
                      Get.snackbar("Terjadi kesalahan", 'Tidak dapat mengirim email verifikasi, hubungi admin');
                    }
                  },
                  child: Text('Kirim ulang verifikasi'),
                ),
              ],
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
