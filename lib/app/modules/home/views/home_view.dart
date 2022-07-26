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
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              ClipOval(
                child: Container(
                  width: 70,
                  height: 70,
                  color: Colors.grey[300],
                  child: Center(child: Text('X')),
                ),
              ),
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Selamat datang!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text('Jl. Raya Danau Kelinci')
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
                  'Admin',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10,),
                Text('1213165615'),
                Text('January Dahlah'),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('Masuk'),
                    Text('-'),
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
                    Text('-'),
                  ]
                ),
              ],
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
                onPressed: (){},
                child: Text('See more')
              ),
            ],
          ),
          SizedBox(height: 10,),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200],
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
                          '${DateFormat.yMMMEd().format(DateTime.now())}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    Text('${DateFormat.jms().format(DateTime.now())}'),
                    SizedBox(height: 10,),
                    Text(
                      'Keluar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text('${DateFormat.jms().format(DateTime.now())}'),
                  ],
                ),
              );
            },
          )
        ],
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
