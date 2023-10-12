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
import 'package:posyandu_apps/data/source/source_user.dart';
import 'package:posyandu_apps/presentation/controller/c_presensi.dart';
import 'package:posyandu_apps/presentation/page/admin/list_pasien_page.dart';

class LihatPresensiPage extends StatefulWidget {
  const LihatPresensiPage({super.key, required this.kegiatan});
  final Map kegiatan;

  @override
  State<LihatPresensiPage> createState() => _LihatPresensiPageState();
}

class _LihatPresensiPageState extends State<LihatPresensiPage> {
  final cPresensi = Get.put(CPresensi());

  delete(String idPresensi) async {
    bool? yes = await DInfo.dialogConfirmation(
        context, 'Hapus Data Presensi', 'Ingin menghapus data?',
        textNo: 'Batal', textYes: 'Ya');
    if (yes!) {
      bool success = await SourceUser.deletePresensi(idPresensi);
      if (success) {
        cPresensi.getList(widget.kegiatan['id_kegiatan']);
      }
    }
  }

  menuOption(String value) async {
    if (value == 'hadir') {}
  }

  @override
  void initState() {
    cPresensi.getList(widget.kegiatan['id_kegiatan']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarModif.appBar('Lihat Data Presensi'),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(start: 16, top: 16),
              child: Text('Kegiatan :',
                  style: Theme.of(context).textTheme.headline6!),
            ),
            cardKegiatan(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('List kehadiran :',
                  style: Theme.of(context).textTheme.headline6!),
            ),
            Expanded(child: Obx(() {
              List list = cPresensi.list;
              if (list.isEmpty) return DView.empty();
              return ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  Map item = list[index];
                  return Container(
                    margin: EdgeInsets.fromLTRB(
                      16,
                      index == 0 ? 16 : 8,
                      16,
                      index == list.length - 1 ? 16 : 8,
                    ),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama Ibu : ${item['nama']}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            DView.spaceHeight(),
                            Text(
                              'NIK : ${item['nik']}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            delete(item['id_presensi']);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.fromLTRB(16, index == 0 ? 16 : 8, 16,
                        index == list.length - 1 ? 16 : 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item['nama'],
                            style: const TextStyle(
                                color: AppColor.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            delete(item['id_presensi']);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        // PopupMenuButton<String>(
                        //   itemBuilder: (context) => [
                        //     const PopupMenuItem(
                        //       value: 'hadir', child: Text('Hadir')),
                        //   ],
                        //   onSelected: (value) => menuOption(value)
                        // )
                      ],
                    ),
                  );
                  return ListTile(
                    title: Text(item['nama_panggilan']),
                    subtitle: Text(item['jenis_kelamin']),
                  );
                },
              );
            })),
          ],
        ));
  }

  Widget cardKegiatan() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Material(
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
      ),
    );
  }
}
