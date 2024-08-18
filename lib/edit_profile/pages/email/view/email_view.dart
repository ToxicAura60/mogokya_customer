import 'package:app1/edit_profile/pages/email/cubit/email_cubit.dart';
import 'package:app1/edit_profile/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailView extends StatelessWidget {
  const EmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email"),
        actions: [
          GestureDetector(
              child: Text("Lanjut"),
              onTap: () {
                context.read<EmailCubit>().sendEmailVerification();
              })
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextField(
                initialValue: context.read<EmailCubit>().state.email,
                labelText: "Email",
                onChanged: (value) =>
                    context.read<EmailCubit>().changeEmail(value)),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              labelText: "Kata Sandi",
              onChanged: (value) =>
                  context.read<EmailCubit>().changePassword(value),
            ),
          ],
        ),
      ),
    );
  }
}
