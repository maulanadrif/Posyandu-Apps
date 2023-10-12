// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:d_chart/d_chart.dart';
import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/config/constant/app_constant.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/data/model/anak.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_data_anak.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_detail_data_anak.dart';
import 'package:posyandu_apps/presentation/controller/c_data_user.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/admin/riwayat_data_penimbangan_page.dart';
import 'package:posyandu_apps/presentation/page/anak/add_data_pemeriksaan_page.dart';
import 'package:posyandu_apps/presentation/page/anak/bb_chart.dart';
import 'package:posyandu_apps/presentation/page/anak/tb_chart.dart';
import 'package:posyandu_apps/presentation/page/anak/update_data_anak_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/riwayat_penimbangan_page.dart';

class DetailDataAnakPage extends StatefulWidget {
  const DetailDataAnakPage({
    Key? key,
    required this.nik,
    required this.namaLengkap,
    required this.namaPanggilan,
    required this.jenisKelamin,
    required this.tglLahir,
    required this.alamat,
    required this.idAnak,
    required this.anak,
    required this.idUser,
  }) : super(key: key);

  final String idAnak;
  final String nik;
  final String namaLengkap;
  final String namaPanggilan;
  final String jenisKelamin;
  final String tglLahir;
  final String alamat;
  final String idUser;
  final Anak anak;

  @override
  State<DetailDataAnakPage> createState() => _DetailDataAnakPageState();
}

class _DetailDataAnakPageState extends State<DetailDataAnakPage> {
  final cUser = Get.put(CUser());
  final cDataUser = Get.put(CDataUser());
  final cDetailDataAnak = Get.put(CDetailDataAnak());
  final cDataAnak = Get.put(CDataAnak());

  // DateTime dateOfBirth = DateTime(2021, 9, 16); // Tanggal lahir contoh

  calculateAge(DateTime dateOfBirth) {
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(dateOfBirth);
    int year = (difference.inDays / 365).floor();
    int ageInMonths = difference.inDays ~/ 30;
    int remainingDays = difference.inDays % 30;

    if (remainingDays > 16) {
      int ageInMonthsbulat = ageInMonths + 1;
      return ageInMonthsbulat;
    } else {
      return ageInMonths;
    }

    // return('Usia: $year tahun $ageInMonths bulan $remainingDays hari');
  }

  indikatorBerat(double bb, double bbMin, double bbMax) {
    if (bb < bbMin) return 'Kurang';
    if (bb > bbMax) return 'Resiko Berat Badan Lebih';
    return 'Normal';
  }

  indikatorTinggi(double tb, double tbMin, double tbMax) {
    if (tb < tbMin) return 'Kurang';
    if (tb > tbMax) return 'Tinggi';
    return 'Normal';
  }

  refresh() {
    cDataAnak.getListAll();
  }

  delete(Anak anak) async {
    bool? yes = await DInfo.dialogConfirmation(context, 'Hapus Data Anak',
        'Ingin menghapus data ${widget.namaPanggilan}?',
        textNo: 'Batal', textYes: 'Ya');
    if (yes!) {
      bool success = await SourceAnak.delete(anak.idAnak!);
      if (success) {
        refresh();
      }
    }
  }

  @override
  void initState() {
    cDetailDataAnak.getChartPemeriksaan(widget.idAnak);
    cDetailDataAnak.tglLahir = DateTime.parse(widget.tglLahir);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Detail Data Anak'),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => delete(widget.anak),
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              'Nama Anak',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
            padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.namaLengkap,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
            child: Text(
              'Jenis Kelamin',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
            padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.jenisKelamin,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
            child: Text(
              'Tanggal Lahir',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
            padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              AppFormat.date(widget.tglLahir),
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
            child: Text(
              'Usia',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
            padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${calculateAge(DateTime.parse(widget.tglLahir))} Bulan',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          DView.spaceHeight(30),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 4,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: () {
                      Get.to(
                        () => UpdateDataAnakPage(
                          idAnak: widget.idAnak,
                          idUser: widget.idUser,
                          namaLengkap: widget.namaLengkap,
                          namaPanggilan: widget.namaPanggilan,
                          jenisKelamin: widget.jenisKelamin,
                          tglLahir: widget.tglLahir,
                          alamat: widget.alamat,
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          'UPDATE DATA',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                DView.spaceWidth(),
                Material(
                  elevation: 4,
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: () {
                      Get.to(RiwayatPenimbanganPage(anak: widget.anak));
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          'LIHAT DATA PENIMBANGAN',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Obx bbChart() {
    return Obx(() {
      int usia = calculateAge(cDetailDataAnak.tglLahir);
      Map dataideal;
      if (widget.jenisKelamin == 'Perempuan') {
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
      if (cDetailDataAnak.chart_pemeriksaan.isEmpty) {
        return Text('Belum ada data');
      }
      double beratBadan =
          double.parse(cDetailDataAnak.chart_pemeriksaan['berat_badan']);
      double bbMin = dataideal['bb_min'];
      double bbMax = dataideal['bb_max'];
      String descBB = indikatorBerat(beratBadan, bbMin, bbMax);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BBChart.withSampleData(beratBadan, bbMin, bbMax),
          ),
          DView.spaceHeight(),
          Row(
            children: [
              Text(
                'Berat Badan : ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                '$beratBadan ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'kg ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '($descBB)',
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
          Text('Berat ideal antara ${bbMin} kg - ${bbMax} kg')
        ],
      );
    });
  }

  Obx tbChart() {
    return Obx(() {
      int usia = calculateAge(cDetailDataAnak.tglLahir);
      Map dataideal;
      if (widget.jenisKelamin == 'Perempuan') {
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
      if (cDetailDataAnak.chart_pemeriksaan.isEmpty) {
        return Text('Belum ada data');
      }
      double tinggiBadan =
          double.parse(cDetailDataAnak.chart_pemeriksaan['tinggi_badan']);
      double tbMin = dataideal['tb_min'].toDouble();
      double tbMax = dataideal['tb_max'].toDouble();
      String descTB = indikatorTinggi(tinggiBadan, tbMin, tbMax);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: TBChart.withSampleData(tinggiBadan),
          ),
          DView.spaceHeight(),
          Row(
            children: [
              Text(
                'Tinggi Badan : ',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '$tinggiBadan ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'cm ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '($descTB)',
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
          Text('Tinggi ideal antara ${tbMin} cm - ${tbMax} cm')
        ],
      );
    });
  }
}
