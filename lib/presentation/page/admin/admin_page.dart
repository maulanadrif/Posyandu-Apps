import 'dart:ui';

import 'package:d_chart/d_chart.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_asset.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/config/constant/app_constant.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/config/session.dart';
import 'package:posyandu_apps/data/model/user.dart';
import 'package:posyandu_apps/presentation/controller/c_admin.dart';
import 'package:posyandu_apps/presentation/controller/c_all_kegiatan.dart';
import 'package:posyandu_apps/presentation/controller/c_home.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/admin/add_jadwal_pemeriksaan_page.dart';
import 'package:posyandu_apps/presentation/page/admin/akun_admin_page.dart';
import 'package:posyandu_apps/presentation/page/admin/data_admin_page.dart';
import 'package:posyandu_apps/presentation/page/admin/data_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/admin/lihat_presensi_page%20.dart';
import 'package:posyandu_apps/presentation/page/admin/list_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/admin/add_presensi_page.dart';
import 'package:posyandu_apps/presentation/page/admin/add_admin_page.dart';
import 'package:posyandu_apps/presentation/page/anak/data_anak_page.dart';
import 'package:posyandu_apps/presentation/page/auth/login_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final cUser = Get.put(CUser());
  final cHome = Get.put(CHome());
  final cAdmin = Get.put(CAdmin());
  User? user;

  akunSaya(User user) {
    Get.to(AkunAdminPage(
      nik: user.nik!,
      nama: user.nama!,
      alamat: user.alamat!,
      role: user.role!,
      idUser: user.idUser!,
    ));
  }

  @override
  void initState() {
    cHome.getAnalysis(cUser.data.idUser!);
    cAdmin.getKegiatan();
    cAdmin.getList(cUser.data.idUser!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                margin: const EdgeInsets.only(bottom: 0),
                padding: const EdgeInsets.fromLTRB(20, 16, 16, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Image.asset(AppAsset.profile),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() {
                                return Text(
                                  cUser.data.nama ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                );
                              }),
                              Obx(() {
                                return Text(
                                  cUser.data.role ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(() => AkunAdminPage(
                        nik: cUser.data.nik!,
                        nama: cUser.data.nama!,
                        alamat: cUser.data.alamat!,
                        role: cUser.data.role!,
                        idUser: cUser.data.idUser!,
                      ));
                },
                leading: const Icon(Icons.account_circle_rounded),
                horizontalTitleGap: 0,
                title: const Text('Akun Saya'),
                trailing: const Icon(Icons.navigate_next),
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                horizontalTitleGap: 0,
                title: Text(
                  'Keluar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                onTap: () {
                  Session.clearUser();
                  Get.off(() => const LoginPage());
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Halo, ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Obx(() {
                          return Text(
                            '${cUser.data.nama ?? ''} !',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                  Builder(builder: (ctx) {
                    return InkWell(
                      onTap: () {
                        Scaffold.of(ctx).openEndDrawer();
                      },
                      child: Image.asset(
                        AppAsset.logo,
                        scale: 7,
                      ),
                    );
                  }),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  cAdmin.getList(cUser.data.idUser);
                },
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
                  children: [
                    Text(
                      'Jadwal Kegiatan Hari Ini',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    DView.spaceHeight(),
                    cardToday(context),
                    DView.spaceHeight(30),
                    Center(
                      child: Container(
                        height: 5,
                        width: 80,
                        decoration: BoxDecoration(
                          color: AppColor.bg,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    DView.spaceHeight(30),
                    // Text(
                    //   'Menu',
                    //   style: Theme.of(context).textTheme.headline6!.copyWith(
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    // ),
                    GridView.builder(
                      itemCount: AppConstant.menu.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) {
                        Map item = AppConstant.menu[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => item['page'] as Widget);
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: item['icontype'] == 'image'
                                    ? Image.asset(item['icon'])
                                    : Icon(
                                        item['icon'],
                                        color: AppColor.primary,
                                        size: 32,
                                      ),
                              ),
                              DView.spaceHeight(),
                              Text(
                                item['title'],
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    DView.spaceHeight(30),
                    Text(
                      'Aktivitas Terakhir',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    DView.spaceHeight(),
                    aktivitasTerakhir(),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget aktivitasTerakhir() {
    return Obx(
      () {
        if (cAdmin.loading) return DView.loadingCircle();
        List list = cAdmin.list;
        if (list.isEmpty) return DView.empty();
        return ListView.builder(
          padding: EdgeInsets.all(0),
          itemCount: list.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            Map item = list[index];
            return Container(
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['tempat_pelaksanaan'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          AppFormat.date(item['tgl_pelaksanaan']),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        DView.spaceHeight(20),
                        Text(
                          item['nama_kegiatan'],
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  item['Hadir']
                      ? Material(
                          borderRadius: BorderRadius.circular(16),
                          elevation: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                                DView.spaceWidth(8),
                                Text(
                                  'Hadir',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(16),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                  ),
                                  DView.spaceWidth(8),
                                  Text(
                                    'Belum',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget cardToday(BuildContext context) {
    return Obx(() {
      Map kegiatan = cAdmin.kegiatan;
      if (kegiatan.isEmpty) {
        return Material(
          borderRadius: BorderRadius.circular(16),
          elevation: 4,
          color: AppColor.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 50, 16, 50),
                child: Text(
                  'Tidak ada kegiatan hari ini',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold, color: AppColor.secondary),
                ),
              ),
            ],
          ),
        );
      }
      return Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 4,
        color: AppColor.primary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
              child: Text(
                kegiatan['nama_kegiatan'],
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.secondary,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 4),
              child: Text(
                AppFormat.date(kegiatan['tgl_pelaksanaan']),
                style: TextStyle(
                  color: AppColor.bg,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 30),
              child: Text(
                kegiatan['tempat_pelaksanaan'],
                style: TextStyle(
                  color: AppColor.bg,
                  fontSize: 16,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => LihatPresensiPage(kegiatan: kegiatan));
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'Lihat Presensi',
                      style: TextStyle(color: AppColor.primary),
                    ),
                    Icon(
                      Icons.navigate_next,
                      color: AppColor.primary,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
