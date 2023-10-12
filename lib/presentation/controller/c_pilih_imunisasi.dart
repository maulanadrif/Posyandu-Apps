import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/data/model/anak.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/data/source/source_user.dart';

class CPilihImunisasi extends GetxController {
  final _loading = false.obs;
  bool get loading => _loading.value;

  final _list = [].obs;
  List get list => _list;

  getList(idAnak) async {
    _loading.value = true;

    _list.value = await SourceUser.pengecekanRiwayatImunisasi(idAnak);

    _loading.value = false;
  }
}
