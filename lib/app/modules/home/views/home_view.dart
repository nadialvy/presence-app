// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence_app/app/constant/colors.dart';
import 'package:presence_app/app/controllers/page_index_controller.dart';
import 'package:presence_app/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final getPut = Get.lazyPut(() => PageIndexController());
  final pageC = Get.find<PageIndexController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainRed,
        title: Text(
          'SIAKAD',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          Map<String, dynamic>? user = snapshot.data!.data();
          // print("${user!['name']}");
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Container(
                      width: 70,
                      height: 70,
                      color: Colors.grey[300],
                      child: Image.network(
                        user!['photo'] != null && user['photo'] != ""
                        ? user['photo']
                        : "https://ui-avatars.com/api/?name=${user['name']}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat datang!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Container(
                        width: 200,
                        child: Text(
                          user['position'] != null
                          ? "${user['address']}"
                          : "Belum ada lokasi",
                          style: TextStyle(
                            fontSize: 12
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${user['job']}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("${user['nip']}"),
                    Text("${user['name']}"),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>> (
                  stream: controller.streamTodayPresence(),
                  builder: (context, snapshotToday) {
                    if(snapshotToday.connectionState == ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    Map<String, dynamic>? todayPresence = snapshotToday.data?.data();
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text('Masuk'),
                            Text(
                              todayPresence?['masuk'] == null 
                              ? '-'
                              : DateFormat.jms().format(DateTime.parse(todayPresence?['masuk']['date']))
                            ),
                          ]
                        ),
                        Container(
                          width: 2,
                          height: 40,
                          color: darkGrey,
                        ),
                        Column(
                          children: [
                            Text('Keluar'),
                            Text(
                              todayPresence?['keluar'] == null 
                              ? '-'
                              : DateFormat.jms().format(DateTime.parse(todayPresence?['keluar']['date']))
                            ),
                          ]
                        ),
                      ],
                    );
                  }
                ),
              ),
              SizedBox(height: 20,),
              Divider(
                color: darkGrey,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Last 5 days'
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.ALL_PRESENSI),
                    child: Text('See more')
                  ),
                ],
              ),
              SizedBox(height: 10,),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.streamLast5Presence(),
                builder: (context, snapPresence) {
                  if(snapPresence.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(snapPresence.data!.docs.isEmpty){
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[200],
                      ),
                      child: Text(
                        "Belum ada history presensi!",
                        style: TextStyle(
                          color: mainRed,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  // print(snapPresence.data!.docs);
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapPresence.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> last5Presence = snapPresence.data!.docs[index].data();
                    
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Material(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () => Get.toNamed(Routes.DETAIL_PRESENSI, arguments: last5Presence),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Masuk',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        '${DateFormat.yMMMEd().format(DateTime.parse(last5Presence['date']))}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${last5Presence['masuk']?['date'] == null 
                                    ? "-"
                                    : DateFormat.jms().format(DateTime.parse(last5Presence['masuk']['date'])) } '
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    'Keluar',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                    '${last5Presence['keluar']?['date'] == null 
                                    ? "-"
                                    : DateFormat.jms().format(DateTime.parse(last5Presence['keluar']['date'])) } '
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              )
            ],
          );
        }
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixedCircle,
        backgroundColor: mainRed,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.fingerprint, title: 'Add'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: pageC.pageIndex.value,//optional, default as 0
        onTap: (int i) => pageC.changePage(i),
      )
    );
  }
}
