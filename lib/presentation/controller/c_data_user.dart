import 'package:get/get.dart';
import 'package:posyandu_apps/data/model/user.dart';
import 'package:posyandu_apps/data/source/source_user.dart';

class CDataUser extends GetxController {
  final _loading = false.obs;
  bool get loading => _loading.value;

  final _list = <User>[].obs;
  List<User> get list => _list.value;

  getList(idUser, role) async {
    _loading.value = true;
    update();

    _list.value = await SourceUser.datauser(role);
    update();

    Future.delayed(const Duration(microseconds: 2000), () {
      _loading.value = false;
      update();
    });
  }

  search(idUser, role, nama) async {
    _loading.value = true;
    update();

    _list.value = await SourceUser.datausersearch(role, nama);
    update();

    Future.delayed(const Duration(microseconds: 2000), () {
      _loading.value = false;
      update();
    });
  }
}