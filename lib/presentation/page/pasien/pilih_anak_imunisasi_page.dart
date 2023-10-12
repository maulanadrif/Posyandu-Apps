import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/data/model/anak.dart';
import 'package:posyandu_apps/data/model/user.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_anak.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_data_anak.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/anak/add_data_anak_page.dart';
import 'package:posyandu_apps/presentation/page/anak/add_data_pemeriksaan_page.dart';
import 'package:posyandu_apps/presentation/page/anak/detail_data_anak_page.dart';
import 'package:posyandu_apps/presentation/page/anak/update_data_anak_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/imunisasi_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/riwayat_penimbangan_page.dart';

class PilihAnakImunisasiPage extends StatefulWidget {
  const PilihAnakImunisasiPage({
    Key? key,
  }) : super(key: key);

  // final User user;
  // final String nik;
  // final String nama;
  // final String alamat;
  // final String role;
  // final String idUser;

  @override
  State<PilihAnakImunisasiPage> createState() => _PilihAnakImunisasiPageState();
}

class _PilihAnakImunisasiPageState extends State<PilihAnakImunisasiPage> {
  final cUser = Get.put(CUser());
  final cAnak = Get.put(CAnak());
  final cDataAnak = Get.put(CDataAnak());

  getDataAnak() {
    cDataAnak.getList(cUser.data.idUser);
  }

  @override
  void initState() {
    // cUser.init(cUser.setRole('Pasien'), widget.nama);
    getDataAnak();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          foregroundColor: Colors.black,
          title: Text('Imunisasi'),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        Expanded(
          child: GetBuilder<CDataAnak>(builder: (_) {
            if (_.loading) return DView.loadingCircle();
            if (_.list.isEmpty) return DView.empty('Data Kosong');
            return RefreshIndicator(
              onRefresh: () async => getDataAnak(),
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: _.list.length,
                itemBuilder: (context, index) {
                  Anak anak = _.list[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => ImunisasiPage(idAnak: anak.idAnak!));
                      print(anak.idAnak);
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
                            'Nama Anak : ${anak.namaPanggilan}',
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
                },
              ),
            );
          }),
        )
      ],
    );
  }
}
