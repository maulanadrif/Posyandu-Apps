import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/presentation/controller/c_presensi.dart';
import 'package:posyandu_apps/presentation/page/admin/list_pasien_page.dart';

class DetailJadwalPemeriksaan extends StatefulWidget {
  const DetailJadwalPemeriksaan({super.key, required this.kegiatan});
  final Map kegiatan;

  @override
  State<DetailJadwalPemeriksaan> createState() =>
      _DetailJadwalPemeriksaanState();
}

class _DetailJadwalPemeriksaanState extends State<DetailJadwalPemeriksaan> {
  final cPresensi = Get.put(CPresensi());

  @override
  void initState() {
    cPresensi.getList(widget.kegiatan['id_kegiatan']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Detail Jadwal Pemeriksaan'),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Column(
                children: [
                  // cardKegiatan(),
                  // DView.spaceHeight(30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(16),
                        child: SizedBox(
                          width: 375,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 30, 16, 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nama Kegiatan :',
                                  style: Theme.of(context).textTheme.headline6!,
                                ),
                                DView.spaceHeight(),
                                Text(
                                  widget.kegiatan['nama_kegiatan'],
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      DView.spaceHeight(),
                      Material(
                        borderRadius: BorderRadius.circular(16),
                        child: SizedBox(
                          width: 375,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 30, 16, 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Waktu Pelaksanaan :',
                                  style: Theme.of(context).textTheme.headline6!,
                                ),
                                DView.spaceHeight(),
                                Text(
                                  AppFormat.date(
                                      widget.kegiatan['tgl_pelaksanaan']),
                                  style: TextStyle(fontSize: 16),
                                ),
                                DView.spaceHeight(8),
                                Text(
                                  '${widget.kegiatan['jam_pelaksanaan']} WIB',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      DView.spaceHeight(),
                      Material(
                        borderRadius: BorderRadius.circular(16),
                        child: SizedBox(
                          width: 375,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 30, 16, 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tempat Pelaksanaan :',
                                  style: Theme.of(context).textTheme.headline6!,
                                ),
                                DView.spaceHeight(),
                                Text(
                                  widget.kegiatan['tempat_pelaksanaan'],
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      DView.spaceHeight(),
                      Material(
                        borderRadius: BorderRadius.circular(16),
                        child: SizedBox(
                          width: 375,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 30, 16, 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Deskripsi Kegiatan :',
                                  style: Theme.of(context).textTheme.headline6!,
                                ),
                                DView.spaceHeight(),
                                Text(
                                  widget.kegiatan['deskripsi_kegiatan'],
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          )),
    );
  }

  Widget cardKegiatan() {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 4,
      color: AppColor.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
            child: Text(
              widget.kegiatan['nama_kegiatan'],
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold, color: AppColor.secondary),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 4),
            child: Text(
              AppFormat.date(widget.kegiatan['tgl_pelaksanaan']),
              style: TextStyle(
                color: AppColor.bg,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 30),
            child: Text(
              widget.kegiatan['tempat_pelaksanaan'],
              style: TextStyle(
                color: AppColor.bg,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
