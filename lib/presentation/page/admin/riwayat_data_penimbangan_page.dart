import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/data/model/user.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/data/source/source_user.dart';
import 'package:posyandu_apps/presentation/controller/c_data_penimbangan.dart';
import 'package:posyandu_apps/presentation/controller/c_data_user.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/admin/detail_data_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/admin/detail_data_penimbangan_page.dart';
import 'package:posyandu_apps/presentation/page/admin/update_data_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/anak/update_data_pemeriksaan_page.dart';

class RiwayatDataPenimbanganPage extends StatefulWidget {
  const RiwayatDataPenimbanganPage({Key? key}) : super(key: key);

  @override
  State<RiwayatDataPenimbanganPage> createState() => _RiwayatDataPenimbanganPageState();
}

class _RiwayatDataPenimbanganPageState extends State<RiwayatDataPenimbanganPage> {
  final cDataUser = Get.put(CDataUser());
  final cUser = Get.put(CUser());
  final cDataPenimbangan = Get.put(CDataPenimbangan());

  // refresh() {
  //   cDataUser.getList(cUser.data.idUser, widget.role);
  // }

  menuOption(String value, Map item) async {
    if (value == 'detail') {
      Get.to(
        () => DetailDataPenimbanganPage(
          idAnak: item['id_anak'],
          idUser: item['id_user'],
          tglPemeriksaan: item['tgl_pemeriksaan'],
        ),
      );
    } else if (value == 'update') {
      Get.to(() => UpdateDataPemeriksaanPage(pemeriksaan: item,));
    } else if (value == 'delete') {
      bool? yes = await DInfo.dialogConfirmation(
        context,
        'Hapus Data Pasien',
        'Ingin menghapus data?',
        textNo: 'Batal',
        textYes: 'Ya'
      );
      if(yes!) {
        bool success = await SourceAnak.deleteDataPemeriksaan(item['id_pemeriksaan']);
        if(success) {
          cDataPenimbangan.getList();
        }
      }
    }
  }

  @override
  void initState() {
    // refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Penimbangan',
              style: TextStyle(fontSize: 16),
            ),
            Obx(() {
              return Text(
                AppFormat.date(
                  cDataPenimbangan.datePick.toIso8601String(),
                ),
                style: TextStyle(fontSize: 14),
              );
            })
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              cDataPenimbangan.pickDate(context);
            },
            icon: Icon(Icons.event),
          ),
          IconButton(
            onPressed: () {
              cDataPenimbangan.getList();
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Obx(() {
        List list = cDataPenimbangan.list;
        if (cDataPenimbangan.loading) return DView.loadingCircle();
        if (list.isEmpty) return DView.empty('Data Kosong');
        return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              Map item = list[index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.fromLTRB(
                  16,
                  index == 0 ? 16 : 8,
                  16,
                  index == list.length - 1 ? 16 : 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item['nama_panggilan'],
                        style: const TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      ),
                    ),
                    PopupMenuButton<String>(
                        itemBuilder: (context) => [
                              const PopupMenuItem(
                                  value: 'detail', child: Text('Detail')),
                              const PopupMenuItem(
                                  value: 'update', child: Text('Update')),
                              const PopupMenuItem(
                                  value: 'delete', child: Text('Delete')),
                            ],
                        onSelected: (value) => menuOption(value, item))
                  ],
                ),
              );
            });
      }),
    );
  }
}
