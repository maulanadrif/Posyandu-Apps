import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/data/model/user.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_anak.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_data_anak.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_update_data_anak%20.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';

class UpdateDataAnakPage extends StatefulWidget {
  const UpdateDataAnakPage({
    Key? key,
    required this.idAnak,
    required this.idUser,
    required this.namaLengkap,
    required this.namaPanggilan,
    required this.jenisKelamin,
    required this.tglLahir,
    required this.alamat,
  }) : super(key: key);

  final String idAnak;
  final String idUser;
  final String namaLengkap;
  final String namaPanggilan;
  final String jenisKelamin;
  final String tglLahir;
  final String alamat;

  @override
  State<UpdateDataAnakPage> createState() => _UpdateDataAnakPageState();
}

class _UpdateDataAnakPageState extends State<UpdateDataAnakPage> {
  final cUpdateDataAnak = Get.put(CUpdateDataAnak());
  final cDataAnak = Get.put(CDataAnak());
  final cUser = Get.put(CUser());
  final cAnak = Get.put(CAnak());
  final controllerNik = TextEditingController();
  final controllerFullname = TextEditingController();
  final controllerNickname = TextEditingController();
  final controllerAlamat = TextEditingController();

  updateDataAnak() async {
    await SourceAnak.update(
        widget.idAnak,
        widget.idUser,
        controllerFullname.text = widget.namaLengkap,
        controllerNickname.text,
        cUpdateDataAnak.gender,
        cUpdateDataAnak.birth,
        controllerAlamat.text);
  }

  @override
  void initState() {
    cUpdateDataAnak.init(widget.idUser, widget.namaLengkap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Update Data Anak'),
      body: ListView(
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
            controller: controllerFullname,
            title: 'Nama Lengkap',
            hint: widget.namaLengkap,
            isRequired: true,
            validator: (value) =>
                value == '' ? "Nama lengkap jangan kosong" : null,
          ),
          DView.spaceHeight(),
          DInput(
            controller: controllerNickname,
            title: 'Nama Panggilan',
            hint: widget.namaPanggilan,
            isRequired: true,
            validator: (value) =>
                value == '' ? "Nama panggilan jangan kosong" : null,
          ),
          DView.spaceHeight(),
          const Text(
            'Jenis Kelamin',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          DView.spaceHeight(8),
          Obx(() {
            return DropdownButtonFormField(
              value: cUpdateDataAnak.gender,
              items: ['Laki-Laki', 'Perempuan'].map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                cUpdateDataAnak.setGender(value);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
            );
          }),
          DView.spaceHeight(),
          const Text(
            'Tanggal Lahir',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          DView.spaceHeight(8),
          Row(
            children: [
              Obx(() {
                return Text(cUpdateDataAnak.birth);
              }),
              DView.spaceWidth(),
              ElevatedButton.icon(
                onPressed: () async {
                  DateTime? result = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023, 01, 01),
                      lastDate: DateTime(DateTime.now().year + 1));
                  if (result != null) {
                    cUpdateDataAnak
                        .setBirth(DateFormat('yyyy-MM-dd').format(result));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 4,
                ),
                icon: const Icon(
                  Icons.event,
                  color: AppColor.primary,
                ),
                label: const Text(
                  'Pilih',
                  style: TextStyle(
                    color: AppColor.primary,
                  ),
                ),
              ),
            ],
          ),
          DView.spaceHeight(),
          DInput(
            controller: controllerAlamat,
            title: 'Alamat',
            hint: widget.alamat,
            isRequired: true,
            validator: (value) => value == '' ? "Alamat jangan kosong" : null,
          ),
          DView.spaceHeight(50),
          Material(
            elevation: 8,
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () => updateDataAnak(),
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
    );
  }
}
