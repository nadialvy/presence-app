import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController currentPassC = TextEditingController();
  TextEditingController newPassC = TextEditingController();
  TextEditingController confirmationPassC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> updatePassword() async{
    if(currentPassC.text.isNotEmpty && newPassC.text.isNotEmpty && confirmationPassC.text.isNotEmpty ){
      if(newPassC.text == confirmationPassC.text ){
        isLoading.value = true;
        try{
          String emailUser = auth.currentUser!.email!;

          await auth.signInWithEmailAndPassword(email: emailUser, password: currentPassC.text);

          await auth.currentUser!.updatePassword(newPassC.text);
          Get.back();
          Get.snackbar("Sukses", "Berhasil mengubah password");
        } on FirebaseAuthException catch(e){
          if(e.code == "wrong-password"){
            Get.snackbar("Terjadi Kesalahan", "Password salah");
          } else {
            Get.snackbar("Terjadi Kesalahan", e.code.toLowerCase());
          }
        } catch (e){
          Get.snackbar("Terjadi Kesalahan", "Tidak dapat mengganti password");
        } finally{
          isLoading.value = false;
        }
      }else {
        Get.snackbar("Terjadi Kesalahan", "Konfirmasi password tidak coock");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Anda harus mengisi semua input");
    }
  }
}
