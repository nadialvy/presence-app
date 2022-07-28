import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence_app/app/constant/colors.dart';
import 'package:presence_app/app/routes/app_pages.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
      body: GetBuilder<AllPresensiController>(
        builder: (c) => FutureBuilder <QuerySnapshot<Map<String, dynamic>>>(
          future: controller.getAllPresence(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(snapshot.data!.docs.isEmpty){
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[200],
                  ),
                  child: const Text(
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
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> allPresence = snapshot.data!.docs[index].data();
                
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Material(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () => Get.toNamed(Routes.DETAIL_PRESENSI, arguments: allPresence),
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
                                  const Text(
                                    'Masuk',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                    DateFormat.yMMMEd().format(DateTime.parse(allPresence['date'])),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${allPresence['masuk']?['date'] == null 
                                ? "-"
                                : DateFormat.jms().format(DateTime.parse(allPresence['masuk']['date'])) } '
                              ),
                              const SizedBox(height: 10,),
                              const Text(
                                'Keluar',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                '${allPresence['keluar']?['date'] == null 
                                ? "-"
                                : DateFormat.jms().format(DateTime.parse(allPresence['keluar']['date'])) } '
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.dialog(
            Dialog(
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 400,
                child: SfDateRangePicker(
                  todayHighlightColor: mainRed,
                  selectionColor: mainRed,
                  rangeSelectionColor: mainGrey,
                  startRangeSelectionColor: mainRed,
                  endRangeSelectionColor: mainRed,

                  showActionButtons: true,
                  onCancel: () => Get.back(),
                  onSubmit: (obj) {
                    if(obj != null){
                      if((obj as PickerDateRange).endDate != null){
                        controller.pickDate(obj.startDate!, obj.endDate!);
                      }
                    }
                  },

                  monthViewSettings: const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                  selectionMode: DateRangePickerSelectionMode.range,
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.format_list_bulleted_rounded),
        backgroundColor: mainRed,
      ),
    );
  }
}
