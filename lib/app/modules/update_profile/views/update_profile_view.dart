import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence_app/app/constant/colors.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final Map<String, dynamic> user = Get.arguments;
  
  @override
  Widget build(BuildContext context) {
  print(user);
    controller.nipC.text = user['nip'];
    controller.nameC.text = user['name'];
    controller.emailC.text = user['email'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainRed,
        title: const Text('Update Profile'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            readOnly: true,
            autocorrect: false,
            controller: controller.nipC,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: "NIP"),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            autocorrect: false,
            controller: controller.nameC,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: "Name"),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            readOnly: true,
            autocorrect: false,
            controller: controller.emailC,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: "Email"),
          ),
          const SizedBox(
            height: 30,
          ),
          Obx(() => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.updateProfile(user['uid']);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(mainRed),
              ),
              child: Text(
                  controller.isLoading.isFalse ? 'Update Profile' : 'Loading...')
            )
          )
        ],
      ),
    );
  }
}