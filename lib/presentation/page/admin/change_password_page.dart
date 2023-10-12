import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/data/source/source_user.dart';
import 'package:posyandu_apps/presentation/controller/c_data_user.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage(
      {Key? key,
      required this.idUser,
      required this.nama,
      required this.alamat,
      required this.role})
      : super(key: key);
  final String idUser;
  final String nama;
  final String alamat;
  final String role;

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final cUser = Get.put(CUser());
  final cDataUser = Get.put(CDataUser());
  final controllerNik = TextEditingController();
  final controllerNama = TextEditingController();
  final controllerAlamat = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  refresh() {
    cDataUser.getList(cUser.data.idUser, widget.role);
  }

  changePassword() async {
    if (formKey.currentState!.validate()) {
      await SourceUser.changePassword(widget.idUser, controllerPassword.text);
      refresh();
    }
  }

  @override
  void initState() {
    // cUser.init(cUser.setRole('Admin'), widget.nama);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Ubah Password Akun'),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DView.spaceHeight(),
            DInputPassword(
              controller: controllerPassword,
              title: 'Password Baru',
              isRequired: true,
            ),
            DView.spaceHeight(50),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Material(
                elevation: 8,
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: () => changePassword(),
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        'SIMPAN',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
