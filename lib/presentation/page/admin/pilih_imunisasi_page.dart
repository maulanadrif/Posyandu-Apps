import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/config/constant/app_constant.dart';
import 'package:posyandu_apps/data/model/anak.dart';
import 'package:posyandu_apps/data/model/user.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_anak.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_data_anak.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/admin/pilih_turunan_imunisasi_page.dart';
import 'package:posyandu_apps/presentation/page/anak/add_data_anak_page.dart';
import 'package:posyandu_apps/presentation/page/anak/add_data_pemeriksaan_page.dart';
import 'package:posyandu_apps/presentation/page/anak/detail_data_anak_page.dart';
import 'package:posyandu_apps/presentation/page/anak/update_data_anak_page.dart';

class PilihImunisasiPage extends StatefulWidget {
  const PilihImunisasiPage({
    Key? key,
    required this.idAnak,
  }) : super(key: key);
  final String idAnak;

  @override
  State<PilihImunisasiPage> createState() => _PilihImunisasiPageState();
}

class _PilihImunisasiPageState extends State<PilihImunisasiPage> {
  final cUser = Get.put(CUser());
  final cAnak = Get.put(CAnak());
  final cDataAnak = Get.put(CDataAnak());

  // getDataAnak() {
  //   cDataAnak.getList(widget.user.idUser);
  // }

  @override
  void initState() {
    // cUser.init(cUser.setRole('Pasien'), widget.nama);
    // getDataAnak();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Pilih Imunisasi'),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: AppConstant.imunisasi.entries.map((e) {
          return GestureDetector(
            onTap: () {
              Get.to(() => PilihTurunanImunisasiPage(
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
