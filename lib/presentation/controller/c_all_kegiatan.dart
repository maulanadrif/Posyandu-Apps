import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/data/model/anak.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/data/source/source_user.dart';

class CAllKegiatan extends GetxController {
  // final SourceUser _sourceUser;

  final _loading = false.obs;
  bool get loading => _loading.value;

  // CAllKegiatan(this._sourceUser);

  final _list = <Map>[].obs;
  List<Map> get list => _list;

  getList() async {
    _loading.value = true;

    _list.value = await SourceUser.getAllKegiatan();
    // final presensiPetugas = await SourceUser.presensiPetugas(idUser);
    // final listKegiatan = presensiPetugas.map((e) => e['id_kegiatan']).toList();
    // List<Map> newList = [];

    // final kegiatans = await SourceUser.getAllKegiatan();
    // for (var element in kegiatans) {
    //   Map newElement = element;
    //   newElement['Hadir'] = listKegiatan.contains(element['id_kegiatan']);
    //   newList.add(newElement);
    // }
    // _list.value = newList;

    _loading.value = false;
  }
}
