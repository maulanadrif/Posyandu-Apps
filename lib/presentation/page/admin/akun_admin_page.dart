import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/admin/change_password_page.dart';

class AkunAdminPage extends StatefulWidget {
  const AkunAdminPage(
      {super.key,
      required this.nama,
      required this.nik,
      required this.alamat,
      required this.role,
      required this.idUser});
  final String nik;
  final String nama;
  final String alamat;
  final String role;
  final String idUser;

  @override
  State<AkunAdminPage> createState() => _AkunAdminPageState();
}

class _AkunAdminPageState extends State<AkunAdminPage> {
  final cUser = Get.put(CUser());

  @override
  void initState() {
    cUser.init(cUser.setRole('Pasien'), widget.nik);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Akun Saya'),
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
          DView.spaceHeight(30),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 16, 50, 0),
            child: Material(
              elevation: 4,
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () {
                  Get.to(
                    () => ChangePasswordPage(
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
                      'UBAH PASSWORD',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
