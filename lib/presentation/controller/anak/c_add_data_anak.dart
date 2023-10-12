import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CAddDataAnak extends GetxController {
  final _nik = ''.obs;
  String get nik => _nik.value;
  setNik(n) => _nik.value = n;

  final _fullname = ''.obs;
  String get fullname => _fullname.value;
  setFullname(n) => _fullname.value = n;

  final _nickname = ''.obs;
  String get nickname => _nickname.value;
  setNickname(n) => _nickname.value = n;

  final _gender = 'Laki-Laki'.obs;
  String get gender => _gender.value;
  setGender(n) => _gender.value = n;

  final _birth = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  String get birth => _birth.value;
  setBirth(n) => _birth.value = n;

  final _alamat = ''.obs;
  String get alamat => _alamat.value;
  setAlamat(n) => _alamat.value = n;
}