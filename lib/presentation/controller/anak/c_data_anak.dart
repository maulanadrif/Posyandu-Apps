import 'package:get/get.dart';
import 'package:posyandu_apps/data/model/anak.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';

class CDataAnak extends GetxController {
  final _loading = false.obs;
  bool get loading => _loading.value;

  final _list = <Anak>[].obs;
  List<Anak> get list => _list.value;

  getList(idUser) async {
    _loading.value = true;
    update();

    _list.value = await SourceAnak.dataAnak(idUser);
    update();

    Future.delayed(const Duration(microseconds: 2000), () {
      _loading.value = false;
      update();
    });
  }

  getListAll() async {
    _loading.value = true;
    update();

    _list.value = await SourceAnak.dataAnakAll();
    update();

    Future.delayed(const Duration(microseconds: 2000), () {
      _loading.value = false;
      update();
    });
  }
}