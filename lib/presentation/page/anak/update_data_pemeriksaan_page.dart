import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/presentation/controller/c_data_penimbangan.dart';

class UpdateDataPemeriksaanPage extends StatefulWidget {
  const UpdateDataPemeriksaanPage({super.key, required this.pemeriksaan});
  final Map pemeriksaan;

  @override
  State<UpdateDataPemeriksaanPage> createState() =>
      _UpdateDataPemeriksaanPageState();
}

class _UpdateDataPemeriksaanPageState extends State<UpdateDataPemeriksaanPage> {
  final controllerBB = TextEditingController();
  final controllerTB = TextEditingController();
  final controllerLK = TextEditingController();
  final controllerLL = TextEditingController();
  final cDataPenimbangan = Get.put(CDataPenimbangan());

  updateDataPemeriksaan() async {
    bool success = await SourceAnak.updateDataPenimbangan(
        widget.pemeriksaan['id_pemeriksaan'],
        widget.pemeriksaan['id_anak'],
        widget.pemeriksaan['tgl_pemeriksaan'],
        controllerBB.text,
        controllerTB.text,
        controllerLK.text,
        controllerLL.text);
    if (success) {
      cDataPenimbangan.getList();
    }
  }

  @override
  void initState() {
    controllerBB.text = widget.pemeriksaan['berat_badan'];
    controllerTB.text = widget.pemeriksaan['tinggi_badan'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Update Data Pemeriksaan'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DView.spaceHeight(8),
          DInput(
            controller: controllerBB,
            title: 'Berat Badan',
            hint: 'kg',
            isRequired: true,
            validator: (value) =>
                value == '' ? "Berat badan jangan kosong" : null,
          ),
          DView.spaceHeight(),
          DInput(
            controller: controllerTB,
            title: 'Tinggi Badan',
            hint: 'cm',
            isRequired: true,
            validator: (value) =>
                value == '' ? "Tinggi badan jangan kosong" : null,
          ),
          DView.spaceHeight(),
          DInput(
            controller: controllerLK,
            title: 'Lingkar Kepala',
            hint: 'cm',
            isRequired: true,
            validator: (value) =>
                value == '' ? "Lingkar kepala jangan kosong" : null,
          ),
          DView.spaceHeight(),
          DInput(
            controller: controllerLL,
            title: 'Lingkar Lengan',
            hint: 'cm',
            isRequired: true,
            validator: (value) =>
                value == '' ? "Lingkar lengan jangan kosong" : null,
          ),
          DView.spaceHeight(50),
          Material(
            color: AppColor.primary,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {
                updateDataPemeriksaan();
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    'UPDATE',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
