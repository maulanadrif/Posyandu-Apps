import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/data/model/user.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/data/source/source_user.dart';
import 'package:posyandu_apps/presentation/controller/c_data_user.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/admin/update_data_admin_page.dart';

class DetailAdminPresensiPage extends StatefulWidget {
  const DetailAdminPresensiPage(
      {Key? key,
      required this.nik,
      required this.nama,
      required this.alamat,
      required this.role,
      required this.idUser,
      required this.user})
      : super(key: key);
  final String nik;
  final String nama;
  final String alamat;
  final String role;
  final String idUser;
  final User user;

  @override
  State<DetailAdminPresensiPage> createState() =>
      _DetailAdminPresensiPageState();
}

class _DetailAdminPresensiPageState extends State<DetailAdminPresensiPage> {
  final cUser = Get.put(CUser());
  final cDataUser = Get.put(CDataUser());

  refresh() {
    cDataUser.getList(cUser.data.idUser, widget.role);
  }

  menuOption(String value, User user) async {
    if (value == 'detail') {
      Get.to(() => DetailAdminPresensiPage(
            nik: user.nik!,
            nama: user.nama!,
            alamat: user.alamat!,
            role: user.role!,
            idUser: user.idUser!,
            user: user,
          ))?.then((value) {
        if (value ?? false) {
          refresh();
        }
      });
    } else if (value == 'update') {
      Get.to(() => UpdateDataAdminPage(
            idUser: user.idUser!,
            nama: user.nama!,
            alamat: user.alamat!,
            role: user.role!,
          ))?.then((value) {
        if (value ?? false) {
          refresh();
        }
      });
    } else if (value == 'delete') {
      bool? yes = await DInfo.dialogConfirmation(
          context, 'Hapus Data Admin', 'Ingin menghapus data?',
          textNo: 'Batal', textYes: 'Ya');
      if (yes!) {
        bool success = await SourceUser.delete(user.nik!);
        if (success) {
          refresh();
        }
      }
    }
  }

  delete(User user) async {
    bool? yes = await DInfo.dialogConfirmation(
        context, 'Hapus Data Admin', 'Ingin menghapus data ${widget.nama}?',
        textNo: 'Batal', textYes: 'Ya');
    if (yes!) {
      bool success = await SourceUser.delete(user.nik!);
      if (success) {
        refresh();
      }
    }
  }

  // menuOption(String value, User user) async {
  //   if (value == 'detail') {
  //   } else if (value == 'update') {
  //   } else if (value == 'delete') {
  //     bool? yes = await DInfo.dialogConfirmation(
  //         context, 'Hapus Data Admin', 'Ingin menghapus data?',
  //         textNo: 'Batal', textYes: 'Ya');
  //     if (yes!) {
  //       bool success = await SourceUser.delete(user.nik!);
  //       if (success) {
  //         refresh();
  //       }
  //     }
  //   }
  // }

  @override
  void initState() {
    cUser.init(cUser.setRole('Admin'), widget.nama);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Detail Data Petugas'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 30, 16, 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Nama : ${widget.nama}',
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
          DView.spaceHeight(50),
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
                      () => UpdateDataAdminPage(
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
          )
        ],
      ),
    );
  }
}
