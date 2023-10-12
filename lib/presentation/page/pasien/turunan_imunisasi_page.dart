import 'package:d_view/d_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/session.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_anak.dart';
import 'package:posyandu_apps/presentation/controller/c_pilih_imunisasi.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/anak/detail_data_anak_page.dart';
import 'package:posyandu_apps/presentation/page/auth/login_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/akun_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/data_anak_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/jadwal_pemeriksaan_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/pilih_anak_riwayat_penimbangan_page.dart';

class TurunanImunisasiPage extends StatefulWidget {
  const TurunanImunisasiPage(
      {super.key, required this.imunisasi, required this.idAnak});
  final MapEntry imunisasi;
  final String idAnak;

  @override
  State<TurunanImunisasiPage> createState() => _TurunanImunisasiPageState();
}

class _TurunanImunisasiPageState extends State<TurunanImunisasiPage> {
  final cUser = Get.put(CUser());
  final cAnak = Get.put(CAnak());
  final cPilihImunisasi = Get.put(CPilihImunisasi());

  refresh() {
    cPilihImunisasi.getList(widget.idAnak);
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Text('Imunisasi'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: widget.imunisasi.value.length,
        itemBuilder: (context, index) {
          String itemImunisasi = widget.imunisasi.value[index];
          return GestureDetector(
            onTap: () {},
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
                    itemImunisasi,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Obx(() {
                    List sudahImunisasi = cPilihImunisasi.list;
                    if (sudahImunisasi.contains(itemImunisasi)) {
                      return Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              DView.spaceWidth(8),
                              Text(
                                'Sudah',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                        child: Row(
                          children: [
                            Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                            DView.spaceWidth(8),
                            Text(
                              'Belum',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: widget.imunisasi.value.length,
            itemBuilder: (context, index) {
              String itemImunisasi = widget.imunisasi.value[index];
              return GestureDetector(
                onTap: () {},
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
                        itemImunisasi,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      // Obx(() {
                      //   List sudahImunisasi = cPilihImunisasi.list;
                      //   return Checkbox(
                      //     value: sudahImunisasi.contains(itemImunisasi),
                      //     onChanged: (value) {
                      //       if (value ?? false) {
                      //         setImunisasi(itemImunisasi);
                      //       } else {
                      //         cancelImunisasi(itemImunisasi);
                      //       }
                      //     },
                      //   );
                      // }),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
