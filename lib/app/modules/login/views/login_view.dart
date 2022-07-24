// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence_app/app/constant/colors.dart';

import '../controllers/login_controller.dart';


class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width,
                  height: Get.height * 0.25,
                  child: Image.asset('assets/images/logo.png'),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: controller.emailC,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email"
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: controller.passC,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password"
                  ),
                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: (){},
                    child: Text(
                      'Lupa password ?',
                      style: TextStyle(
                        color: mainRed
                      ),
                    )
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: mainRed,
                      padding: const EdgeInsets.symmetric(vertical: 20)
                    ),
                    onPressed: () { 
                      controller.login();
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 17
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
