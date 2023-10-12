import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/config/constant/app_constant.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_data_anak.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_detail_data_penimbangan.dart';
import 'package:posyandu_apps/presentation/page/anak/bb_chart.dart';
import 'package:posyandu_apps/presentation/page/anak/tb_chart.dart';

class DetailDataPenimbanganPage extends StatefulWidget {
  const DetailDataPenimbanganPage(
      {super.key,
      required this.idAnak,
      required this.idUser,
      required this.tglPemeriksaan});
  final String idAnak;
  final String idUser;
  final String tglPemeriksaan;

  @override
  State<DetailDataPenimbanganPage> createState() =>
      _DetailDataPenimbanganPageState();
}

class _DetailDataPenimbanganPageState extends State<DetailDataPenimbanganPage> {
  final cDetailPenimbangan = Get.put(CDetailDataPenimbangan());

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

  @override
  void initState() {
    cDetailPenimbangan.getDataPemeriksaan(
        widget.idAnak, widget.idUser, widget.tglPemeriksaan);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Detail Data Penimbangan'),
      body: ListView(
        children: [viewAnak(), viewOrtu(), viewPemeriksaan()],
      ),
    );
  }

  Obx viewAnak() {
    return Obx(() {
      Map anak = cDetailPenimbangan.anak;
      // Map ortu = cDetailPenimbangan.ortu;
      // Map pemeriksaan = cDetailPenimbangan.pemeriksaan;
      if (anak.isEmpty) return DView.empty();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTile(
            tileColor: AppColor.bg,
            title: Text(
              'Data Anak',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DView.spaceHeight(),
                Text(
                  'NIK : ${anak['nik']}',
                  style: const TextStyle(fontSize: 16),
                ),
                DView.spaceHeight(8),
                Text(
                  'Nama Lengkap : ${anak['nama_lengkap']}',
                  style: const TextStyle(fontSize: 16),
                ),
                DView.spaceHeight(8),
                Text(
                  'Nama Panggilan : ${anak['nama_panggilan']}',
                  style: const TextStyle(fontSize: 16),
                ),
                DView.spaceHeight(8),
                Text(
                  'Jenis Kelamin : ${anak['jenis_kelamin']}',
                  style: const TextStyle(fontSize: 16),
                ),
                DView.spaceHeight(8),
                Text(
                  'Tanggal Lahir : ${AppFormat.date(anak['tgl_lahir'])}',
                  style: const TextStyle(fontSize: 16),
                ),
                DView.spaceHeight(8),
                Text(
                  'Usia : ${calculateAge(DateTime.parse(anak['tgl_lahir']))} Bulan',
                  style: const TextStyle(fontSize: 16),
                ),
                DView.spaceHeight(8),
                Text(
                  'Alamat : ${anak['alamat']}',
                  style: const TextStyle(fontSize: 16),
                ),
                DView.spaceHeight()
              ],
            ),
          ),
        ],
      );
    });
  }

  Obx viewOrtu() {
    return Obx(() {
      // Map anak = cDetailPenimbangan.anak;
      Map ortu = cDetailPenimbangan.ortu;
      // Map pemeriksaan = cDetailPenimbangan.pemeriksaan;
      if (ortu.isEmpty) return DView.empty();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTile(
            tileColor: AppColor.bg,
            title: Text(
              'Data Orangtua',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DView.spaceHeight(),
                Text(
                  'NIK : ${ortu['nik']}',
                  style: const TextStyle(fontSize: 16),
                ),
                DView.spaceHeight(8),
                Text(
                  'Nama Lengkap : ${ortu['nama']}',
                  style: const TextStyle(fontSize: 16),
                ),
                DView.spaceHeight(8),
                Text(
                  'Alamat : ${ortu['alamat']}',
                  style: const TextStyle(fontSize: 16),
                ),
                DView.spaceHeight()
              ],
            ),
          ),
        ],
      );
    });
  }

  Obx viewPemeriksaan() {
    return Obx(() {
      Map anak = cDetailPenimbangan.anak;
      // Map ortu = cDetailPenimbangan.ortu;
      Map pemeriksaan = cDetailPenimbangan.pemeriksaan;
      if (pemeriksaan.isEmpty) return DView.empty();
      int usia = calculateAge(DateTime.parse(anak['tgl_lahir']));
      Map dataideal;
      if (anak['jenis_kelamin'] == 'Perempuan') {
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
      String descBB = indikatorBerat(beratBadan, bbMin, bbMax);

      double tinggiBadan = double.parse(pemeriksaan['tinggi_badan']);
      double tbMin = dataideal['tb_min'].toDouble();
      double tbMax = dataideal['tb_max'].toDouble();
      String descTB = indikatorTinggi(tinggiBadan, tbMin, tbMax);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            tileColor: AppColor.bg,
            title: Text(
              'Data Pemeriksaan',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            subtitle: Text(
              AppFormat.date(widget.tglPemeriksaan),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Berat Badan Menurut Umur (${anak['jenis_kelamin']})',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold,
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
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '$beratBadan ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'kg ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '($descBB)',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                Text('Berat ideal antara ${bbMin} kg - ${bbMax} kg')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tinggi Badan Menurut Umur (${anak['jenis_kelamin']})',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold,
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
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '$tinggiBadan ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'cm ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '($descTB)',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                Text('Tinggi ideal antara ${tbMin} cm - ${tbMax} cm')
              ],
            ),
          ),
        ],
      );
    });
  }
}
