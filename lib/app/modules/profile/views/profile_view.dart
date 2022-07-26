import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence_app/app/constant/colors.dart';
import 'package:presence_app/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainRed,
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            color: lightGrey,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: controller.streamUser(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  if(snapshot.hasData){
                    Map<String, dynamic> user = snapshot.data!.data()!;
                    // print(user);
                    return Column(
                      children: [
                        ClipOval(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              user["photo"] != null && user["photo"] != ""
                              ? user["photo"]
                              : "https://ui-avatars.com/api/?name=${user['name']}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Text(
                          user['name'].toString().toUpperCase(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        ListTile(
                          onTap: () => Get.toNamed(
                            Routes.UPDATE_PROFILE,
                            arguments: user // passing data
                          ),
                          leading: const Icon(Icons.person),
                          title: const Text("Update Profile"),
                        ),
                        ListTile(
                          onTap: () => Get.toNamed(Routes.UPDATE_PASSWORD),
                          leading: const Icon(Icons.key),
                          title: const Text("Update Password"),
                        ),
                        ListTile(
                          onTap: () => controller.logout(),
                          leading: const Icon(Icons.logout),
                          title: const Text("Logout"),
                        ),
                        if(user["role"] == "admin")
                          ListTile(
                            onTap: () => Get.toNamed(Routes.ADD_PEGAWAI),
                            leading: const Icon(Icons.person_add),
                            title: const Text("Add Pegawai"),
                          ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Card(
                        child: Column(
                          children: [
                            const Text('Tidak dapat memuat data')
                          ]
                        ),
                      ),
                    );
                  }
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
