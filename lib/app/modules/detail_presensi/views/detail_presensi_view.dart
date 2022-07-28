import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence_app/app/constant/colors.dart';

import '../controllers/detail_presensi_controller.dart';

class DetailPresensiView extends GetView<DetailPresensiController> {
  final Map<String, dynamic> last5Presence = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print(last5Presence['masuk']);
    print(last5Presence);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainRed,
        title: const Text('Detail Presensi'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    DateFormat.yMMMMEEEEd().format(DateTime.parse(last5Presence['date'])),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                const Text(
                  'Masuk',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "Jam : ${DateFormat.jms().format(DateTime.parse(last5Presence['masuk']!['date']))}",
                ),
                Text(
                  "Posisi : ${last5Presence['masuk']['lat']} - ${last5Presence['masuk']!['long']}",
                ),
                Text(
                  "Status : ${last5Presence['masuk']!['status']}",
                ),
                Text(
                  "Distance : ${last5Presence['masuk']!['distance'].toString().split('.').first} meter",
                ),
                Text(
                  "Alamat : ${last5Presence['masuk']!['address']}",
                ),
                const SizedBox(height: 20,),
                const Text(
                  'Keluar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  last5Presence['keluar'] == null
                  ? "Jam : - "
                  : "Jam : ${DateFormat.jms().format(DateTime.parse(last5Presence['keluar']!['date']))}",
                ),
                Text(
                  last5Presence['keluar'] == null
                  ? "Posisi : -"
                  : "Posisi :${last5Presence['masuk']['lat']} - ${last5Presence['masuk']!['long']}",
                ),
                Text(
                  last5Presence['keluar'] == null
                  ? "Status : - "
                  : "Status : ${last5Presence['masuk']!['status']}",
                ),
                Text(
                  last5Presence['keluar'] == null
                  ? "Distance : - "
                  : "Distance : ${last5Presence['masuk']!['distance'].toString().split('.').first} meter",
                ),
                Text(
                  last5Presence['keluar'] == null
                  ? "Address : - "
                  : "Address : ${last5Presence['masuk']!['address']}",
                ),
                const SizedBox(height: 20,),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
