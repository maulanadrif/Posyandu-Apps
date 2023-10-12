import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posyandu_apps/config/session.dart';
import 'package:posyandu_apps/presentation/page/auth/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            const Text('Home Page'),
            IconButton(
              onPressed: () {
                Session.clearUser();
                Get.off(() => const LoginPage());
              },
              icon: const Icon(Icons.logout)
            ),
          ],
        )
      ),
    );
  }
}