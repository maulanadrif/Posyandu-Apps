import 'package:get/get.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';

class CDetailDataAnak extends GetxController{
  final RxMap _chart_pemeriksaan = {}.obs;
  Map get chart_pemeriksaan => _chart_pemeriksaan.value;
  set chart_pemeriksaan (Map n) => _chart_pemeriksaan.value = n;

  getChartPemeriksaan(idAnak) {
    SourceAnak.getChart(idAnak).then((value) {
      if(value != null) {
        chart_pemeriksaan = value;
      }
    });
  }

  final _tglLahir = DateTime.now().obs;
  DateTime get tglLahir => _tglLahir.value;
  set tglLahir (DateTime n) {
    _tglLahir.value = n;
  }
}