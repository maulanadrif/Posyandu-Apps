import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/data/model/user.dart';
import 'package:posyandu_apps/presentation/controller/c_data_user.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/admin/detail_data_imunisasi_page.dart';
import 'package:posyandu_apps/presentation/page/admin/detail_data_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/admin/pilih_anak_data_imunisasi_page.dart';

class PilihIbuBalitaDataImunisasiPage extends StatefulWidget {
  const PilihIbuBalitaDataImunisasiPage({super.key, required this.role});
  final String role;

  @override
  State<PilihIbuBalitaDataImunisasiPage> createState() =>
      _PilihIbuBalitaDataImunisasiPageState();
}

class _PilihIbuBalitaDataImunisasiPageState
    extends State<PilihIbuBalitaDataImunisasiPage> {
  final cDataUser = Get.put(CDataUser());
  final cUser = Get.put(CUser());

  refresh() {
    cDataUser.getList(cUser.data.idUser, widget.role);
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Pilih Ibu Balita'),
      body: GetBuilder<CDataUser>(builder: (_) {
        if (_.loading) return DView.loadingCircle();
        if (_.list.isEmpty) return DView.empty('Data Kosong');
        return RefreshIndicator(
          onRefresh: () async => refresh(),
          child: ListView.builder(
              itemCount: _.list.length,
              itemBuilder: (context, index) {
                User user = _.list[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(
                      () => PilihAnakDataImunisasiPage(
                        user: user,
                        nik: user.nik!,
                        nama: user.nama!,
                        alamat: user.alamat!,
                        role: user.role!,
                        idUser: user.idUser!,
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(
                      16,
                      index == 0 ? 30 : 8,
                      16,
                      index == _.list.length - 1 ? 16 : 8,
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
                              'Nama Ibu : ${user.nama}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            DView.spaceHeight(),
                            Text(
                              'NIK : ${user.nik}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
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
              }),
        );
      }),
    );
  }
}
