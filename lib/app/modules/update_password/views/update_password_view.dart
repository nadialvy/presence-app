import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence_app/app/constant/colors.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainRed,
        title: Text('Update Password'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            // obscureText: true,
            autocorrect: false,
            controller: controller.currentPassC,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Current Password"
            ),
          ),
          SizedBox(height: 20,),
          TextField(
            // obscureText: true,
            autocorrect: false,
            controller: controller.newPassC,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "New Password"
            ),
          ),
          SizedBox(height: 20,),
          TextField(
            // obscureText: true,
            autocorrect: false,
            controller: controller.confirmationPassC,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Confirmation Password"
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Obx(() => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.updatePassword();
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(mainRed),
              ),
              child: Text(
                  controller.isLoading.isFalse ? 'Update Password' : 'Loading...')
            )
          )
        ],
      ),
    );
  }
}
