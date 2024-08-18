import 'package:app1/edit_profile/widgets/custom_text_field.dart';
import 'package:flutter/widgets.dart';

class PasswordView extends StatelessWidget {
  const PasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          CustomTextField(
            labelText: "Kata Sandi",
          ),
          CustomTextField(
            labelText: "Konfirmasi Kata Sandi",
          )
        ],
      ),
    );
  }
}
