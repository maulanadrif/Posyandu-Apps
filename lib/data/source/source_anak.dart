import 'package:d_info/d_info.dart';
import 'package:posyandu_apps/config/api.dart';
import 'package:posyandu_apps/config/app_request.dart';
import 'package:posyandu_apps/data/model/anak.dart';

class SourceAnak {
  static Future<bool> add(
      String idUser,
      String nik,
      String namaLengkap,
      String namaPanggilan,
      String jenisKelamin,
      String tglLahir,
      String alamat) async {
    String url = '${Api.anak}/add.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'nik': nik,
      'nama_lengkap': namaLengkap,
      'nama_panggilan': namaPanggilan,
      'jenis_kelamin': jenisKelamin,
      'tgl_lahir': tglLahir,
      'alamat': alamat,
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess('Berhasil Tambah Data');
      DInfo.closeDialog();
    } else {
      if (responseBody['message'] == 'nik') {
        DInfo.dialogError('NIK Sudah Terdaftar');
      } else {
        DInfo.dialogError('Gagal Tambah Data');
      }
      DInfo.closeDialog();
    }

    return responseBody['success'];
  }

  static Future<List<Anak>> dataAnak(String idUser) async {
    String url = '${Api.anak}/data_anak.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
    });

    if (responseBody == null) return [];

    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => Anak.fromJson(e)).toList();
    }

    return [];
  }

  static Future<List<Anak>> dataAnakAll() async {
    String url = '${Api.anak}/data_anak_all.php';
    Map? responseBody = await AppRequest.gets(url);

    if (responseBody == null) return [];

    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => Anak.fromJson(e)).toList();
    }

    return [];
  }

  static Future<Anak?> wherenama(String idUser, String namaLengkap) async {
    String url = '${Api.anak}/where_nama.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'nama_lengkap': namaLengkap,
    });

    if (responseBody == null) return null;

    if (responseBody['success']) {
      var e = responseBody['data'];
      return Anak.fromJson(e);
    }

    return null;
  }

  static Future<bool> update(
      String idAnak,
      String idUser,
      String namaLengkap,
      String namaPanggilan,
      String jenisKelamin,
      String tglLahir,
      String alamat) async {
    String url = '${Api.anak}/update.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_anak': idAnak,
      'id_user': idUser,
      'nama_lengkap': namaLengkap,
      'nama_panggilan': namaPanggilan,
      'jenis_kelamin': jenisKelamin,
      'tgl_lahir': tglLahir,
      'alamat': alamat,
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess('Berhasil Update Data');
      DInfo.closeDialog();
    } else {
      if (responseBody['message'] == 'nik') {
        DInfo.dialogError('NIK Sudah Terdaftar');
      } else {
        DInfo.dialogError('Gagal Update Data');
      }
      DInfo.closeDialog();
    }

    return responseBody['success'];
  }

  static Future<bool> delete(String idAnak) async {
    String url = '${Api.anak}/delete.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_anak': idAnak,
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess('Berhasil Hapus Data');
      DInfo.closeDialog();
    }

    return responseBody['success'];
  }

  static Future<Map?> getChart(String idAnak) async {
    String url = '${Api.anak}/chart_pemeriksaan.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_anak': idAnak,
    });

    if (responseBody == null) return null;

    if (responseBody['success']) {
      return responseBody['data'];
    }

    return null;
  }

  static Future<bool> addDataPemeriksaan(
      String idAnak,
      String tglPemeriksaan,
      String beratBadan,
      String tinggiBadan,
      String lingkarKepala,
      String lingkarLengan) async {
    String url = '${Api.anak}/add_data_pemeriksaan.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_anak': idAnak,
      'tgl_pemeriksaan': tglPemeriksaan,
      'berat_badan': beratBadan,
      'tinggi_badan': tinggiBadan,
      'lingkar_kepala': lingkarKepala,
      'lingkar_lengan': lingkarLengan
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess('Berhasil Tambah Data');
      DInfo.closeDialog();
    } else {
      String? message = responseBody['message'];
      if (message != null) {
        DInfo.dialogError(message);
      } else {
        DInfo.dialogError('Gagal Tambah Data');
      }
      DInfo.closeDialog();
    }

    return responseBody['success'];
  }

  static Future<List<Map>> pemeriksaanWheredate(String date) async {
    String url = '${Api.anak}/pemeriksaan_wheredate.php';
    Map? responseBody = await AppRequest.post(url, {
      'date': date,
    });

    if (responseBody == null) return [];

    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => Map.from(e)).toList();
    }

    return [];
  }

  static Future<Map> getPemeriksaan(
      String idAnak, String idUser, String tglPemeriksaan) async {
    String url = '${Api.anak}/get_data_pemeriksaan.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_anak': idAnak,
      'id_user': idUser,
      'tgl_pemeriksaan': tglPemeriksaan,
    });

    if (responseBody == null) return {};

    if (responseBody['success']) {
      return responseBody;
    }

    return {};
  }

  static Future<bool> updateDataPenimbangan(
      String idPemeriksaan,
      String idAnak,
      String tglPemeriksaan,
      String beratBadan,
      String tinggiBadan,
      String lingkarKepala,
      String lingkarLengan) async {
    String url = '${Api.anak}/update_data_pemeriksaan.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_pemeriksaan': idPemeriksaan,
      'id_anak': idAnak,
      'tgl_pemeriksaan': tglPemeriksaan,
      'berat_badan': beratBadan,
      'tinggi_badan': tinggiBadan,
      'lingkar_kepala': lingkarKepala,
      'lingkar_lengan': lingkarLengan
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess('Berhasil Update Data');
      DInfo.closeDialog();
    } else {
      if (responseBody['message'] == 'nik') {
        DInfo.dialogError('NIK Sudah Terdaftar');
      } else {
        DInfo.dialogError('Gagal Update Data');
      }
      DInfo.closeDialog();
    }

    return responseBody['success'];
  }

  static Future<bool> deleteDataPemeriksaan(String idPemeriksaan) async {
    String url = '${Api.anak}/delete_data_pemeriksaan.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_pemeriksaan': idPemeriksaan,
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess('Berhasil Hapus Data');
      DInfo.closeDialog();
    }

    return responseBody['success'];
  }
}
