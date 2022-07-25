// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence_app/app/constant/colors.dart';
import 'package:presence_app/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainRed,
        title: Text(
          'Siakad',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.PROFILE),
            icon: Icon(Icons.person)
          )
          // StreamBuilder <DocumentSnapshot<Map<String, dynamic>>>(
          //   stream: controller.streamRole(),
          //   builder: (context, snapshot) {
          //     if(snapshot.connectionState == ConnectionState.waiting){
          //       return SizedBox();
          //     }
          //     //ambil role
          //     String role = snapshot.data!.data()!["role"];
          //     if(role == "admin"){
          //       // admin
          //       return IconButton(
          //         onPressed: () => Get.toNamed(Routes.ADD_PEGAWAI),
          //         icon: Icon(Icons.person_add)
          //       );
          //     }else {
          //       // pegawia
          //       return SizedBox();
          //     }
          //   }
          // )
        ],
      ),
      body: Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: Obx(() => FloatingActionButton(
            backgroundColor: mainRed,
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                controller.isLoading.value = true;
                await FirebaseAuth.instance.signOut();
                Get.offAllNamed(Routes.LOGIN);
                controller.isLoading.value = false;
              }
            },
            child: controller.isLoading.isFalse
                ? Icon(Icons.logout)
                : CircularProgressIndicator(),
          )
      ),
    );
  }
}
