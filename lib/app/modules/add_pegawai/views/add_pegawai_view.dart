import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence_app/app/routes/app_pages.dart';

import '../controllers/add_pegawai_controller.dart';

class AddPegawaiView extends GetView<AddPegawaiController> {
  const AddPegawaiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Pegawai'),
        centerTitle: true,
        leading: (
          IconButton(
            onPressed: () => Get.toNamed(Routes.HOME),
            icon: Icon(Icons.arrow_back_ios)
          )
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.nipC,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "NIP"
            ),
          ),
          SizedBox(height: 20,),
          TextField(
            controller: controller.nameC,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Name"
            ),
          ),
          SizedBox(height: 20,),
          TextField(
            controller: controller.emailC,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Email"
            ),
          ),
          SizedBox(height: 30,),
          ElevatedButton(
            onPressed: (){
              controller.addPegawai();
            },
            child: Text('Add Pegawai')
          )
        ],
      ),
    );
  }
}
