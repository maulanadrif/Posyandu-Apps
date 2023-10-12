import 'package:get/get.dart';
import 'package:posyandu_apps/data/model/user.dart';
import 'package:posyandu_apps/data/source/source_user.dart';

class CPresensi extends GetxController {
  final _loading = false.obs;
  bool get loading => _loading.value;

  final _list = [].obs;
  List get list => _list;

  getList(idKegiatan) async {
    _loading.value = true;

    _list.value = await SourceUser.presensi(idKegiatan);

    Future.delayed(const Duration(microseconds: 2000), () {
      _loading.value = false;
    });
  }
}