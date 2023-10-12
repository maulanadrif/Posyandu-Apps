import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/constant/app_constant.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/config/app_method.dart';
import 'package:posyandu_apps/data/model/anak.dart';
import 'package:posyandu_apps/presentation/controller/c_riwayat_pemeriksaan.dart';
import 'package:posyandu_apps/presentation/page/anak/bb_chart.dart';
import 'package:posyandu_apps/presentation/page/anak/tb_chart.dart';

class DetailRiwayatPenimbanganPage extends StatefulWidget {
  const DetailRiwayatPenimbanganPage(
      {super.key, required this.anak, required this.pemeriksaan});
  final Anak anak;
  final Map pemeriksaan;

  @override
  State<DetailRiwayatPenimbanganPage> createState() =>
      _DetailRiwayatPenimbanganPageState();
}

class _DetailRiwayatPenimbanganPageState
    extends State<DetailRiwayatPenimbanganPage> {
  final cRiwayatPemeriksaan = Get.put(CRiwayatPemeriksaan());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cRiwayatPemeriksaan.getList(widget.anak.idAnak);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map pemeriksaan = widget.pemeriksaan;
    int usia = AppMethod.calculateAge(DateTime.parse(widget.anak.tglLahir!));
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
    double beratBadan = double.parse(pemeriksaan['berat_badan']);
    double bbMin = dataideal['bb_min'];
    double bbMax = dataideal['bb_max'];
    String descBB = AppMethod.indikatorBerat(beratBadan, bbMin, bbMax);

    double tinggiBadan = double.parse(pemeriksaan['tinggi_badan']);
    double tbMin = dataideal['tb_min'].toDouble();
    double tbMax = dataideal['tb_max'].toDouble();
    String descTB = AppMethod.indikatorTinggi(tinggiBadan, tbMin, tbMax);
    return Scaffold(
      appBar: AppBarModif.appBar('Detail Riwayat Penimbangan'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
        children: [
          Text(
            'Tanggal Pemeriksaan : ${AppFormat.date(pemeriksaan['tgl_pemeriksaan'])}',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          DView.spaceHeight(),
          bbChart(beratBadan, bbMin, bbMax, descBB),
          tbChart(tinggiBadan, descTB, tbMin, tbMax),
          DView.spaceHeight(),
          panduan(),
        ],
      ),
    );
  }

  Card tbChart(double tinggiBadan, String descTB, double tbMin, double tbMax) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Tinggi Badan Menurut Umur',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '(${widget.anak.jenisKelamin})',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    DView.spaceHeight(),
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: TBChart.withSampleData(tinggiBadan),
                    ),
                    DView.spaceHeight(),
                    Row(
                      children: [
                        Text(
                          'Tinggi Badan : ',
                        ),
                        Text(
                          '$tinggiBadan ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'cm ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '($descTB)',
                        )
                      ],
                    ),
                    DView.spaceHeight(4),
                    Text('Tinggi ideal antara ${tbMin} cm - ${tbMax} cm')
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Card bbChart(double beratBadan, double bbMin, double bbMax, String descBB) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Berat Badan Menurut Umur',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '(${widget.anak.jenisKelamin})',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    DView.spaceHeight(),
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: BBChart.withSampleData(beratBadan, bbMin, bbMax),
                    ),
                    DView.spaceHeight(),
                    Row(
                      children: [
                        Text(
                          'Berat Badan : ',
                        ),
                        Text(
                          '$beratBadan ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'kg ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '($descBB)',
                        )
                      ],
                    ),
                    DView.spaceHeight(4),
                    Text('Berat ideal antara ${bbMin} kg - ${bbMax} kg'),
                  ],
                ),
              ),
              DView.spaceHeight(),
            ],
          ),
        ],
      ),
    );
  }

  Widget panduan() {
    int usia = AppMethod.calculateAge(DateTime.parse(widget.anak.tglLahir!));
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
    return Card(
      margin: EdgeInsets.only(bottom: 16),
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
                      'Panduan',
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
