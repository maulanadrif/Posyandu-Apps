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
import 'package:posyandu_apps/presentation/controller/c_all_kegiatan.dart';
import 'package:posyandu_apps/presentation/page/admin/add_jadwal_pemeriksaan_page.dart';
import 'package:posyandu_apps/presentation/page/admin/add_presensi_page.dart';
import 'package:posyandu_apps/presentation/page/admin/lihat_presensi_page%20.dart';
import 'package:posyandu_apps/presentation/page/admin/update_jadwal_pemeriksaan_page.dart';

class PresensiPasienPage extends StatefulWidget {
  const PresensiPasienPage({super.key});

  @override
  State<PresensiPasienPage> createState() => _PresensiPasienPageState();
}

class _PresensiPasienPageState extends State<PresensiPasienPage> {
  final cAllKegiatan = Get.put(CAllKegiatan());

  menuOption(String value, Map item) async {
    if (value == 'update') {
    } else if (value == 'delete') {
      bool? yes = await DInfo.dialogConfirmation(
          context, 'Hapus Data Pasien', 'Ingin menghapus data?',
          textNo: 'Batal', textYes: 'Ya');
      if (yes!) {
        bool success =
            await SourceUser.deleteJadwalPemeriksaan(item['id_kegiatan']);
        if (success) {
          cAllKegiatan.getList();
        }
      }
    } else if (value == 'presensi') {
      Get.to(() => LihatPresensiPage(kegiatan: item));
    }
  }

  @override
  void initState() {
    cAllKegiatan.getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Pilih Jadwal'),
      body: Obx(() {
        if (cAllKegiatan.loading) return DView.loadingCircle();
        List list = cAllKegiatan.list;
        if (list.isEmpty) return DView.empty('Belum Ada Kegiatan');
        return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
            itemCount: list.length,
            itemBuilder: (context, index) {
              Map item = list[index];
              return GestureDetector(
                onTap: () {
                  Get.to(
                    () => AddPresensiPasienPage(
                      kegiatan: item,
                      role: 'Pasien',
                    ),
                  );
                },
                child: Container(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppFormat.date(item['tgl_pelaksanaan']),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.navigate_next,
                                  size: 30,
                                )
                              ],
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
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}
