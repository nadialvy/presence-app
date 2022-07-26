import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence_app/app/constant/colors.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final Map<String, dynamic> user = Get.arguments;
  
  @override
  Widget build(BuildContext context) {
  // print(user);
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
          Column(
            children: [
              GetBuilder<UpdateProfileController>(
                builder: (c){
                  if(c.image != null){
                    return ClipOval(
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Image.file(
                          File(c.image!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }else {
                    if(user["photo"] != null && user["photo"] != ""){
                      return ClipOval(
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image.network(
                            user["photo"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else {
                      return Text('No Image choosen');
                    }
                  }
                },
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                    onPressed: (){
                      controller.pickImage();
                    },
                    child: const Text(
                      'Choose photo',
                      style: TextStyle(
                        color: mainRed
                      ),
                    )
                  ),
                  OutlinedButton(
                    onPressed: (){
                      controller.deleteImage(user["uid"]);
                    },
                    child: const Text(
                      'Remove photo',
                      style: TextStyle(
                        color: mainRed
                      ),
                    )
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 30,),
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
