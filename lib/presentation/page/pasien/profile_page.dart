import 'package:d_view/d_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/session.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_anak.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/admin/change_password_page.dart';
import 'package:posyandu_apps/presentation/page/anak/detail_data_anak_page.dart';
import 'package:posyandu_apps/presentation/page/auth/login_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/akun_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/data_anak_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/jadwal_pemeriksaan_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/pasien/pilih_anak_riwayat_penimbangan_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final cUser = Get.put(CUser());
  final cAnak = Get.put(CAnak());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          AppBar(
            foregroundColor: Colors.black,
            title: Text('KMS Digital'),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 50),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.group,
                    color: Colors.black,
                    size: 40,
                  ),
                  title: Text(
                    'Data Orang Tua',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Get.to(
                      () => AkunPasienPage(
                        nama: cUser.data.nama!,
                        nik: cUser.data.nik!,
                        alamat: cUser.data.alamat!,
                        role: cUser.data.role!,
                        idUser: cUser.data.idUser!,
                      ),
                    );
                  },
                ),
                DView.spaceHeight(8),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 40,
                  ),
                  title: Text(
                    'Data Anak',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Get.to(() => DataAnakPasienPage());
                  },
                ),
                DView.spaceHeight(),
                ListTile(
                  leading: Icon(
                    Icons.date_range,
                    color: Colors.black,
                    size: 40,
                  ),
                  title: Text(
                    'Jadwal Pemeriksaan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Get.to(() => JadwalPemeriksaanPasienPage());
                  },
                ),
                DView.spaceHeight(),
                ListTile(
                  leading: Icon(
                    Icons.scale_rounded,
                    color: Colors.black,
                    size: 40,
                  ),
                  title: Text(
                    'Riwayat Hasil Pemeriksaan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Get.to(
                      () => PilihAnakRiwayatPenimbanganPage(),
                    );
                  },
                ),
                // DView.spaceHeight(),
                // ListTile(
                //   leading: Icon(
                //     Icons.lock,
                //     color: Colors.black,
                //     size: 40,
                //   ),
                //   title: Text(
                //     'Ubah Password Akun',
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   onTap: () {
                //     Get.to(
                //       () => ChangePasswordPage(
                //         idUser: widget.idUser,
                //         nama: widget.nama,
                //         alamat: widget.alamat,
                //         role: widget.role,
                //       ),
                //     );
                //   },
                // ),
                DView.spaceHeight(),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.red,
                    size: 40,
                  ),
                  title: Text(
                    'Keluar',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  onTap: () {
                    Session.clearUser();
                    Get.off(() => const LoginPage());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
