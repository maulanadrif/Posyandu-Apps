import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';

class CDataPemeriksaan extends GetxController {
  final _tgl = AppFormat.justdate(DateTime.now()).obs;
  String get tgl => _tgl.value;
  set tgl(String n) => _tgl.value = n;

  final beratBadan = TextEditingController();
  final tinggiBadan = TextEditingController();
  final lingkarKepala = TextEditingController();
  final lingkarLengan = TextEditingController();
  submit(String idAnak) {
    SourceAnak.addDataPemeriksaan(idAnak, tgl, beratBadan.text,
        tinggiBadan.text, lingkarKepala.text, lingkarLengan.text);
  }
}
