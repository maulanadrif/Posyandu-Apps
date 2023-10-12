import 'package:get/get.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';

class CDetailDataPenimbangan extends GetxController{
  final RxMap _anak = {}.obs;
  Map get anak => _anak.value;
  set anak (Map n) => _anak.value = n;

  final RxMap _ortu = {}.obs;
  Map get ortu => _ortu.value;
  set ortu (Map n) => _ortu.value = n;
  
  final RxMap _pemeriksaan = {}.obs;
  Map get pemeriksaan => _pemeriksaan.value;
  set pemeriksaan (Map n) => _pemeriksaan.value = n;

  getDataPemeriksaan(idAnak, idUser, tglPemeriksaan) {
    SourceAnak.getPemeriksaan(idAnak, idUser, tglPemeriksaan).then((value) {
      anak = value['anak'];
      ortu = value['ortu'];
      pemeriksaan = value['pemeriksaan'];
    });
  }
}