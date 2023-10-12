import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:posyandu_apps/config/app_color.dart';

class DetailDataImunisasiPage extends StatefulWidget {
  const DetailDataImunisasiPage({super.key});

  @override
  State<DetailDataImunisasiPage> createState() => _DetailDataImunisasiPageState();
}

class _DetailDataImunisasiPageState extends State<DetailDataImunisasiPage> {

  menuOption(String value, Map item) async {
    if (value == 'detail') {

    } else if (value == 'update') {
      
    } else if (value == 'delete') {
      // bool? yes = await DInfo.dialogConfirmation(
      //   context,
      //   'Hapus Data Pasien',
      //   'Ingin menghapus data?',
      //   textNo: 'Batal',
      //   textYes: 'Ya'
      // );
      // if(yes!) {
      //   bool success = await SourceUser.delete(user.nik!);
      //   if(success) {
      //     refresh();
      //   }
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Detail Data Imunisasi'),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          // Map item = list[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.fromLTRB(16, index == 0 ? 16 : 8, 16,
                index == 19 ? 16 : 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Cilla',
                    style: const TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                PopupMenuButton<String>(
                  itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'detail', child: Text('Detail')
                        ),
                        const PopupMenuItem(
                          value: 'update', child: Text('Update')
                        ),
                      ],
                  onSelected: (value) {}
                )
              ],
            ),
          );
        }),
    );
  }
}