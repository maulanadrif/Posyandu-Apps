import 'package:get/get.dart';
import 'package:posyandu_apps/data/source/source_user.dart';

class CAdmin extends GetxController {
  final RxMap _kegiatan = {}.obs;
  Map get kegiatan => _kegiatan.value;
  set kegiatan(Map n) => _kegiatan.value = n;

  getKegiatan() {
    SourceUser.getKegiatan().then((value) {
      kegiatan = value ?? {};
    });
  }

  final _loading = false.obs;
  bool get loading => _loading.value;

  final _list = <Map>[].obs;
  List<Map> get list => _list;

  getList(idUser) async {
    _loading.value = true;

    _list.value = await SourceUser.presensiPetugasLimit(idUser);

    _loading.value = false;
  }
}
