import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/data/source/source_user.dart';

class CJadwalPemeriksaan extends GetxController {
  final _tgl = AppFormat.justdate(DateTime.now()).obs;
  String get tgl => _tgl.value;
  set tgl(String n) => _tgl.value = n;

  final namaKegiatan = TextEditingController();
  final tempatPelaksanaan = TextEditingController();
  final deskripsiKegiatan = TextEditingController();
  final jamPelaksanaan = TextEditingController();
  submit() {
    SourceUser.addJadwalPemeriksaan(namaKegiatan.text, tgl,
        tempatPelaksanaan.text, deskripsiKegiatan.text, jamPelaksanaan.text);
  }
}
