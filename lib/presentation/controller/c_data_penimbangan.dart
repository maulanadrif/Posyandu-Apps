import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/data/model/anak.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';

class CDataPenimbangan extends GetxController {
  final _loading = false.obs;
  bool get loading => _loading.value;

  final _list = <Map>[].obs;
  List<Map> get list => _list;

  final _datePick = DateTime.now().obs;
  DateTime get datePick => _datePick.value;
  set datePick(DateTime n) => _datePick.value = n;

  getList() async {
    _loading.value = true;

    _list.value = await SourceAnak.pemeriksaanWheredate(AppFormat.justdate(datePick));

    _loading.value = false;
  }

  pickDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(
        DateTime.now().year + 1,
      ),
    ).then((value) {
      if(value==null) {
        return;
      }
      datePick = value;
    });
  }
}
