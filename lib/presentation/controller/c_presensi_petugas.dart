import 'package:get/get.dart';
import 'package:posyandu_apps/data/source/source_user.dart';

class CPresensiPetugas extends GetxController {
  final _loading = false.obs;
  bool get loading => _loading.value;

  final _list = <Map>[].obs;
  List<Map> get list => _list;

  getList(idUser) async {
    _loading.value = true;

    _list.value = await SourceUser.presensiPetugas(idUser);

    _loading.value = false;
  }
}
