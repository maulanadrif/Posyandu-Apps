import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/data/source/source_user.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';

class AddAdminPage extends StatelessWidget {
  const AddAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cUser = Get.put(CUser());
    final controllerNik = TextEditingController();
    final controllerNama = TextEditingController();
    final controllerAlamat = TextEditingController();
    final controllerPassword = TextEditingController();
    // final controllerRole = TextEditingController();
    final formKey = GlobalKey<FormState>();
    register() async {
      if (formKey.currentState!.validate()) {
        await SourceUser.register(controllerNik.text, controllerNama.text,
            controllerAlamat.text, controllerPassword.text, cUser.role);
      }
    }

    return Scaffold(
      appBar: AppBarModif.appBar('Tambah Akun Petugas'),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
          children: [
            DInput(
              controller: controllerNik,
              title: 'NIK',
              hint: 'nik',
              isRequired: true,
              inputType: TextInputType.number,
              validator: (value) => value == '' ? "nik jangan kosong" : null,
            ),
            DView.spaceHeight(),
            DInput(
              controller: controllerNama,
              title: 'Nama Lengkap',
              hint: 'nama',
              isRequired: true,
              validator: (value) => value == '' ? "Nama jangan kosong" : null,
            ),
            DView.spaceHeight(),
            DInput(
              controller: controllerAlamat,
              title: 'Alamat',
              hint: 'alamat',
              isRequired: true,
              validator: (value) => value == '' ? "Alamat jangan kosong" : null,
            ),
            DView.spaceHeight(),
            DInputPassword(
              controller: controllerPassword,
              title: 'Password',
              obsecureCharacter: '•',
              hint: 'password',
              isRequired: true,
              validator: (value) =>
                  value == '' ? "password jangan kosong" : null,
            ),
            DView.spaceHeight(),
            // DInput(
            //   controller: controllerRole,
            //   title: 'Role',
            //   hint: 'role',
            //   isRequired: true,
            //   validator: (value) => value == '' ? "Role jangan kosong" : null,
            // ),
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
                onTap: () => register(),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      'SUBMIT',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: AppColor.primary),
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
