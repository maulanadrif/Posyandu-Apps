import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/data/source/source_user.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_data_pemeriksaan.dart';
import 'package:posyandu_apps/presentation/controller/c_all_kegiatan.dart';
import 'package:posyandu_apps/presentation/controller/c_jadwal_pemeriksaan.dart';
import 'package:posyandu_apps/presentation/controller/c_presensi.dart';

class UpdateJadwalPemeriksaanPage extends StatefulWidget {
  const UpdateJadwalPemeriksaanPage({
    super.key,
    required this.kegiatan,
  });
  final Map kegiatan;

  @override
  State<UpdateJadwalPemeriksaanPage> createState() =>
      _UpdateJadwalPemeriksaanPageState();
}

class _UpdateJadwalPemeriksaanPageState
    extends State<UpdateJadwalPemeriksaanPage> {
  final controllerNamaKegiatan = TextEditingController();
  final controllerTglPelaksanaan = TextEditingController();
  final controllerJamPelaksanaan = TextEditingController();
  final controllerTempatPelaksanaan = TextEditingController();
  final controllerDeskripsiKegiatan = TextEditingController();
  final cJadwalPemeriksaan = Get.put(CJadwalPemeriksaan());
  final cAllKegiatan = Get.put(CAllKegiatan());

  updateJadwalPemeriksaan() async {
    bool success = await SourceUser.updateJadwalPemeriksaan(
      widget.kegiatan['id_kegiatan'],
      controllerNamaKegiatan.text,
      cJadwalPemeriksaan.tgl,
      controllerJamPelaksanaan.text,
      controllerTempatPelaksanaan.text,
      controllerDeskripsiKegiatan.text,
    );
    if (success) {
      cAllKegiatan.getList();
    }
  }

  @override
  void initState() {
    controllerNamaKegiatan.text = widget.kegiatan['nama_kegiatan'];
    cJadwalPemeriksaan.tgl = widget.kegiatan['tgl_pelaksanaan'];
    controllerJamPelaksanaan.text = widget.kegiatan['jam_pelaksanaan'];
    controllerTempatPelaksanaan.text = widget.kegiatan['tempat_pelaksanaan'];
    controllerDeskripsiKegiatan.text = widget.kegiatan['deskripsi_kegiatan'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Update Jadwal Pemeriksaan'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DInput(
            controller: controllerNamaKegiatan,
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
              // ElevatedButton.icon(
              //   onPressed: () async {
              //     DateTime? result = await showDatePicker(
              //         context: context,
              //         initialDate: DateTime.now(),
              //         firstDate: DateTime(2023, 01, 01),
              //         lastDate: DateTime(DateTime.now().year + 1));
              //     if (result != null) {
              //       cJadwalPemeriksaan.tgl = AppFormat.justdate(result);
              //     }
              //   },
              //   icon: const Icon(Icons.event),
              //   label: const Text('Pilih'),
              // )
            ],
          ),
          DView.spaceHeight(),
          DInput(
            controller: controllerJamPelaksanaan,
            title: 'Jam Pelaksanaan',
            isRequired: true,
            validator: (value) => value == '' ? "Jam jangan kosong" : null,
          ),
          DView.spaceHeight(),
          DInput(
            controller: controllerTempatPelaksanaan,
            title: 'Tempat Pelaksanaan',
            isRequired: true,
            validator: (value) => value == '' ? "Tempat jangan kosong" : null,
          ),
          DView.spaceHeight(),
          DInput(
            controller: controllerDeskripsiKegiatan,
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
                updateJadwalPemeriksaan();
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    'UPDATE',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: AppColor.primary),
                  ),
                ),
              ),
            ),
          )
          // Material(
          //   color: AppColor.primary,
          //   borderRadius: BorderRadius.circular(8),
          //   child: InkWell(
          //     onTap: () {
          //       updateJadwalPemeriksaan();
          //     },
          //     borderRadius: BorderRadius.circular(8),
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 16),
          //       child: Center(
          //         child: Text(
          //           'SUBMIT',
          //           style: Theme.of(context)
          //               .textTheme
          //               .headline6!
          //               .copyWith(color: Colors.white),
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
