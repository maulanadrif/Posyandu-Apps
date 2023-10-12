import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:posyandu_apps/data/model/anak.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';

class CUpdateDataAnak extends GetxController {
  final _nik = 'nik'.obs;
  String get nik => _nik.value;
  setNik(n) => _nik.value = n;

  final _fullname = 'nama_lengkap'.obs;
  String get fullname => _fullname.value;
  setFullname(n) => _fullname.value = n;

  final _nickname = 'nama_panggilan'.obs;
  String get nickname => _nickname.value;
  setNickname(n) => _nickname.value = n;

  final _gender = 'Laki-Laki'.obs;
  String get gender => _gender.value;
  setGender(n) => _gender.value = n;

  final _birth = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  String get birth => _birth.value;
  setBirth(n) => _birth.value = n;

  final _alamat = 'alamat'.obs;
  String get alamat => _alamat.value;
  setAlamat(n) => _alamat.value = n;

  init(idUser, namaLengkap) async {
    Anak? anak = await SourceAnak.wherenama(idUser, namaLengkap);
    if(anak != null) {
      setFullname(anak.namaLengkap);
      setNickname(anak.namaPanggilan);
      setGender(anak.jenisKelamin);
      setBirth(anak.tglLahir);
      setAlamat(anak.alamat);
    }
  }
}