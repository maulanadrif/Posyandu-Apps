import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/data/model/anak.dart';
import 'package:posyandu_apps/data/model/user.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_anak.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_data_anak.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/anak/detail_data_anak_page.dart';
import 'package:posyandu_apps/presentation/page/anak/update_data_anak_page.dart';

import '../../controller/c_data_user.dart';

class DataAnakPage extends StatefulWidget {
  const DataAnakPage({super.key});

  @override
  State<DataAnakPage> createState() => _DataAnakPageState();
}

class _DataAnakPageState extends State<DataAnakPage> {
  final cDataAnak = Get.put(CDataAnak());
  final cAnak = Get.put(CAnak());
  final cUser = Get.put(CUser());

  refresh() {
    cDataAnak.getListAll();
  }

  menuOption(String value, Anak anak) async {
    if (value == 'detail') {
      Get.to(() => DetailDataAnakPage(
            idAnak: anak.idAnak!,
            nik: anak.nik!,
            namaLengkap: anak.namaLengkap!,
            namaPanggilan: anak.namaPanggilan!,
            jenisKelamin: anak.jenisKelamin!,
            tglLahir: anak.tglLahir!,
            alamat: anak.alamat!,
            anak: anak,
            idUser: anak.idUser!,
          ))?.then((value) {
        if (value ?? false) {
          refresh();
        }
      });
    } else if (value == 'update') {
      Get.to(() => UpdateDataAnakPage(
            idAnak: anak.idAnak!,
            idUser: anak.idUser!,
            namaLengkap: anak.namaLengkap!,
            namaPanggilan: anak.namaPanggilan!,
            jenisKelamin: anak.jenisKelamin!,
            tglLahir: anak.tglLahir!,
            alamat: anak.alamat!,
          ))?.then((value) {
        if (value ?? false) {
          refresh();
        }
      });
    } else if (value == 'delete') {
      bool? yes = await DInfo.dialogConfirmation(
          context, 'Hapus Data Anak', 'Ingin menghapus data?',
          textNo: 'Batal', textYes: 'Ya');
      if (yes!) {
        bool success = await SourceAnak.delete(anak.idAnak!);
        if (success) {
          refresh();
        }
      }
    }
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Text('Data Balita'),
            Expanded(
                child: Container(
              height: 40,
              margin: const EdgeInsets.all(16),
              child: TextField(
                controller: TextEditingController(),
                onTap: () {},
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: AppColor.secondary.withOpacity(0.5),
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    hintText: 'nama',
                    hintStyle: const TextStyle(color: Colors.white)),
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(color: Colors.white),
              ),
            ))
          ],
        ),
      ),
      body: GetBuilder<CDataAnak>(builder: (_) {
        if (_.loading) return DView.loadingCircle();
        if (_.list.isEmpty) return DView.empty('Data Kosong');
        return RefreshIndicator(
          onRefresh: () async => refresh(),
          child: ListView.builder(
              itemCount: _.list.length,
              itemBuilder: (context, index) {
                Anak anak = _.list[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.fromLTRB(16, index == 0 ? 16 : 8, 16,
                      index == _.list.length - 1 ? 16 : 8),
                  child: Row(
                    children: [
                      DView.spaceHeight(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          anak.namaPanggilan!,
                          style: const TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      Expanded(
                          child: Text(
                        anak.jenisKelamin!,
                        style: const TextStyle(
                            color: AppColor.bg,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        textAlign: TextAlign.end,
                      )),
                      PopupMenuButton<String>(
                          itemBuilder: (context) => [
                                const PopupMenuItem(
                                    value: 'detail', child: Text('Detail')),
                                const PopupMenuItem(
                                    value: 'update', child: Text('Update')),
                                const PopupMenuItem(
                                    value: 'delete', child: Text('Delete')),
                              ],
                          onSelected: (value) => menuOption(value, anak))
                    ],
                  ),
                );
              }),
        );
      }),
    );
  }
}
