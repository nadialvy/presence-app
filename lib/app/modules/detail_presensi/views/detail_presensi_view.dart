import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence_app/app/constant/colors.dart';

import '../controllers/detail_presensi_controller.dart';

class DetailPresensiView extends GetView<DetailPresensiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainRed,
        title: Text('Detail Presensi'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    DateFormat.yMMMMEEEEd().format(DateTime.now()),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  'Masuk',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "Jam : ${DateFormat.jms().format(DateTime.now())}",
                ),
                Text(
                  "Posisi : -6,3562371 , 45.19138",
                ),
                Text(
                  "Status : Didalam area",
                ),
                SizedBox(height: 20,),
                Text(
                  'Keluar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "Jam : ${DateFormat.jms().format(DateTime.now())}",
                ),
                Text(
                  "Posisi : -6,3562371 , 45.19138",
                ),
                Text(
                  "Status : Didalam area",
                ),
                SizedBox(height: 20,),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
