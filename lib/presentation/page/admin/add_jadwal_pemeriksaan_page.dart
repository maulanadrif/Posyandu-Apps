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
import 'package:posyandu_apps/presentation/controller/c_jadwal_pemeriksaan.dart';

class AddJadwalPemeriksaanPage extends StatefulWidget {
  const AddJadwalPemeriksaanPage({
    super.key,
  });

  @override
  State<AddJadwalPemeriksaanPage> createState() =>
      _AddJadwalPemeriksaanPageState();
}

class _AddJadwalPemeriksaanPageState extends State<AddJadwalPemeriksaanPage> {
  final cJadwalPemeriksaan = Get.put(CJadwalPemeriksaan());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Tambah Jadwal Posyandu'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
        children: [
          DInput(
            controller: cJadwalPemeriksaan.namaKegiatan,
            title: 'Nama Kegiatan',
            isRequired: true,
            validator: (value) => value == '' ? "Nama jangan kosong" : null,
          ),
          DView.spaceHeight(),
          const Text(
            'Tanggal Pelaksanaan Kegiatan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          DView.spaceHeight(8),
          Row(
            children: [
              Obx(() {
                return Text(cJadwalPemeriksaan.tgl);
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
                    cJadwalPemeriksaan.tgl = AppFormat.justdate(result);
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
            controller: cJadwalPemeriksaan.jamPelaksanaan,
            title: 'Jam Pelaksanaan',
            isRequired: true,
            validator: (value) => value == '' ? "Jam jangan kosong" : null,
          ),
          DView.spaceHeight(),
          DInput(
            controller: cJadwalPemeriksaan.tempatPelaksanaan,
            title: 'Tempat Pelaksanaan',
            isRequired: true,
            validator: (value) => value == '' ? "Tempat jangan kosong" : null,
          ),
          DView.spaceHeight(),
          DInput(
            controller: cJadwalPemeriksaan.deskripsiKegiatan,
            title: 'Deskripsi Kegiatan',
            isRequired: true,
            validator: (value) =>
                value == '' ? "Deskripsi jangan kosong" : null,
          ),
          DView.spaceHeight(50),
          Material(
            elevation: 8,
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {
                cJadwalPemeriksaan.submit();
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    'SUBMIT',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: AppColor.primary, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
