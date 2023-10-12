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

class UpdateDataPasienPage extends StatefulWidget {
  const UpdateDataPasienPage(
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
  State<UpdateDataPasienPage> createState() => _UpdateDataPasienPageState();
}

class _UpdateDataPasienPageState extends State<UpdateDataPasienPage> {
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

  updateUser() async {
    if (formKey.currentState!.validate()) {
      await SourceUser.update(widget.idUser, controllerNama.text,
          controllerAlamat.text, cUser.role);
      refresh();
    }
  }

  @override
  void initState() {
    cUser.init(cUser.setRole('Pasien'), widget.nama);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Update Akun Pasien'),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // DInput(
            //   controller: controllerNik,
            //   title: 'NIK',
            //   hint: widget.nik,
            //   isRequired: true,
            //   inputType: TextInputType.number,
            //   validator: (value) => value == '' ? "nik jangan kosong" : null,
            // ),
            DView.spaceHeight(),
            DInput(
              controller: controllerNama,
              title: 'Nama Lengkap',
              hint: widget.nama,
              isRequired: true,
              validator: (value) => value == '' ? "Nama jangan kosong" : null,
            ),
            DView.spaceHeight(),
            DInput(
              controller: controllerAlamat,
              title: 'Alamat',
              hint: widget.alamat,
              isRequired: true,
              validator: (value) => value == '' ? "Alamat jangan kosong" : null,
            ),
            DView.spaceHeight(),
            const Text('Role', style: TextStyle(fontWeight: FontWeight.bold)),
            DView.spaceHeight(8),
            Obx(() {
              return DropdownButtonFormField(
                value: cUser.role,
                items: ['Admin', 'Pasien'].map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (value) {
                  cUser.setRole(value);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              );
            }),
            DView.spaceHeight(50),
            Material(
              elevation: 8,
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () => updateUser(),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      'UPDATE',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: AppColor.primary),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
