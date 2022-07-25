import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> sendEmail() async{
    isLoading.value = true;
    try{
      if(emailC.text.isNotEmpty){
        await auth.sendPasswordResetEmail(email: emailC.text);
        Get.snackbar("Sukses", "Email reset password sudah terkirim");
        Get.back();
      } else {
        Get.snackbar("Terjadi Kesalahan", "Email harus diisi");
      }
    }catch(e){
      Get.snackbar("Terjadi Kesalahan", "Tidak dapat mengirim email reset password");
    }finally {
      isLoading.value = false;
    }
  }
}
