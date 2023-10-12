import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/config/constant/app_constant.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/data/model/anak.dart';
import 'package:posyandu_apps/data/model/user.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/data/source/source_user.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_anak.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_data_anak.dart';
import 'package:posyandu_apps/presentation/controller/c_pilih_imunisasi.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/anak/add_data_anak_page.dart';
import 'package:posyandu_apps/presentation/page/anak/add_data_pemeriksaan_page.dart';
import 'package:posyandu_apps/presentation/page/anak/detail_data_anak_page.dart';
import 'package:posyandu_apps/presentation/page/anak/update_data_anak_page.dart';

class PilihTurunanImunisasiPage extends StatefulWidget {
  const PilihTurunanImunisasiPage({
    Key? key,
    required this.imunisasi,
    required this.idAnak,
  }) : super(key: key);
  final MapEntry imunisasi;
  final String idAnak;

  @override
  State<PilihTurunanImunisasiPage> createState() =>
      _PilihTurunanImunisasiPageState();
}

class _PilihTurunanImunisasiPageState extends State<PilihTurunanImunisasiPage> {
  final cUser = Get.put(CUser());
  final cAnak = Get.put(CAnak());
  final cDataAnak = Get.put(CDataAnak());
  final cPilihImunisasi = Get.put(CPilihImunisasi());

  // getDataAnak() {
  //   cDataAnak.getList(widget.user.idUser);
  // }

  setImunisasi(String itemImunisasi) {
    DInfo.dialogConfirmation(
      context,
      'Set $itemImunisasi',
      'Klik Ya untuk konfirmasi',
      textNo: 'Batal',
      textYes: 'Ya',
    ).then((yes) {
      if (yes ?? false) {
        SourceUser.setImunisasi(
          widget.idAnak,
          itemImunisasi,
        ).then((success) {
          if (success) {
            DInfo.toastSuccess('Berhasil set imunisasi');
            refresh();
          } else {
            DInfo.toastError('Gagal set imunisasi');
          }
        });
      }
    });
  }

  cancelImunisasi(itemImunisasi) {
    DInfo.dialogConfirmation(
      context,
      'Hapus $itemImunisasi',
      'Klik Ya untuk konfirmasi',
      textNo: 'Batal',
      textYes: 'Ya',
    ).then((yes) {
      if (yes ?? false) {
        SourceUser.cancelImunisasi(
          widget.idAnak,
          itemImunisasi,
        ).then((success) {
          if (success) {
            DInfo.toastSuccess('Berhasil cancel imunisasi');
            refresh();
          } else {
            DInfo.toastError('Gagal cancel imunisasi');
          }
        });
      }
    });
  }

  refresh() {
    cPilihImunisasi.getList(widget.idAnak);
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Pilih Imunisasi'),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: widget.imunisasi.value.length,
        itemBuilder: (context, index) {
          String itemImunisasi = widget.imunisasi.value[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.fromLTRB(16, 30, 16, 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    itemImunisasi,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Obx(() {
                    List sudahImunisasi = cPilihImunisasi.list;
                    return Checkbox(
                      value: sudahImunisasi.contains(itemImunisasi),
                      onChanged: (value) {
                        if (value ?? false) {
                          setImunisasi(itemImunisasi);
                        } else {
                          cancelImunisasi(itemImunisasi);
                        }
                      },
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
