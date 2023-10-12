import 'package:d_chart/d_chart.dart';
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
import 'package:posyandu_apps/presentation/controller/anak/c_detail_data_anak.dart';
import 'package:posyandu_apps/presentation/controller/c_data_user.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/anak/add_data_pemeriksaan_page.dart';
import 'package:posyandu_apps/presentation/page/anak/bb_chart.dart';
import 'package:posyandu_apps/presentation/page/anak/tb_chart.dart';

class DetailDataAnakPasienPage extends StatefulWidget {
  const DetailDataAnakPasienPage({
    Key? key,
    required this.nik,
    required this.namaLengkap,
    required this.namaPanggilan,
    required this.jenisKelamin,
    required this.tglLahir,
    required this.alamat,
    required this.idAnak,
  }) : super(key: key);

  final String idAnak;
  final String nik;
  final String namaLengkap;
  final String namaPanggilan;
  final String jenisKelamin;
  final String tglLahir;
  final String alamat;

  @override
  State<DetailDataAnakPasienPage> createState() =>
      _DetailDataAnakPasienPageState();
}

class _DetailDataAnakPasienPageState extends State<DetailDataAnakPasienPage> {
  final cUser = Get.put(CUser());
  final cDataUser = Get.put(CDataUser());
  final cDetailDataAnak = Get.put(CDetailDataAnak());

  @override
  void initState() {
    cDetailDataAnak.tglLahir = DateTime.parse(widget.tglLahir);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Detail Data Anak'),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
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
              '${AppMethod.calculateAge(DateTime.parse(widget.tglLahir))} Bulan',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
