import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence_app/app/constant/colors.dart';
import 'package:presence_app/app/routes/app_pages.dart';

import '../controllers/all_presensi_controller.dart';

class AllPresensiView extends GetView<AllPresensiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainRed,
        title: Text('All Presensi'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              elevation: 5,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 20, right: 20),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Material(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () => Get.toNamed(Routes.DETAIL_PRESENSI),
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
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )
    );
  }
}
