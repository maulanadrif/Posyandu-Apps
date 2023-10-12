import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/presentation/controller/c_all_kegiatan.dart';
import 'package:posyandu_apps/presentation/page/admin/lihat_presensi_page%20.dart';
import 'package:posyandu_apps/presentation/page/admin/update_jadwal_pemeriksaan_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/detail_jadwal_pemeriksaan.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Notifikasi'),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.fromLTRB(16, 30, 16, 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Hai ibu! Hari ini, imunisasi BCG. Jangan lupa untuk datang ke Posyandu ya!',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          );
        },
        padding: EdgeInsets.all(16),
      ),
    );
  }
}
