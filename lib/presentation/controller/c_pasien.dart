import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/data/model/anak.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/data/source/source_user.dart';

class CPasien extends GetxController {
  final _loading = false.obs;
  bool get loading => _loading.value;

  final _list = <Map>[].obs;
  List<Map> get list => _list;

  final _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;
  set currentIndex(int n) => _currentIndex.value = n;

  final _listAnak = <String>[].obs;
  List<String> get listAnak => _listAnak;

  // final _listPemeriksaan = <Map>[].obs;
  // List<Map> get listPemeriksaan => _listPemeriksaan;

  getList(idUser) async {
    _loading.value = true;

    _list.value = await SourceUser.getPemeriksaanTerakhir(idUser);

    _listAnak.value = list.map((e) => e['nama_panggilan'].toString()).toList();

    // _listPemeriksaan.value =
    //     list.map((e) => Map.from(e['pemeriksaan'] ?? {})).toList();

    _loading.value = false;
  }
}
