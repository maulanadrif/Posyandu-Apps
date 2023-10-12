import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_data_pemeriksaan.dart';

class AddDataPemeriksaanPage extends StatefulWidget {
  const AddDataPemeriksaanPage({
    super.key,
    required this.idAnak,
  });
  final String idAnak;

  @override
  State<AddDataPemeriksaanPage> createState() => _AddDataPemeriksaanPageState();
}

class _AddDataPemeriksaanPageState extends State<AddDataPemeriksaanPage> {
  final cDataPemeriksaan = Get.put(CDataPemeriksaan());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Tambah Data Penimbangan'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Tanggal Pelaksanaan Layanan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          DView.spaceHeight(8),
          Row(
            children: [
              Obx(() {
                return Text(cDataPemeriksaan.tgl);
              }),
              DView.spaceWidth(),
              ElevatedButton.icon(
                onPressed: () async {
                  DateTime? result = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023, 01, 01),
                      lastDate: DateTime(DateTime.now().year + 1));
                  if (result != null) {
                    cDataPemeriksaan.tgl = AppFormat.justdate(result);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 4,
                ),
                icon: const Icon(
                  Icons.event,
                  color: AppColor.primary,
                ),
                label: const Text(
                  'Pilih',
                  style: TextStyle(
                    color: AppColor.primary,
                  ),
                ),
              ),
            ],
          ),
          DView.spaceHeight(),
          DInput(
            controller: cDataPemeriksaan.beratBadan,
            title: 'Berat Badan',
            hint: 'kg',
            isRequired: true,
            validator: (value) =>
                value == '' ? "Berat badan jangan kosong" : null,
          ),
          DView.spaceHeight(),
          DInput(
            controller: cDataPemeriksaan.tinggiBadan,
            title: 'Tinggi Badan',
            hint: 'cm',
            isRequired: true,
            validator: (value) =>
                value == '' ? "Tinggi badan jangan kosong" : null,
          ),
          DView.spaceHeight(),
          DInput(
            controller: cDataPemeriksaan.lingkarKepala,
            title: 'Lingkar Kepala',
            hint: 'cm',
            isRequired: true,
            validator: (value) =>
                value == '' ? "Lingkar kepala jangan kosong" : null,
          ),
          DView.spaceHeight(),
          DInput(
            controller: cDataPemeriksaan.lingkarLengan,
            title: 'Lingkar Lengan',
            hint: 'cm',
            isRequired: true,
            validator: (value) =>
                value == '' ? "Lingkar lengan jangan kosong" : null,
          ),
          DView.spaceHeight(50),
          Material(
            elevation: 8,
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {
                cDataPemeriksaan.submit(widget.idAnak);
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    'SUBMIT',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: AppColor.primary),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
