import 'package:get/get.dart';
import 'package:posyandu_apps/data/model/user.dart';
import 'package:posyandu_apps/data/source/source_user.dart';

class CUser extends GetxController {
  final _data = User().obs;
  User get data => _data.value;
  setData(n) => _data.value = n;

  final _role = 'Admin'.obs;
  String get role => _role.value;
  setRole(n) => _role.value = n;

  final _alamat = ''.obs;
  String get alamat => _alamat.value;
  setAlamat(n) => _alamat.value = n;

  final _nama = "".obs;
  String get nama => _nama.value;
  setNama(n) => _nama.value = n;

  final _nik = "".obs;
  String get nik => _nik.value;
  setNik(n) => _nik.value = n;

  final _password = "".obs;
  String get password => _password.value;
  setPassword(n) => _password.value = n;

  init(role, nik) async {
    User? user = await SourceUser.whereNama(role, nik);
    if (user != null) {
      setNama(user.nama);
      setNik(user.nik);
      setAlamat(user.alamat);
      setPassword(user.password);
      setRole(user.role);
    }
  }
}
