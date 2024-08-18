import 'package:app1/settings/components/components.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: "Pengaturan",
      child: Column(
        children: [
          SettingsGroup(
            title: "Akun",
            children: [
              SettingsItem(
                title: "Akun",
                icon: Icons.account_circle_outlined,
                onTap: () {
                  context.go("/home/settings/account");
                },
              ),
            ],
          ),
          SettingsGroup(
            title: "Pengaturan Umum",
            children: [
              SettingsItem(
                title: "Notifikasi",
                icon: Icons.account_circle_outlined,
                onTap: () {
                  context.go("/home/settings/notification");
                },
              ),
            ],
          ),
          SettingsGroup(
            title: "Login",
            children: [
              SettingsItem(
                title: "Keluar",
                titleColor: Color(0xFFF24E1E),
                showTrailing: false,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
