import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/data/model/anak.dart';
import 'package:posyandu_apps/data/model/user.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_anak.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_data_anak.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/anak/add_data_anak_page.dart';
import 'package:posyandu_apps/presentation/page/anak/add_data_pemeriksaan_page.dart';
import 'package:posyandu_apps/presentation/page/anak/detail_data_anak_page.dart';
import 'package:posyandu_apps/presentation/page/anak/update_data_anak_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/riwayat_penimbangan_page.dart';

class PilihAnakRiwayatPenimbanganPage extends StatefulWidget {
  const PilihAnakRiwayatPenimbanganPage({
    Key? key,
  }) : super(key: key);

  // final User user;
  // final String nik;
  // final String nama;
  // final String alamat;
  // final String role;
  // final String idUser;

  @override
  State<PilihAnakRiwayatPenimbanganPage> createState() =>
      _PilihAnakRiwayatPenimbanganPageState();
}

class _PilihAnakRiwayatPenimbanganPageState
    extends State<PilihAnakRiwayatPenimbanganPage> {
  final cUser = Get.put(CUser());
  final cAnak = Get.put(CAnak());
  final cDataAnak = Get.put(CDataAnak());

  getDataAnak() {
    cDataAnak.getList(cUser.data.idUser);
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
          getDataAnak();
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
          getDataAnak();
        }
      });
    } else if (value == 'delete') {
      bool? yes = await DInfo.dialogConfirmation(
          context, 'Hapus Data Anak', 'Ingin menghapus data?',
          textNo: 'Batal', textYes: 'Ya');
      if (yes!) {
        bool success = await SourceAnak.delete(anak.idAnak!);
        if (success) {
          getDataAnak();
        }
      }
    }
  }

  @override
  void initState() {
    // cUser.init(cUser.setRole('Pasien'), widget.nama);
    getDataAnak();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Pilih Anak'),
      body: GetBuilder<CDataAnak>(builder: (cont) {
        return RefreshIndicator(
          onRefresh: () async => initState(),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
            children: [
              DView.spaceHeight(),
              GetBuilder<CDataAnak>(builder: (_) {
                if (_.loading) return DView.loadingCircle();
                if (_.list.isEmpty) return DView.empty('Data Kosong');
                return RefreshIndicator(
                  onRefresh: () async => getDataAnak(),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _.list.length,
                    itemBuilder: (context, index) {
                      Anak anak = _.list[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => RiwayatPenimbanganPage(
                                anak: anak,
                              ));
                        },
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
                                'Nama Anak : ${anak.namaPanggilan}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.black,
                                size: 40,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        );
      }),
    );
  }
}
