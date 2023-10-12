import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/data/model/anak.dart';
import 'package:posyandu_apps/data/model/user.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/data/source/source_user.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_anak.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_data_anak.dart';
import 'package:posyandu_apps/presentation/controller/c_data_user.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/admin/update_data_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/anak/add_data_anak_page.dart';
import 'package:posyandu_apps/presentation/page/anak/detail_data_anak_page.dart';
import 'package:posyandu_apps/presentation/page/anak/update_data_anak_page.dart';

class DetailDataPasienPage extends StatefulWidget {
  const DetailDataPasienPage(
      {Key? key,
      required this.user,
      required this.nik,
      required this.nama,
      required this.alamat,
      required this.role,
      required this.idUser})
      : super(key: key);

  final User user;
  final String nik;
  final String nama;
  final String alamat;
  final String role;
  final String idUser;

  @override
  State<DetailDataPasienPage> createState() => _DetailDataPasienPageState();
}

class _DetailDataPasienPageState extends State<DetailDataPasienPage> {
  final cUser = Get.put(CUser());
  final cAnak = Get.put(CAnak());
  final cDataAnak = Get.put(CDataAnak());
  final cDataUser = Get.put(CDataUser());

  getDataAnak() {
    cDataAnak.getList(widget.user.idUser);
  }

  refresh() {
    cDataUser.getList(cUser.data.idUser, widget.role);
  }

  // menuOption(String value, Anak anak) async {
  //   if (value == 'detail') {
  //     Get.to(() => DetailDataAnakPage(
  //           idAnak: anak.idAnak!,
  //           nik: anak.nik!,
  //           namaLengkap: anak.namaLengkap!,
  //           namaPanggilan: anak.namaPanggilan!,
  //           jenisKelamin: anak.jenisKelamin!,
  //           tglLahir: anak.tglLahir!,
  //           alamat: anak.alamat!,
  //         ))?.then((value) {
  //       if (value ?? false) {
  //         getDataAnak();
  //       }
  //     });
  //   } else if (value == 'update') {
  //     Get.to(() => UpdateDataAnakPage(
  //           idAnak: anak.idAnak!,
  //           idUser: anak.idUser!,
  //           namaLengkap: anak.namaLengkap!,
  //           namaPanggilan: anak.namaPanggilan!,
  //           jenisKelamin: anak.jenisKelamin!,
  //           tglLahir: anak.tglLahir!,
  //           alamat: anak.alamat!,
  //         ))?.then((value) {
  //       if (value ?? false) {
  //         getDataAnak();
  //       }
  //     });
  //   } else if (value == 'delete') {
  //     bool? yes = await DInfo.dialogConfirmation(
  //         context, 'Hapus Data Anak', 'Ingin menghapus data?',
  //         textNo: 'Batal', textYes: 'Ya');
  //     if (yes!) {
  //       bool success = await SourceAnak.delete(anak.idAnak!);
  //       if (success) {
  //         getDataAnak();
  //       }
  //     }
  //   }
  // }

  delete(User user) async {
    bool? yes = await DInfo.dialogConfirmation(
        context, 'Hapus Data Admin', 'Ingin menghapus data ibu ${widget.nama}?',
        textNo: 'Batal', textYes: 'Ya');
    if (yes!) {
      bool success = await SourceUser.delete(user.nik!);
      if (success) {
        refresh();
      }
    }
  }

  @override
  void initState() {
    cUser.init(cUser.setRole('Pasien'), widget.nama);
    getDataAnak();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Detail Data Pasien'),
      body: GetBuilder<CDataAnak>(builder: (cont) {
        return RefreshIndicator(
          onRefresh: () async => initState(),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 30, 16, 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Nama Ibu : ${widget.nama}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              DView.spaceHeight(),
              Container(
                padding: EdgeInsets.fromLTRB(16, 30, 16, 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'NIK : ${widget.nik}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              DView.spaceHeight(),
              Container(
                padding: EdgeInsets.fromLTRB(16, 30, 16, 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Alamat : ${widget.alamat}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              DView.spaceHeight(),
              Container(
                padding: EdgeInsets.fromLTRB(16, 30, 16, 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Role : ${widget.role}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
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
                          Get.to(
                            () => DetailDataAnakPage(
                              nik: anak.nik!,
                              namaLengkap: anak.namaLengkap!,
                              namaPanggilan: anak.namaPanggilan!,
                              jenisKelamin: anak.jenisKelamin!,
                              tglLahir: anak.tglLahir!,
                              alamat: anak.alamat!,
                              idAnak: anak.idAnak!,
                              anak: anak,
                              idUser: anak.idUser!,
                            ),
                          );
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
              DView.spaceHeight(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    elevation: 4,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          () => UpdateDataPasienPage(
                            idUser: widget.idUser,
                            nama: widget.nama,
                            alamat: widget.alamat,
                            role: widget.role,
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            'UPDATE AKUN',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  DView.spaceWidth(30),
                  Material(
                    elevation: 4,
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () => delete(widget.user),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            'DELETE AKUN',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              DView.spaceHeight(30),
              Material(
                elevation: 8,
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: () {
                    Get.to(() => AddDataAnakPage(idUser: widget.idUser));
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: AppColor.primary,
                        ),
                        Text(
                          'Tambah Data Anak Lainnya',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: AppColor.primary),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
