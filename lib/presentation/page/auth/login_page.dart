import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_asset.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/config/session.dart';
import 'package:posyandu_apps/data/model/user.dart';
import 'package:posyandu_apps/data/source/source_user.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/admin/admin_page.dart';
import 'package:posyandu_apps/presentation/page/admin/dashboard.dart';
import 'package:posyandu_apps/presentation/page/home_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/pasien_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controllerNik = TextEditingController();
  final _controllerPassword = TextEditingController();
  final cUser = Get.put(CUser());
  final formKey = GlobalKey<FormState>();

  login() async {
    if (formKey.currentState!.validate()) {
      bool success = await SourceUser.login(
        _controllerNik.text,
        _controllerPassword.text,
      );
      if (success) {
        DInfo.dialogSuccess('Berhasil login');
        DInfo.closeDialog(actionAfterClose: () {
          Get.off(
            cUser.data.role == 'Pasien' ? const Dashboard() : const AdminPage(),
          );
        });
      } else {
        DInfo.dialogError('Gagal login');
        DInfo.closeDialog();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.bg,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DView.nothing(),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            Image.asset(
                              AppAsset.logo,
                              scale: 2,
                            ),
                            DView.spaceHeight(40),
                            TextFormField(
                              key: const Key('nikFormField'),
                              controller: _controllerNik,
                              validator: (value) =>
                                  value == '' ? 'NIK jangan kosong' : null,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  fillColor: AppColor.primary.withOpacity(0.5),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'nik',
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 16,
                                  )),
                            ),
                            DView.spaceHeight(),
                            TextFormField(
                              key: Key('passwordFormFiled'),
                              controller: _controllerPassword,
                              validator: (value) =>
                                  value == '' ? 'Password jangan kosong' : null,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: const TextStyle(color: Colors.white),
                              obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: AppColor.primary.withOpacity(0.5),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'password',
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 16,
                                  )),
                            ),
                            DView.spaceHeight(70),
                            Material(
                              elevation: 4,
                              color: AppColor.bgScafold,
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                key: const Key('btnLoginKey'),
                                onTap: () => login(),
                                borderRadius: BorderRadius.circular(30),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 60,
                                    vertical: 16,
                                  ),
                                  child: Text(
                                    'Masuk',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // children: [
                        //   const Text(
                        //     'Belum punya akun? ',
                        //     style: TextStyle(
                        //       fontSize: 16,
                        //     ),
                        //     ),
                        //   GestureDetector(
                        //     onTap: () {
                        //       Get.to(() => const RegisterPage());
                        //     },
                        //     child: const Text(
                        //       'Register',
                        //       style: TextStyle(
                        //         color: AppColor.primary,
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 16
                        //       ),
                        //     ),
                        //   )
                        // ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
