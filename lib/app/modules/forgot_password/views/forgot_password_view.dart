import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence_app/app/constant/colors.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainRed,
        title: Text('Forgot Password'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(
            height: Get.height - context.mediaQueryPadding.top,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  autocorrect: false,
                  controller: controller.emailC,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: double.infinity,
                  child: Obx(() => 
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: mainRed,
                          padding: const EdgeInsets.symmetric(vertical: 20)),
                      onPressed: () async {
                        if (controller.isLoading.isFalse) {
                          await controller.sendEmail();
                        }
                      },
                      child: Text(
                        controller.isLoading.isFalse ? 'Send Reset Password' : 'Loading...',
                        style: const TextStyle(fontSize: 17),
                      )
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
