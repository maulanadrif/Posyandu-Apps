import 'dart:convert';

import 'package:d_info/d_info.dart';
import 'package:posyandu_apps/config/api.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/config/app_request.dart';
import 'package:posyandu_apps/config/session.dart';

import '../model/user.dart';

class SourceUser {
  static Future<bool> login(String nik, String password) async {
    String url = '${Api.user}/login.php';
    Map? responseBody = await AppRequest.post(url, {
      'nik': nik,
      'password': password,
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      var mapUser = responseBody['data'];
      Session.saveUser(User.fromJson(mapUser));
    }

    return responseBody['success'];
  }

  static Future<bool> register(String nik, String nama, String alamat,
      String password, String role) async {
    String url = '${Api.user}/register.php';
    Map? responseBody = await AppRequest.post(url, {
      'nik': nik,
      'nama': nama,
      'alamat': alamat,
      'password': password,
      'role': role
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess('Berhasil Register');
      DInfo.closeDialog();
    } else {
      if (responseBody['message'] == 'nik') {
        DInfo.dialogError('NIK Sudah Terdaftar');
      } else {
        DInfo.dialogError('Gagal Register');
      }
      DInfo.closeDialog();
    }

    return responseBody['success'];
  }

  static Future<List<User>> datauser(String role) async {
    String url = '${Api.user}/data_user.php';
    Map? responseBody = await AppRequest.post(url, {'role': role});

    if (responseBody == null) return [];

    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => User.fromJson(e)).toList();
    }

    return [];
  }

  static Future<List<User>> datausersearch(String role, String nama) async {
    String url = '${Api.user}/data_user_search.php';
    Map? responseBody = await AppRequest.post(url, {
      'role': role,
      'nama': nama,
    });

    if (responseBody == null) return [];

    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => User.fromJson(e)).toList();
    }

    return [];
  }

  static Future<User?> whereNama(String role, String nik) async {
    String url = '${Api.user}/where_nama.php';
    Map? responseBody = await AppRequest.post(url, {
      'role': role,
      'nik': nik,
    });

    if (responseBody == null) return null;

    if (responseBody['success']) {
      var e = responseBody['data'];
      return User.fromJson(e);
    }

    return null;
  }

  static Future<bool> update(
      String idUser, String nama, String alamat, String role) async {
    String url = '${Api.user}/update.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'nama': nama,
      'alamat': alamat,
      'role': role,
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

  static Future<bool> changePassword(String idUser, String password) async {
    String url = '${Api.user}/change_password.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'password': password,
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess('Berhasil Ubah Password');
      DInfo.closeDialog();
    } else {
      String? message = responseBody['message'];
      if (message != null) {
        DInfo.dialogError(message);
      } else {
        DInfo.dialogError('Gagal Ubah Password');
      }
      DInfo.closeDialog();
    }

    return responseBody['success'];
  }

  static Future<bool> delete(String nik) async {
    String url = '${Api.user}/delete.php';
    Map? responseBody = await AppRequest.post(url, {
      'nik': nik,
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess('Berhasil Hapus Data');
      DInfo.closeDialog();
    }
    return responseBody['success'];
  }

  static Future<Map?> getKegiatan() async {
    String url = '${Api.user}/get_kegiatan.php';
    Map? responseBody = await AppRequest.post(url, {
      'today': AppFormat.justdate(DateTime.now()),
    });

    if (responseBody == null) return null;

    if (responseBody['success']) {
      Map kegiatan = responseBody['data'];
      return kegiatan;
    }

    return null;
  }

  static Future<List<Map>> getAllKegiatan() async {
    String url = '${Api.user}/get_all_kegiatan.php';
    Map? responseBody = await AppRequest.gets(url);

    if (responseBody == null) return [];

    if (responseBody['success']) {
      List kegiatan = responseBody['data'];
      return List.from(kegiatan);
    }

    return [];
  }

  static Future<List> presensi(idKegiatan) async {
    String url = '${Api.user}/presensi.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_kegiatan': idKegiatan,
    });

    if (responseBody == null) return [];

    if (responseBody['success']) {
      List list_presensi = responseBody['data'];
      return list_presensi;
    }

    return [];
  }

  static Future<bool> addPresensi(String idUser, String idKegiatan) async {
    String url = '${Api.user}/add_presensi.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'id_kegiatan': idKegiatan,
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess('Berhasil Tambah Presensi');
      DInfo.closeDialog();
    } else {
      String? message = responseBody['message'];
      if (message != null) {
        DInfo.dialogError(message);
      } else {
        DInfo.dialogError('Gagal Tambah Presensi');
      }
      DInfo.closeDialog();
    }

    return responseBody['success'];
  }

  static Future<bool> deletePresensi(String idPresensi) async {
    String url = '${Api.user}/delete_presensi.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_presensi': idPresensi,
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess('Berhasil Hapus Data');
      DInfo.closeDialog();
    }

    return responseBody['success'];
  }

  static Future<List<Map>> presensiPetugas(idUser) async {
    String url = '${Api.user}/presensi_petugas.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
    });

    if (responseBody == null) return [];

    if (responseBody['success']) {
      List list_presensi = responseBody['data'];
      return list_presensi.map((e) => Map.from(e)).toList();
    }

    return [];
  }

  static Future<List<Map>> presensiPetugasLimit(idUser) async {
    String url = '${Api.user}/presensi_petugas_limit.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
    });

    if (responseBody == null) return [];

    if (responseBody['success']) {
      List list_presensi = responseBody['data'];
      return list_presensi.map((e) => Map.from(e)).toList();
    }

    return [];
  }

  static Future<bool> addPresensiPetugas(
      String idUser, String idKegiatan) async {
    String url = '${Api.user}/add_presensi_petugas.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'id_kegiatan': idKegiatan,
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess('Berhasil Tambah Presensi');
      DInfo.closeDialog();
    } else {
      DInfo.dialogError('Gagal Tambah Presensi');
      DInfo.closeDialog();
    }

    return responseBody['success'];
  }

  static Future<bool> deletePresensiPetugas(
      String idKegiatan, String idUser) async {
    String url = '${Api.user}/delete_presensi_petugas.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_kegiatan': idKegiatan,
      'id_user': idUser,
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess('Berhasil Hapus Data');
      DInfo.closeDialog();
    }

    return responseBody['success'];
  }

  static Future<bool> addJadwalPemeriksaan(
      String namaKegiatan,
      String tglPelaksanaan,
      String tempatPelaksanaan,
      String deskripsiKegiatan,
      String jamPelaksanaan) async {
    String url = '${Api.user}/add_jadwal_pemeriksaan.php';
    Map? responseBody = await AppRequest.post(url, {
      'nama_kegiatan': namaKegiatan,
      'tgl_pelaksanaan': tglPelaksanaan,
      'tempat_pelaksanaan': tempatPelaksanaan,
      'deskripsi_kegiatan': deskripsiKegiatan,
      'jam_pelaksanaan': jamPelaksanaan
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

  static Future<bool> updateJadwalPemeriksaan(
      String idKegiatan,
      String namaKegiatan,
      String tglPelaksanaan,
      String jamPelaksanaan,
      String tempatPelaksanaan,
      String deskripsiKegiatan) async {
    String url = '${Api.user}/update_jadwal_pemeriksaan.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_kegiatan': idKegiatan,
      'nama_kegiatan': namaKegiatan,
      'tgl_pelaksanaan': tglPelaksanaan,
      'jam_pelaksanaan': jamPelaksanaan,
      'tempat_pelaksanaan': tempatPelaksanaan,
      'deskripsi_kegiatan': deskripsiKegiatan,
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

  static Future<bool> deleteJadwalPemeriksaan(String idKegiatan) async {
    String url = '${Api.user}/delete_jadwal_pemeriksaan.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_kegiatan': idKegiatan,
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess('Berhasil Hapus Data');
      DInfo.closeDialog();
    }

    return responseBody['success'];
  }

  static Future<List<Map>> getPemeriksaanTerakhir(String idUser) async {
    String url = '${Api.user}/get_pemeriksaan_terakhir.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
    });

    if (responseBody == null) return [];

    if (responseBody['success']) {
      return List.from(responseBody['data']);
    }

    return [];
  }

  static Future<List<Map>> getRiwayatPemeriksaan(String idAnak) async {
    String url = '${Api.user}/get_riwayat_pemeriksaan.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_anak': idAnak,
    });

    if (responseBody == null) return [];

    if (responseBody['success']) {
      return List.from(responseBody['data']);
    }

    return [];
  }

  static Future<List> pengecekanRiwayatImunisasi(String idAnak) async {
    String url = '${Api.user}/pengecekan_riwayat_imunisasi.php';
    Map? responseBody = await AppRequest.post(
      url,
      {
        'id_anak': idAnak,
      },
    );

    if (responseBody == null) return [];

    if (responseBody['success']) {
      List data = responseBody['data'];
      return data.map((e) => e['jenis_imunisasi']).toList();
    }

    return [];
  }

  static Future<bool> setImunisasi(String idAnak, String jenisImunisasi) async {
    String url = '${Api.user}/set_imunisasi.php';
    Map? responseBody = await AppRequest.post(
      url,
      {
        'id_anak': idAnak,
        'jenis_imunisasi': jenisImunisasi,
      },
    );

    if (responseBody == null) return false;

    return responseBody['success'];
  }

  static Future<bool> cancelImunisasi(
      String idAnak, String jenisImunisasi) async {
    String url = '${Api.user}/cancel_imunisasi.php';
    Map? responseBody = await AppRequest.post(
      url,
      {
        'id_anak': idAnak,
        'jenis_imunisasi': jenisImunisasi,
      },
    );

    if (responseBody == null) return false;

    return responseBody['success'];
  }
}
