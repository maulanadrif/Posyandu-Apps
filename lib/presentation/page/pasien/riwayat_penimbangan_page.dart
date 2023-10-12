import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/config/constant/app_constant.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/config/app_method.dart';
import 'package:posyandu_apps/data/model/anak.dart';
import 'package:posyandu_apps/presentation/controller/c_riwayat_pemeriksaan.dart';
import 'package:posyandu_apps/presentation/page/anak/bb_chart.dart';
import 'package:posyandu_apps/presentation/page/anak/tb_chart.dart';
import 'package:posyandu_apps/presentation/page/pasien/detail_riwayat_penimbangan_page.dart';

class RiwayatPenimbanganPage extends StatefulWidget {
  const RiwayatPenimbanganPage({super.key, required this.anak});
  final Anak anak;

  @override
  State<RiwayatPenimbanganPage> createState() => _RiwayatPenimbanganPageState();
}

class _RiwayatPenimbanganPageState extends State<RiwayatPenimbanganPage> {
  final cRiwayatPemeriksaan = Get.put(CRiwayatPemeriksaan());

  @override
  void initState() {
    cRiwayatPemeriksaan.getList(widget.anak.idAnak);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Riwayat Penimbangan'),
      body: Obx(() {
        if (cRiwayatPemeriksaan.loading) return DView.loadingCircle();
        List list = cRiwayatPemeriksaan.list;
        if (list.isEmpty) return DView.empty();
        return ListView.builder(
          padding: EdgeInsets.all(0),
          itemCount: list.length,
          itemBuilder: (context, index) {
            Map pemeriksaan = list[index];
            int usia =
                AppMethod.calculateAge(DateTime.parse(widget.anak.tglLahir!));
            Map dataideal;
            if (widget.anak.jenisKelamin == 'Perempuan') {
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
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text(
                    'Didata pada tanggal ${AppFormat.date(pemeriksaan['tgl_pemeriksaan'])}',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        pemeriksaan == null
                            ? DView.empty('Anak belum pernah didata')
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 16, 16, 50),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Berat Badan Menurut Umur',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  '(${widget.anak.jenisKelamin})',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          DView.spaceHeight(),
                                          AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: BBChart.withSampleData(
                                                beratBadan, bbMin, bbMax),
                                          ),
                                          DView.spaceHeight(),
                                          Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  'Usia : ${AppMethod.calculateAge(DateTime.parse(widget.anak.tglLahir!))} Bulan',
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
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    'kg ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    '($descBB)',
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          DView.spaceHeight(4),
                                          Center(
                                            child: Text(
                                              'Berat ideal antara ${bbMin} kg - ${bbMax} kg',
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(16, 16, 16, 30),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Tinggi Badan Menurut Umur',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  '(${widget.anak.jenisKelamin})',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          DView.spaceHeight(),
                                          AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: TBChart.withSampleData(
                                                tinggiBadan),
                                          ),
                                          DView.spaceHeight(),
                                          Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  'Usia : ${AppMethod.calculateAge(DateTime.parse(widget.anak.tglLahir!))} Bulan',
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
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    'cm ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    '($descTB)',
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          DView.spaceHeight(4),
                                          Center(
                                            child: Text(
                                                'Tinggi ideal antara ${tbMin} cm - ${tbMax} cm'),
                                          )
                                        ],
                                      ),
                                    ),
                                    Center(
                                      child: Column(
                                        children: [
                                          if (pemeriksaan != null)
                                            ElevatedButton(
                                              onPressed: () {
                                                Get.to(
                                                  () =>
                                                      DetailRiwayatPenimbanganPage(
                                                    anak: widget.anak,
                                                    pemeriksaan: pemeriksaan,
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                'Lihat Detail',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                elevation: 4,
                                                primary: Colors.white,
                                                onPrimary: AppColor.primary,
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
                ),
              ],
            );
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tanggal Pemeriksaan : ${AppFormat.date(pemeriksaan['tgl_pemeriksaan'])}',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  DView.spaceHeight(),
                  Card(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Column(
                      children: [
                        pemeriksaan == null
                            ? DView.empty('Anak belum pernah didata')
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Berat Badan Menurut Umur (${widget.anak.jenisKelamin})',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        DView.spaceHeight(),
                                        AspectRatio(
                                          aspectRatio: 16 / 9,
                                          child: BBChart.withSampleData(
                                              beratBadan, bbMin, bbMax),
                                        ),
                                        DView.spaceHeight(),
                                        Row(
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
                                        DView.spaceHeight(4),
                                        Text(
                                            'Berat ideal antara ${bbMin} kg - ${bbMax} kg')
                                      ],
                                    ),
                                  ),
                                  DView.spaceHeight(),
                                ],
                              ),
                      ],
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Column(
                      children: [
                        pemeriksaan == null
                            ? DView.empty('Anak belum pernah didata')
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Tinggi Badan Menurut Umur (${widget.anak.jenisKelamin})',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        DView.spaceHeight(),
                                        AspectRatio(
                                          aspectRatio: 16 / 9,
                                          child: TBChart.withSampleData(
                                              tinggiBadan),
                                        ),
                                        DView.spaceHeight(),
                                        Row(
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
                                        DView.spaceHeight(4),
                                        Text(
                                            'Tinggi ideal antara ${tbMin} cm - ${tbMax} cm')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        if (pemeriksaan != null)
                          ElevatedButton(
                            onPressed: () {
                              Get.to(
                                () => DetailRiwayatPenimbanganPage(
                                  anak: widget.anak,
                                  pemeriksaan: pemeriksaan,
                                ),
                              );
                            },
                            child: Text(
                              'Lihat Detail',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 4,
                              primary: Colors.white,
                              onPrimary: AppColor.primary,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
