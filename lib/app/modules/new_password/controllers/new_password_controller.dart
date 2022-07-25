import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:presence_app/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController newPassC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void newPassword() async{
    if(newPassC.text.isNotEmpty){
      if(newPassC.text != 'password123'){
        try{
          await auth.currentUser!.updatePassword(newPassC.text);

          await auth.signOut();

          Get.offAllNamed(Routes.LOGIN);
        } on FirebaseAuthException catch (e){
          if(e.code == 'weak-password'){
            Get.snackbar("Terjadi kesalahan", 'Password minimal 6 karakter');
          }
        } catch (e){
            Get.snackbar("Terjadi kesalahan", 'Tidak dapat membuat password baru, hubungi admin');
        }
      }else {
        Get.snackbar("Terjadi Kesalahan", "Password baru harus berbeda dengan default password");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Password baru harus diisi");
    }
  }
}
