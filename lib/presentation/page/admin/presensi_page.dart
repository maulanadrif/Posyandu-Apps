import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/presentation/controller/c_all_kegiatan.dart';
import 'package:posyandu_apps/presentation/page/admin/jadwal_pemeriksaan_page.dart';
import 'package:posyandu_apps/presentation/page/admin/lihat_presensi_page%20.dart';
import 'package:posyandu_apps/presentation/page/admin/presensi_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/admin/presensi_petugas_page.dart';

class PresensiPage extends StatefulWidget {
  const PresensiPage({super.key});

  @override
  State<PresensiPage> createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiPage> {
  final cAllKegiatan = Get.put(CAllKegiatan());

  @override
  void initState() {
    cAllKegiatan.getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Presensi'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 30, 16, 16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => PresensiPetugasPage());
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Presensi Petugas',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Icon(Icons.navigate_next, color: Colors.black),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => PresensiPasienPage());
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Presensi Pasien',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Icon(Icons.navigate_next, color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // body: Obx(
      //   () {
      //     if(cAllKegiatan.loading) return DView.loadingCircle();
      //     List list = cAllKegiatan.list;
      //     if(list.isEmpty) return DView.empty('Belum Ada Kegiatan');
      //     return ListView.builder(
      //       padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
      //       itemCount: list.length,
      //       itemBuilder: (context, index) {
      //         Map item = list[index];
      //         return Padding(
      //           padding: const EdgeInsets.only(bottom: 16),
      //           child: Material(
      //             borderRadius: BorderRadius.circular(16),
      //             elevation: 4,
      //             color: AppColor.primary,
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Padding(
      //                   padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      //                   child: Text(
      //                     item['nama_kegiatan'],
      //                     style: Theme.of(context).textTheme.headline5!.copyWith(
      //                         fontWeight: FontWeight.bold, color: AppColor.secondary),
      //                   ),
      //                 ),
      //                 Padding(
      //                   padding: EdgeInsets.fromLTRB(16, 0, 16, 4),
      //                   child: Text(
      //                     AppFormat.date(item['tgl_pelaksanaan']),
      //                     style: TextStyle(
      //                       color: AppColor.bg,
      //                       fontSize: 16,
      //                     ),
      //                   ),
      //                 ),
      //                 Padding(
      //                   padding: EdgeInsets.fromLTRB(16, 0, 16, 30),
      //                   child: Text(
      //                     item['tempat_pelaksanaan'],
      //                     style: TextStyle(
      //                       color: AppColor.bg,
      //                       fontSize: 16,
      //                     ),
      //                   ),
      //                 ),
      //                 GestureDetector(
      //                   onTap: () {
      //                     Get.to(() => LihatPresensiPage(kegiatan: item));
      //                   },
      //                   child: Container(
      //                     margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      //                     padding: const EdgeInsets.symmetric(vertical: 6),
      //                     decoration: const BoxDecoration(
      //                       color: Colors.white,
      //                     ),
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.end,
      //                       children: const [
      //                         Text(
      //                           'Lihat Presensi',
      //                           style: TextStyle(color: AppColor.primary),
      //                         ),
      //                         Icon(
      //                           Icons.navigate_next,
      //                           color: AppColor.primary,
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ),
      //         );
      //       }
      //     );
      //   }
      // ),
    );
  }
}
