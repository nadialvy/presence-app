// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence_app/app/constant/colors.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SizedBox(
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Anda harus mengubah password anda terlebih dahulu!',
                  style: TextStyle(color: mainRed),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: controller.newPassC,
                  obscureText: true,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Obx(() => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: mainRed,
                          padding: const EdgeInsets.symmetric(vertical: 20)),
                      onPressed: () {
                        controller.newPassword();
                      },
                      child: Text(
                        controller.isLoading.isFalse
                            ? 'Ubah Password'
                            : 'Loading...',
                        style: TextStyle(fontSize: 17),
                      ))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
