import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/data/source/source_user.dart';
import 'package:posyandu_apps/presentation/controller/c_admin.dart';
import 'package:posyandu_apps/presentation/controller/c_all_kegiatan.dart';
import 'package:posyandu_apps/presentation/controller/c_presensi_petugas.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/admin/add_jadwal_pemeriksaan_page.dart';
import 'package:posyandu_apps/presentation/page/admin/lihat_presensi_page%20.dart';
import 'package:posyandu_apps/presentation/page/admin/update_jadwal_pemeriksaan_page.dart';

class PresensiPetugasPage extends StatefulWidget {
  const PresensiPetugasPage({super.key});

  @override
  State<PresensiPetugasPage> createState() => _PresensiPetugasPageState();
}

class _PresensiPetugasPageState extends State<PresensiPetugasPage> {
  final cPresensiPetugas = Get.put(CPresensiPetugas());
  final cUser = Get.put(CUser());
  final cAdmin = Get.put(CAdmin());

  addPresensiPetugas(idKegiatan) {
    DInfo.dialogConfirmation(context, 'Tambah presensi', 'Klik ya untuk hadir',
            textNo: 'Batal', textYes: 'Ya')
        .then((value) {
      if (value ?? false) {
        SourceUser.addPresensiPetugas(cUser.data.idUser!, idKegiatan);
        cPresensiPetugas.getList(cUser.data.idUser);
        cAdmin.getList(cUser.data.idUser!);
      }
    });
  }

  deletePresensiPetugas(idKegiatan) {
    DInfo.dialogConfirmation(context, 'Hapus presensi', 'Klik ya untuk hapus',
            textNo: 'Batal', textYes: 'Ya')
        .then((value) {
      if (value ?? false) {
        SourceUser.deletePresensiPetugas(idKegiatan, cUser.data.idUser!);
        cPresensiPetugas.getList(cUser.data.idUser);
        cAdmin.getList(cUser.data.idUser!);
      }
    });
  }

  @override
  void initState() {
    cPresensiPetugas.getList(cUser.data.idUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Presensi Petugas'),
      body: Obx(
        () {
          if (cPresensiPetugas.loading) return DView.loadingCircle();
          List list = cPresensiPetugas.list;
          if (list.isEmpty) return DView.empty();
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: list.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Map item = list[index];
              return Container(
                margin: EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['tempat_pelaksanaan'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            AppFormat.date(item['tgl_pelaksanaan']),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          DView.spaceHeight(20),
                          Text(
                            item['nama_kegiatan'],
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    item['Hadir']
                        ? Material(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            elevation: 4,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                deletePresensiPetugas(item['id_kegiatan']);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                    DView.spaceWidth(8),
                                    Text(
                                      'Hadir',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.red,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                addPresensiPetugas(item['id_kegiatan']);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
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
                            ),
                          ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
