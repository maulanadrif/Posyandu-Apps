import 'package:flutter/material.dart';
import 'package:posyandu_apps/config/constant/data_ideal_pr.dart';
import 'package:posyandu_apps/config/constant/panduan_asupan.dart';
import 'package:posyandu_apps/data/model/user.dart';
import 'package:posyandu_apps/presentation/page/admin/data_admin_page.dart';
import 'package:posyandu_apps/presentation/page/admin/pilih_ibu_balita_data_imunisasi_page.dart';
import 'package:posyandu_apps/presentation/page/admin/data_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/admin/data_pemeriksaan_page.dart';
import 'package:posyandu_apps/presentation/page/admin/riwayat_data_penimbangan_page.dart';
import 'package:posyandu_apps/presentation/page/admin/presensi_page.dart';
import 'package:posyandu_apps/presentation/page/admin/jadwal_pemeriksaan_page.dart';
import 'package:posyandu_apps/presentation/page/admin/admin_page.dart';
import 'package:posyandu_apps/presentation/page/anak/data_anak_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/data_anak_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/imunisasi_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/jadwal_pemeriksaan_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/pilih_anak_imunisasi_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/profile_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/pilih_anak_riwayat_penimbangan_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/pasien_page.dart';

class AppConstant {
  static const dataidealpr = DataIdealPr.data;
  static const dataideallk = [
    {
      'usia': 0,
      'bb_min': 2.5,
      'bb_max': 3.9,
      'tb_min': 46.1,
      'tb_max': 55.6,
    },
    {
      'usia': 1,
      'bb_min': 3.4,
      'bb_max': 5.1,
      'tb_min': 50.8,
      'tb_max': 60.6,
    },
    {
      'usia': 2,
      'bb_min': 4.3,
      'bb_max': 6.3,
      'tb_min': 54.4,
      'tb_max': 64.4,
    },
    {
      'usia': 3,
      'bb_min': 5,
      'bb_max': 7.2,
      'tb_min': 57.3,
      'tb_max': 67.6,
    },
    {
      'usia': 4,
      'bb_min': 5.6,
      'bb_max': 7.8,
      'tb_min': 59.7,
      'tb_max': 70.1,
    },
    {
      'usia': 5,
      'bb_min': 6,
      'bb_max': 8.4,
      'tb_min': 61.7,
      'tb_max': 72.2,
    },
    {
      'usia': 6,
      'bb_min': 6.4,
      'bb_max': 8.8,
      'tb_min': 63.3,
      'tb_max': 74,
    },
    {
      'usia': 7,
      'bb_min': 6.7,
      'bb_max': 9.2,
      'tb_min': 64.8,
      'tb_max': 75.7,
    },
    {
      'usia': 8,
      'bb_min': 6.9,
      'bb_max': 9.6,
      'tb_min': 66.2,
      'tb_max': 77.2,
    },
    {
      'usia': 9,
      'bb_min': 7.1,
      'bb_max': 9.9,
      'tb_min': 67.5,
      'tb_max': 78.7,
    },
    {
      'usia': 10,
      'bb_min': 7.4,
      'bb_max': 10.2,
      'tb_min': 68.7,
      'tb_max': 80.1,
    },
    {
      'usia': 11,
      'bb_min': 7.6,
      'bb_max': 10.5,
      'tb_min': 69.9,
      'tb_max': 81.5,
    },
    {
      'usia': 12,
      'bb_min': 7.7,
      'bb_max': 10.8,
      'tb_min': 71,
      'tb_max': 82.9,
    },
    {
      'usia': 13,
      'bb_min': 7.9,
      'bb_max': 11,
      'tb_min': 72.1,
      'tb_max': 84.2,
    },
    {
      'usia': 14,
      'bb_min': 8.1,
      'bb_max': 11.3,
      'tb_min': 73.1,
      'tb_max': 85.5,
    },
    {
      'usia': 15,
      'bb_min': 8.3,
      'bb_max': 11.5,
      'tb_min': 74.1,
      'tb_max': 86.7,
    },
    {
      'usia': 16,
      'bb_min': 8.4,
      'bb_max': 11.7,
      'tb_min': 75,
      'tb_max': 88,
    },
    {
      'usia': 17,
      'bb_min': 8.6,
      'bb_max': 12,
      'tb_min': 76,
      'tb_max': 89.2,
    },
    {
      'usia': 18,
      'bb_min': 8.8,
      'bb_max': 12.2,
      'tb_min': 76.9,
      'tb_max': 90.4,
    },
    {
      'usia': 19,
      'bb_min': 8.9,
      'bb_max': 12.5,
      'tb_min': 77.7,
      'tb_max': 91.5,
    },
    {
      'usia': 20,
      'bb_min': 9.1,
      'bb_max': 12.7,
      'tb_min': 78.6,
      'tb_max': 92.6,
    },
    {
      'usia': 21,
      'bb_min': 9.2,
      'bb_max': 12.9,
      'tb_min': 79.4,
      'tb_max': 93.8,
    },
    {
      'usia': 22,
      'bb_min': 9.4,
      'bb_max': 13.2,
      'tb_min': 80.2,
      'tb_max': 94.9,
    },
    {
      'usia': 23,
      'bb_min': 9.5,
      'bb_max': 13.4,
      'tb_min': 81,
      'tb_max': 95.9,
    },
    {
      'usia': 24,
      'bb_min': 9.7,
      'bb_max': 13.6,
      'tb_min': 81.7,
      'tb_max': 97,
    },
    {
      'usia': 25,
      'bb_min': 9.8,
      'bb_max': 13.9,
      'tb_min': 81.7,
      'tb_max': 97.3,
    },
    {
      'usia': 26,
      'bb_min': 10,
      'bb_max': 14.1,
      'tb_min': 82.5,
      'tb_max': 98.3,
    },
    {
      'usia': 27,
      'bb_min': 10.1,
      'bb_max': 14.3,
      'tb_min': 83.1,
      'tb_max': 99.3,
    },
    {
      'usia': 28,
      'bb_min': 10.2,
      'bb_max': 14.5,
      'tb_min': 83.8,
      'tb_max': 100.3,
    },
    {
      'usia': 29,
      'bb_min': 10.4,
      'bb_max': 14.8,
      'tb_min': 84.5,
      'tb_max': 101.2,
    },
    {
      'usia': 30,
      'bb_min': 10.5,
      'bb_max': 15,
      'tb_min': 85.1,
      'tb_max': 102.1,
    },
    {
      'usia': 31,
      'bb_min': 10.7,
      'bb_max': 15.2,
      'tb_min': 85.7,
      'tb_max': 103,
    },
    {
      'usia': 32,
      'bb_min': 10.8,
      'bb_max': 15.4,
      'tb_min': 86.4,
      'tb_max': 103.9,
    },
    {
      'usia': 33,
      'bb_min': 10.9,
      'bb_max': 15.6,
      'tb_min': 86.9,
      'tb_max': 104.8,
    },
    {
      'usia': 34,
      'bb_min': 11,
      'bb_max': 15.8,
      'tb_min': 87.5,
      'tb_max': 105.6,
    },
    {
      'usia': 35,
      'bb_min': 11.2,
      'bb_max': 16,
      'tb_min': 88.1,
      'tb_max': 106.4,
    },
    {
      'usia': 36,
      'bb_min': 11.3,
      'bb_max': 16.2,
      'tb_min': 88.7,
      'tb_max': 107.2,
    },
    {
      'usia': 37,
      'bb_min': 11.4,
      'bb_max': 16.4,
      'tb_min': 89.2,
      'tb_max': 108,
    },
    {
      'usia': 38,
      'bb_min': 11.5,
      'bb_max': 16.6,
      'tb_min': 89.8,
      'tb_max': 108.8,
    },
    {
      'usia': 39,
      'bb_min': 11.6,
      'bb_max': 16.8,
      'tb_min': 90.3,
      'tb_max': 109.5,
    },
    {
      'usia': 40,
      'bb_min': 11.8,
      'bb_max': 17,
      'tb_min': 90.9,
      'tb_max': 110.3,
    },
    {
      'usia': 41,
      'bb_min': 11.9,
      'bb_max': 17.2,
      'tb_min': 91.4,
      'tb_max': 111,
    },
    {
      'usia': 42,
      'bb_min': 12,
      'bb_max': 17.4,
      'tb_min': 91.9,
      'tb_max': 111.7,
    },
    {
      'usia': 43,
      'bb_min': 12.1,
      'bb_max': 17.6,
      'tb_min': 92.4,
      'tb_max': 112.5,
    },
    {
      'usia': 44,
      'bb_min': 12.2,
      'bb_max': 17.8,
      'tb_min': 93,
      'tb_max': 113.2,
    },
    {
      'usia': 45,
      'bb_min': 12.4,
      'bb_max': 18,
      'tb_min': 93.5,
      'tb_max': 113.9,
    },
    {
      'usia': 46,
      'bb_min': 12.5,
      'bb_max': 18.2,
      'tb_min': 94,
      'tb_max': 114.6,
    },
    {
      'usia': 47,
      'bb_min': 12.6,
      'bb_max': 18.4,
      'tb_min': 94.4,
      'tb_max': 115.2,
    },
    {
      'usia': 48,
      'bb_min': 12.7,
      'bb_max': 18.6,
      'tb_min': 94.9,
      'tb_max': 115.9,
    },
    {
      'usia': 49,
      'bb_min': 12.8,
      'bb_max': 18.8,
      'tb_min': 95.4,
      'tb_max': 116.6,
    },
    {
      'usia': 50,
      'bb_min': 12.9,
      'bb_max': 19,
      'tb_min': 95.9,
      'tb_max': 117.3,
    },
    {
      'usia': 51,
      'bb_min': 13.1,
      'bb_max': 19.2,
      'tb_min': 96.4,
      'tb_max': 117.9,
    },
    {
      'usia': 52,
      'bb_min': 13.2,
      'bb_max': 19.4,
      'tb_min': 96.9,
      'tb_max': 118.6,
    },
    {
      'usia': 53,
      'bb_min': 13.3,
      'bb_max': 19.6,
      'tb_min': 97.4,
      'tb_max': 119.2,
    },
    {
      'usia': 54,
      'bb_min': 13.4,
      'bb_max': 19.8,
      'tb_min': 97.8,
      'tb_max': 119.9,
    },
    {
      'usia': 55,
      'bb_min': 13.5,
      'bb_max': 20,
      'tb_min': 98.3,
      'tb_max': 120.6,
    },
    {
      'usia': 56,
      'bb_min': 13.6,
      'bb_max': 20.2,
      'tb_min': 98.8,
      'tb_max': 121.2,
    },
    {
      'usia': 57,
      'bb_min': 13.7,
      'bb_max': 20.4,
      'tb_min': 99.3,
      'tb_max': 121.9,
    },
    {
      'usia': 58,
      'bb_min': 13.8,
      'bb_max': 20.6,
      'tb_min': 99.7,
      'tb_max': 122.6,
    },
    {
      'usia': 59,
      'bb_min': 14,
      'bb_max': 20.8,
      'tb_min': 100.2,
      'tb_max': 123.2,
    },
    {
      'usia': 60,
      'bb_min': 14.1,
      'bb_max': 21,
      'tb_min': 100.7,
      'tb_max': 123.9,
    },
  ];
  static const menu = [
    {
      'title': 'Jadwal Posyandu',
      'icontype': 'icon',
      'icon': Icons.date_range,
      'page': JadwalPemeriksaanPage(),
    },
    {
      'title': 'Data Petugas',
      'icontype': 'icon',
      'icon': Icons.person_outline,
      'page': DataAdminPage(role: 'Admin'),
    },
    {
      'title': 'Data Pasien',
      'icontype': 'icon',
      'icon': Icons.pregnant_woman,
      'page': DataPasienPage(role: 'Pasien'),
    },
    // {
    //   'title' : 'Data Balita',
    //   'icontype' : 'icon',
    //   'icon' : Icons.child_care,
    //   'page' : DataAnakPage(),
    // },
    {
      'title': 'Presensi',
      'icontype': 'icon',
      'icon': Icons.data_exploration,
      'page': PresensiPage(),
    },
    // {
    //   'title' : 'Riwayat Penimbangan',
    //   'icontype' : 'icon',
    //   'icon' : Icons.scale_rounded,
    //   'page' : RiwayatDataPenimbanganPage(),
    // },
    {
      'title': 'Data Penimbangan',
      'icontype': 'icon',
      'icon': Icons.scale_rounded,
      'page': DataPenimbanganPage(),
    },
    {
      'title': 'Data Imunisasi',
      'icontype': 'icon',
      'icon': Icons.vaccines_rounded,
      'page': PilihIbuBalitaDataImunisasiPage(role: 'Pasien'),
    },
  ];
  static const menuPasien = [
    {
      'title': 'Jadwal Pemeriksaan',
      'icontype': 'icon',
      'icon': Icons.date_range,
      'page': JadwalPemeriksaanPasienPage(),
    },
    // {
    //   'title' : 'Data Anak',
    //   'icontype' : 'icon',
    //   'icon' : Icons.child_care,
    //   'page' : DataAnakPasienPage(),
    // },
    {
      'title': 'Riwayat Hasil Penimbangan',
      'icontype': 'icon',
      'icon': Icons.scale_rounded,
      'page': Scaffold(),
    },
    {
      'title': 'Imunisasi',
      'icontype': 'icon',
      'icon': Icons.vaccines_rounded,
      'page': Scaffold(),
    },
  ];

  static const navbar = <Map>[
    {
      'title': 'Beranda',
      // 'icontype' : 'icon',
      'iconOn': Icons.home,
      'iconOff': Icons.home_outlined,
      'page': PasienPage(),
    },
    {
      'title': 'Imunisasi',
      // 'icontype' : 'icon',
      'iconOn': Icons.shield,
      'iconOff': Icons.shield_outlined,
      'page': PilihAnakImunisasiPage(),
    },
    {
      'title': 'Profil',
      // 'icontype' : 'icon',
      'iconOn': Icons.account_circle,
      'iconOff': Icons.account_circle_outlined,
      'page': ProfilePage(),
    },
  ];
  static const imunisasi = {
    'BCG': ['BCG'],
    'DPT': ['DPT 1', 'DPT 2', 'DPT 3'],
    'POLIO': ['POLIO 1', 'POLIO 2', 'POLIO 3', 'POLIO 4'],
    'CAMPAK': ['CAMPAK'],
    'HEPATITIS': ['HEPATITIS 1', 'HEPATITIS 2', 'HEPATITIS 3'],
  };

  static const panduanAsupan = PanduanAsupan.data;
}
