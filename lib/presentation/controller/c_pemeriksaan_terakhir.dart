import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/data/model/anak.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/data/source/source_user.dart';

class CPemeriksaanTerakhir extends GetxController {
  final _loading = false.obs;
  bool get loading => _loading.value;

  final _list = <Map>[].obs;
  List<Map> get list => _list;

  getList(idUser) async {
    _loading.value = true;

    _list.value = await SourceUser.getPemeriksaanTerakhir(idUser);

    _loading.value = false;
  }
}
