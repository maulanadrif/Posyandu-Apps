import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/config/app_format.dart';
import 'package:posyandu_apps/data/model/user.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/data/source/source_user.dart';
import 'package:posyandu_apps/presentation/controller/c_data_user.dart';
import 'package:posyandu_apps/presentation/controller/c_presensi.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';
import 'package:posyandu_apps/presentation/page/admin/detail_data_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/admin/list_pasien_page.dart';
import 'package:posyandu_apps/presentation/page/admin/pilih_anak_page.dart';
import 'package:posyandu_apps/presentation/page/admin/update_data_pasien_page.dart';

class LakukanPenimbanganPage extends StatefulWidget {
  const LakukanPenimbanganPage(
      {super.key, required this.kegiatan, required this.role});
  final Map kegiatan;
  final String role;

  @override
  State<LakukanPenimbanganPage> createState() => _LakukanPenimbanganPageState();
}

class _LakukanPenimbanganPageState extends State<LakukanPenimbanganPage> {
  final cPresensi = Get.put(CPresensi());
  final cDataUser = Get.put(CDataUser());
  final cUser = Get.put(CUser());
  final controllerSearch = TextEditingController();

  delete(String idPresensi) async {
    bool? yes = await DInfo.dialogConfirmation(
        context, 'Hapus Data Anak', 'Ingin menghapus data?',
        textNo: 'Batal', textYes: 'Ya');
    if (yes!) {
      bool success = await SourceUser.deletePresensi(idPresensi);
      if (success) {
        cPresensi.getList(widget.kegiatan['id_kegiatan']);
      }
    }
  }

  menuOption(String value, User user) async {
    if (value == 'pilih') {
      Get.to(
        () => PilihAnakPage(
          user: user,
          nik: user.nik!,
          nama: user.nama!,
          alamat: user.alamat!,
          role: user.role!,
          idUser: user.idUser!,
        ),
      );
    }
  }

  refresh() {
    cDataUser.getList(cUser.data.idUser, widget.role);
  }

  @override
  void initState() {
    cPresensi.getList(widget.kegiatan['id_kegiatan']);
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Pilih Ibu Balita'),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(start: 16, top: 16),
            child: Text(
              'Kegiatan :',
              style: Theme.of(context).textTheme.headline6!,
            ),
          ),
          cardKegiatan(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Pilih Ibu Balita :',
              style: Theme.of(context).textTheme.headline6!,
            ),
          ),
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
          GetBuilder<CDataUser>(builder: (_) {
            if (_.loading) return DView.loadingCircle();
            if (_.list.isEmpty) return DView.empty('Data Kosong');
            return RefreshIndicator(
              onRefresh: () async => refresh(),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _.list.length,
                  itemBuilder: (context, index) {
                    User user = _.list[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => PilihAnakPage(
                            user: user,
                            nik: user.nik!,
                            nama: user.nama!,
                            alamat: user.alamat!,
                            role: user.role!,
                            idUser: user.idUser!,
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
                                  'Nama Ibu : ${user.nama}',
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
                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.fromLTRB(
                        16,
                        index == 0 ? 16 : 8,
                        16,
                        index == _.list.length - 1 ? 16 : 8,
                      ),
                      child: Row(
                        children: [
                          DView.spaceHeight(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              user.nama!,
                              style: const TextStyle(
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            user.nik!,
                            style: const TextStyle(
                                color: AppColor.bg,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            textAlign: TextAlign.end,
                          )),
                          PopupMenuButton<String>(
                              itemBuilder: (context) => [
                                    const PopupMenuItem(
                                        value: 'pilih',
                                        child: Text('Pilih Anak')),
                                  ],
                              onSelected: (value) => menuOption(value, user))
                        ],
                      ),
                    );
                  }),
            );
          }),
        ],
      ),
    );
  }

  Widget cardKegiatan() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 4,
        color: AppColor.primary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
              child: Text(
                widget.kegiatan['nama_kegiatan'],
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold, color: AppColor.secondary),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 4),
              child: Text(
                AppFormat.date(widget.kegiatan['tgl_pelaksanaan']),
                style: TextStyle(
                  color: AppColor.bg,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 30),
              child: Text(
                widget.kegiatan['tempat_pelaksanaan'],
                style: TextStyle(
                  color: AppColor.bg,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
