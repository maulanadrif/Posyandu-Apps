import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:posyandu_apps/config/app_bar.dart';
import 'package:posyandu_apps/config/app_color.dart';
import 'package:posyandu_apps/data/source/source_anak.dart';
import 'package:posyandu_apps/presentation/controller/anak/c_add_data_anak.dart';
import 'package:posyandu_apps/presentation/controller/c_user.dart';

class AddDataAnakPage extends StatefulWidget {
  const AddDataAnakPage({Key? key, required this.idUser}) : super(key: key);
  final String idUser;

  @override
  State<AddDataAnakPage> createState() => _AddDataAnakPageState();
}

class _AddDataAnakPageState extends State<AddDataAnakPage> {
  final cAddDataAnak = Get.put(CAddDataAnak());
  final cUser = Get.put(CUser());
  final controllerNik = TextEditingController();
  final controllerFullname = TextEditingController();
  final controllerNickname = TextEditingController();
  final controllerAlamat = TextEditingController();

  addDataAnak() async {
    await SourceAnak.add(
        widget.idUser,
        controllerNik.text,
        controllerFullname.text,
        controllerNickname.text,
        cAddDataAnak.gender,
        cAddDataAnak.birth,
        controllerAlamat.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModif.appBar('Tambah Data Anak'),
      body: ListView(
        padding: const EdgeInsets.all(16),
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
            controller: controllerFullname,
            title: 'Nama Lengkap',
            hint: 'nama lengkap',
            isRequired: true,
            validator: (value) =>
                value == '' ? "Nama lengkap jangan kosong" : null,
          ),
          DView.spaceHeight(),
          DInput(
            controller: controllerNickname,
            title: 'Nama Panggilan',
            hint: 'nama panggilan',
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
              value: cAddDataAnak.gender,
              items: ['Laki-Laki', 'Perempuan'].map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                cAddDataAnak.setGender(value);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
            );
          }),
          DView.spaceHeight(),
          Row(
            children: [
              const Text(
                'Tanggal Lahir',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DView.spaceWidth(2),
              const Text(
                '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          DView.spaceHeight(8),
          Row(
            children: [
              Obx(() {
                return Text(cAddDataAnak.birth);
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
                    cAddDataAnak
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
            hint: 'alamat',
            isRequired: true,
            validator: (value) => value == '' ? "Alamat jangan kosong" : null,
          ),
          DView.spaceHeight(50),
          Material(
            elevation: 8,
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () => addDataAnak(),
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
          ),
        ],
      ),
    );
  }
}
