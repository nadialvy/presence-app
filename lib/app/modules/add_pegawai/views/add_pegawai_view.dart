import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence_app/app/constant/colors.dart';
import 'package:presence_app/app/routes/app_pages.dart';

import '../controllers/add_pegawai_controller.dart';

class AddPegawaiView extends GetView<AddPegawaiController> {
  const AddPegawaiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainRed,
        title: const Text('Add Pegawai'),
        centerTitle: true,
        leading: (IconButton(
            onPressed: () => Get.toNamed(Routes.HOME),
            icon: const Icon(Icons.arrow_back_ios))),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
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
            controller: controller.emailC,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: "Email"),
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
            autocorrect: false,
            controller: controller.jobC,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: "Job"),
          ),
          const SizedBox(
            height: 30,
          ),
          Obx(() => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.addPegawai();
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(mainRed),
              ),
              child: Text(
                  controller.isLoading.isFalse ? 'Add Pegawai' : 'Loading...')
            )
          )
        ],
      ),
    );
  }
}
