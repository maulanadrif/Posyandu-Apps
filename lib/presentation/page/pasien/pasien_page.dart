import 'dart:ui';

import 'package:d_chart/d_chart.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_asset.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/config/constant/app_constant.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/config/app_method.dart';
import 'package:posyandu_apps/config/session.dart';
import 'package:posyandu_apps/data/model/anak.dart';
import 'package:posyandu_apps/presentation/controller/c_admin.dart';
import 'package:posyandu_apps/presentation/controller/c_home.dart';
import 'package:posyandu_apps/presentation/controller/c_pasien.dart';
import 'package:posyandu_apps/presentation/controller/c_pemeriksaan_terakhir.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/anak/bb_chart.dart';
import 'package:posyandu_apps/presentation/page/anak/tb_chart.dart';
import 'package:posyandu_apps/presentation/page/auth/login_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/akun_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/detail_riwayat_penimbangan_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/notifikasi_page.dart';

class PasienPage extends StatefulWidget {
  const PasienPage({super.key});

  @override
  State<PasienPage> createState() => _PasienPageState();
}

class _PasienPageState extends State<PasienPage> {
  final cUser = Get.put(CUser());
  final cPemeriksaanTerakhir = Get.put(CPemeriksaanTerakhir());
  final cPasien = Get.put(CPasien());

  refresh() {
    cPasien.getList(cUser.data.idUser!);
  }

  @override
  void initState() {
    cPasien.getList(cUser.data.idUser!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
        //   child: Row(
        //     children: [
        //       // Image.asset(AppAsset.profile),
        //       Expanded(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             const Text(
        //               'Selamat Datang,',
        //               style: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 20,
        //               ),
        //             ),
        //             Obx(() {
        //               return Text(
        //                 'Ibu ${cUser.data.nama ?? ''}',
        //                 style: const TextStyle(
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 20,
        //                 ),
        //               );
        //             })
        //           ],
        //         ),
        //       ),
        //       Builder(builder: (ctx) {
        //         return InkWell(
        //           child: Image.asset(
        //             AppAsset.logo,
        //             scale: 7,
        //           ),
        //         );
        //       }),
        //     ],
        //   ),
        // ),
        AppBar(
          title: Column(
            children: [
              Text(
                'KMS Digital',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              DView.spaceHeight(),
              Obx(() {
                if (cPasien.loading) return DView.loadingCircle();
                List list = cPasien.listAnak;
                if (list.isEmpty) return DView.empty();
                return Container(
                  margin: EdgeInsets.only(right: 16),
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(list.length, (index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: index == 0 ? 0 : 4,
                          right: index == list.length - 1 ? 0 : 4,
                        ),
                        child: cPasien.currentIndex == index
                            ? ElevatedButton(
                                onPressed: () {
                                  cPasien.currentIndex = index;
                                },
                                child: Text(list[index]),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  minimumSize: Size(90, 36),
                                ),
                              )
                            : OutlinedButton(
                                onPressed: () {
                                  cPasien.currentIndex = index;
                                },
                                child: Text(list[index]),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  minimumSize: Size(90, 36),
                                  side: BorderSide(color: AppColor.primary),
                                ),
                              ),
                      );
                    }),
                  ),
                );
              }),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          toolbarHeight: 150,
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: IconButton(
                onPressed: () {
                  Get.to(() => NotifikasiPage());
                },
                icon: Icon(
                  Icons.notifications,
                  color: AppColor.primary,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: pemeriksaanTerakhir(),
        ),
      ],
    );
  }

  // Widget cardToday(BuildContext context) {
  //   return Obx(() {
  //     Map kegiatan = cAdmin.kegiatan;
  //     if (kegiatan.isEmpty) {
  //       return Material(
  //         borderRadius: BorderRadius.circular(16),
  //         elevation: 4,
  //         color: AppColor.primary,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.fromLTRB(16, 50, 16, 50),
  //               child: Text(
  //                 'Tidak ada kegiatan hari ini',
  //                 style: Theme.of(context).textTheme.headline5!.copyWith(
  //                     fontWeight: FontWeight.bold, color: AppColor.secondary),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     }
  //     return Material(
  //       borderRadius: BorderRadius.circular(16),
  //       elevation: 4,
  //       color: AppColor.primary,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
  //             child: Text(
  //               kegiatan['nama_kegiatan'],
  //               style: Theme.of(context).textTheme.headline5!.copyWith(
  //                   fontWeight: FontWeight.bold, color: AppColor.secondary),
  //             ),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.fromLTRB(16, 0, 16, 4),
  //             child: Text(
  //               AppFormat.date(kegiatan['tgl_pelaksanaan']),
  //               style: TextStyle(
  //                 color: AppColor.bg,
  //                 fontSize: 16,
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.fromLTRB(16, 0, 16, 30),
  //             child: Text(
  //               kegiatan['tempat_pelaksanaan'],
  //               style: TextStyle(
  //                 color: AppColor.bg,
  //                 fontSize: 16,
  //               ),
  //             ),
  //           ),
  //           GestureDetector(
  //             onTap: () {},
  //             child: Container(
  //               margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
  //               padding: const EdgeInsets.symmetric(vertical: 6),
  //               decoration: const BoxDecoration(
  //                 color: Colors.white,
  //               ),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: const [
  //                   Text(
  //                     'Selengkapnya',
  //                     style: TextStyle(color: AppColor.primary),
  //                   ),
  //                   Icon(
  //                     Icons.navigate_next,
  //                     color: AppColor.primary,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     );
  //   });
  // }

  Widget pemeriksaanTerakhir() {
    return Obx(
      () {
        if (cPasien.loading) return DView.loadingCircle();
        List list = cPasien.list;
        if (list.isEmpty) return DView.empty();
        return IndexedStack(
          index: cPasien.currentIndex,
          children: List.generate(list.length, (index) {
            Map itemAnak = list[index];
            Map? pemeriksaan = itemAnak['pemeriksaan'];
            int usia =
                AppMethod.calculateAge(DateTime.parse(itemAnak['tgl_lahir']));
            Map dataideal;
            if (itemAnak['jenis_kelamin'] == 'Perempuan') {
              dataideal = AppConstant.dataidealpr
                  .where((e) => e['usia'] == usia)
                  .toList()
                  .first;
            } else {
              dataideal = AppConstant.dataideallk
                  .where((e) => e['usia'] == usia)
                  .toList()
                  .first;
            }
            double beratBadan = pemeriksaan == null
                ? 0
                : double.parse(pemeriksaan['berat_badan']);
            double bbMin = dataideal['bb_min'];
            double bbMax = dataideal['bb_max'];
            String descBB = AppMethod.indikatorBerat(beratBadan, bbMin, bbMax);

            double tinggiBadan = pemeriksaan == null
                ? 0
                : double.parse(pemeriksaan['tinggi_badan']);
            double tbMin = dataideal['tb_min'].toDouble();
            double tbMax = dataideal['tb_max'].toDouble();
            String descTB =
                AppMethod.indikatorTinggi(tinggiBadan, tbMin, tbMax);
            return ListView(
              padding: EdgeInsets.all(0),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Berat Badan Menurut Umur',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '(${itemAnak['jenis_kelamin']})',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DView.spaceHeight(),
                                  AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: BBChart.withSampleData(
                                        beratBadan, bbMin, bbMax),
                                  ),
                                  DView.spaceHeight(),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Text(
                                            'Usia : ${AppMethod.calculateAge(DateTime.parse(itemAnak['tgl_lahir']))} Bulan',
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Berat Badan : ',
                                            ),
                                            Text(
                                              '$beratBadan ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'kg ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '($descBB)',
                                            )
                                          ],
                                        ),
                                        Text(
                                          'Berat ideal antara ${bbMin} kg - ${bbMax} kg',
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Tinggi Badan Menurut Umur',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '(${itemAnak['jenis_kelamin']})',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DView.spaceHeight(),
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: TBChart.withSampleData(tinggiBadan),
                                ),
                                DView.spaceHeight(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Text(
                                          'Usia : ${AppMethod.calculateAge(DateTime.parse(itemAnak['tgl_lahir']))} Bulan',
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Tinggi Badan : ',
                                          ),
                                          Text(
                                            '$tinggiBadan ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'cm ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '($descTB)',
                                          )
                                        ],
                                      ),
                                      Center(
                                        child: Text(
                                          'Tinggi ideal antara ${tbMin} cm - ${tbMax} cm',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                panduan(usia)
              ],
            );
          }),
        );
      },
    );
  }

  Widget panduan(int usia) {
    List panduans = AppConstant.panduanAsupan.where((Map<String, dynamic> e) {
      // return usia > e['min_usia'] && usia <= e['max_usia'];
      return usia == e['usia'];
    }).toList();
    if (panduans.isEmpty) return DView.nothing();
    Map panduan = panduans[0];
    // Map panduan = AppConstant.panduanAsupan.where((Map<String, dynamic> e) {
    //   // return usia > e['min_usia'] && usia <= e['max_usia'];
    //   return usia == e['usia'];
    // }).toList()[0];
    List poinPanduan = panduan['panduan'];
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Panduan Asupan',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    DView.spaceHeight(),
                    ...poinPanduan.map((e) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('●'),
                            DView.spaceWidth(),
                            Expanded(
                              child: Text(e),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    DView.spaceHeight(),
                    Text(
                      panduan['warning'],
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
