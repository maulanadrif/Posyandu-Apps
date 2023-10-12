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
import 'package:posyandu_apps/presentation/page/admin/lihat_presensi_page%20.dart';
import 'package:posyandu_apps/presentation/page/admin/update_jadwal_pemeriksaan_page.dart';

class JadwalPemeriksaanPage extends StatefulWidget {
  const JadwalPemeriksaanPage({super.key});

  @override
  State<JadwalPemeriksaanPage> createState() => _JadwalPemeriksaanPageState();
}

class _JadwalPemeriksaanPageState extends State<JadwalPemeriksaanPage> {
  final cAllKegiatan = Get.put(CAllKegiatan());

  menuOption(String value, Map item) async {
    if (value == 'update') {
      Get.to(() => UpdateJadwalPemeriksaanPage(kegiatan: item));
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
      appBar: AppBarModif.appBarAdd(
        'Jadwal Posyandu',
        IconButton(
          onPressed: () {
            Get.to(() => AddJadwalPemeriksaanPage());
          },
          icon: Icon(Icons.add),
          color: AppColor.primary,
        ),
      ),
      body: Obx(() {
        if (cAllKegiatan.loading) return DView.loadingCircle();
        List list = cAllKegiatan.list;
        if (list.isEmpty) return DView.empty('Belum Ada Kegiatan');
        return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
            itemCount: list.length,
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
                              PopupMenuButton<String>(
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                      value: 'presensi',
                                      child: Text('Lihat Data Presensi')),
                                  const PopupMenuItem(
                                      value: 'update',
                                      child: Text('Update Jadwal')),
                                  const PopupMenuItem(
                                      value: 'delete',
                                      child: Text('Delete Jadwal')),
                                ],
                                onSelected: (value) => menuOption(value, item),
                              ),
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
              );
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Material(
                  borderRadius: BorderRadius.circular(16),
                  elevation: 4,
                  color: AppColor.primary,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
                        child: Text(
                          item['nama_kegiatan'],
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.secondary),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 4),
                        child: Text(
                          AppFormat.date(item['tgl_pelaksanaan']),
                          style: TextStyle(
                            color: AppColor.bg,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 30),
                        child: Text(
                          item['tempat_pelaksanaan'],
                          style: TextStyle(
                            color: AppColor.bg,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Menu',
                              style: TextStyle(color: AppColor.primary),
                            ),
                            PopupMenuButton<String>(
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                    value: 'presensi',
                                    child: Text('Lihat Data Presensi')),
                                const PopupMenuItem(
                                    value: 'update',
                                    child: Text('Update Jadwal')),
                                const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete Jadwal')),
                              ],
                              onSelected: (value) => menuOption(value, item),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}
