import 'package:app1/settings/components/components.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
        title: "Matikan Semua",
        child: SettingsGroup(
          showBorder: true,
          titleColor: Color(0xFF000000),
          titleSize: 16,
          title: "Notifikasi",
          children: [
            SettingsItem(
              title: "Matikan Semua",
              trailing: Switch(
                onChanged: (value) {},
                value: false,
              ),
            ),
            const SettingsItem(
              title: "Pesan",
            ),
            const SettingsItem(
              title: "Dari Mogokya",
            ),
          ],
        ));
  }
}
