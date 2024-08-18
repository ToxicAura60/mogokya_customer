import 'package:app1/settings/components/components.dart';
import 'package:flutter/material.dart';

class AccountView extends StatelessWidget {
  AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
        title: "Akun",
        child: SettingsGroup(
          showBorder: true,
          titleSize: 16,
          titleColor: Color(0xFF000000),
          title: "Keamanan",
          children: [
            SettingsItem(
              title: "Kata Sandi",
              icon: Icons.lock_outline_rounded,
            )
          ],
        ));
  }
}
