// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:presence_app/app/routes/app_pages.dart';

class AddPegawaiController extends GetxController {
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? currUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  Future<void> processAddPegawai() async{
    if(passAdminC.text.isNotEmpty){  
      try{
        String emailAdmin = auth.currentUser!.email!;

        UserCredential userCredentialAdmin = await auth.signInWithEmailAndPassword(
          email: emailAdmin,
          password: passAdminC.text
        );

        UserCredential pegawaiCredential = await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: "password123"
        );
        
        if( pegawaiCredential.user != null){
          String uid = pegawaiCredential.user!.uid;

          await firestore.collection("pegawai").doc(uid).set({
            "nip" : nipC.text,
            "name" : nameC.text,
            "email" : emailC.text,
            "uid" : uid,
            "createdAt" : DateTime.now().toIso8601String(),
          });
          
          await pegawaiCredential.user?.sendEmailVerification();
          
          await auth.signOut();

          //relogin
          UserCredential userCredentialAdmin = await auth.signInWithEmailAndPassword(
            email: emailAdmin,
            password: passAdminC.text
          );   

          Get.back(); //close dialog
          Get.back(); //back home
          Get.snackbar("Sukses", "Berhasil menambahkan pegawai");
        }

        // print(pegawaiCredential);

      }
      on FirebaseAuthException catch(e){
        if(e.code == 'weak-password'){
          Get.snackbar("Terjadi kesalahan", "Password yang digunakan terlalu singkat");
        }else if (e.code == 'email-already-in-use'){
          Get.snackbar("Terjadi kesalahan", "Email sudah terdaftar, gunakan email lain");
        }else if(e.code == 'wrong-password'){
          Get.snackbar("Terjadi kesalahan", "Password salah");          
        } else {
          Get.snackbar("Terjadi kesalahan", e.code);
        }
      } catch (e){
        Get.snackbar("Terjadi kesalahan", "Tidak dapat menambahkan pegawai");
      }
    }else {
      Get.snackbar("Terjadi Kesalahan", "Password wajib diisi!");
    }
    
  }

  void addPegawai() async {
    if(nipC.text.isNotEmpty && nameC.text.isNotEmpty && emailC.text.isNotEmpty){
      Get.defaultDialog(
        title: 'Validasi Admin',
        content: Column(
          children: [
            Text('Masukkan password'),
            SizedBox(height: 10,),
            TextField(
              controller: passAdminC,
              obscureText: true,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          OutlinedButton(onPressed: () => Get.back(), child: Text('Cancel')),
          ElevatedButton(
            onPressed: ()async{
              await processAddPegawai();
            },
            child: Text('Add Pegawai')
          )
        ],
      );
      
    } else {
      Get.snackbar("Terjadi kesalahan", "Data tidak boleh kosong");
    }
  }
}
