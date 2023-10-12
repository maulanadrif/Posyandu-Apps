import 'package:d_view/d_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/constant/app_constant.dart';
import 'package:posyandu_apps/config/session.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_anak.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/anak/detail_data_anak_page.dart';
import 'package:posyandu_apps/presentation/page/auth/login_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/akun_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/data_anak_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/jadwal_pemeriksaan_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/pilih_anak_riwayat_penimbangan_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/turunan_imunisasi_page.dart';

class ImunisasiPage extends StatefulWidget {
  const ImunisasiPage({super.key, required this.idAnak});
  final String idAnak;

  @override
  State<ImunisasiPage> createState() => _ImunisasiPageState();
}

class _ImunisasiPageState extends State<ImunisasiPage> {
  final cUser = Get.put(CUser());
  final cAnak = Get.put(CAnak());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Text('Imunisasi'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 50),
        children: AppConstant.imunisasi.entries.map((e) {
          return GestureDetector(
            onTap: () {
              Get.to(() => TurunanImunisasiPage(
                    imunisasi: e,
                    idAnak: widget.idAnak,
                  ));
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.fromLTRB(16, 30, 16, 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    e.key,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                    size: 40,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
