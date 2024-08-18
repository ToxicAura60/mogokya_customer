import 'package:app1/app/bloc/app_bloc.dart';
import 'package:app1/edit_profile/pages/name/cubit/name_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NameView extends StatelessWidget {
  const NameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              context.read<NameCubit>().updateName(
                  id: context.read<AppBloc>().state.user.id,
                  onSuccess: () {
                    context.go("/edit_profile");
                  });
            },
            child: Text(
              "Sudah",
            ),
          )
        ],
        title: Text(
          "Nama",
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Nama",
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF000000),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 2,
                  ),
                ),
              ),
              initialValue: context.read<NameCubit>().state.name,
              onChanged: (value) {
                context.read<NameCubit>().nameChanged(
                      name: value,
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
