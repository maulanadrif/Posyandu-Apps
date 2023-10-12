import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/data/model/user.dart';
import 'package:posyandu_apps/data/source/source_history.dart';
import 'package:posyandu_apps/data/source/source_user.dart';
import 'package:posyandu_apps/presentation/controller/c_data_user.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/admin/detail_data_admin_page.dart';
import 'package:posyandu_apps/presentation/page/admin/add_admin_page.dart';
import 'package:posyandu_apps/presentation/page/admin/update_data_admin_page.dart';

class DataAdminPage extends StatefulWidget {
  const DataAdminPage({Key? key, required this.role}) : super(key: key);
  final String role;

  @override
  State<DataAdminPage> createState() => _DataAdminPageState();
}

class _DataAdminPageState extends State<DataAdminPage> {
  final cDataUser = Get.put(CDataUser());
  final cUser = Get.put(CUser());
  final controllerSearch = TextEditingController();

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
      appBar: AppBarModif.appBarAdd(
        'Data Akun Petugas',
        IconButton(
          onPressed: () {
            Get.to(() => AddAdminPage());
          },
          icon: Icon(
            Icons.add,
            color: AppColor.primary,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 40,
            margin: const EdgeInsets.all(16),
            child: TextField(
              controller: controllerSearch,
              onTap: () {},
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                    onPressed: () {
                      cDataUser.search(cUser.data.idUser, widget.role,
                          controllerSearch.text);
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    )),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                hintText: 'cari nama',
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
              ),
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          Expanded(
            child: GetBuilder<CDataUser>(builder: (_) {
              if (_.loading) return DView.loadingCircle();
              if (_.list.isEmpty) return DView.empty('Data Kosong');
              return RefreshIndicator(
                onRefresh: () async => refresh(),
                child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: _.list.length,
                    itemBuilder: (context, index) {
                      User user = _.list[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => DetailDataAdminPage(
                              nik: user.nik!,
                              nama: user.nama!,
                              alamat: user.alamat!,
                              role: user.role!,
                              idUser: user.idUser!,
                              user: user,
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                            16,
                            index == 0 ? 16 : 8,
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
                                    'Nama : ${user.nama}',
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
          ),
        ],
      ),
    );
  }
}
