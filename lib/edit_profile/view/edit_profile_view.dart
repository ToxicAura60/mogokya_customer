import 'package:app1/app/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit profile"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFF0F0F0),
                ),
                top: BorderSide(
                  color: Color(0xFFF0F0F0),
                ),
              ),
            ),
            padding: EdgeInsets.all(20),
            child: CircleAvatar(
              backgroundImage:
                  context.read<AppBloc>().state.user.photoURL == null
                      ? null
                      : NetworkImage(
                          "${context.read<AppBloc>().state.user.photoURL}",
                        ),
              radius: 50,
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFF0F0F0),
                    ),
                  ),
                ),
                child: ListTile(
                  onTap: () {
                    context.go('/edit_profile/name');
                  },
                  leading: Text(
                    "Nama",
                    style: TextStyle(fontSize: 16),
                  ),
                  minLeadingWidth: 100,
                  title: BlocBuilder<AppBloc, AppState>(
                    builder: (context, state) {
                      return Text(
                        style: state.user.name == null
                            ? TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF999999),
                              )
                            : null,
                        state.user.name ?? "Tambahkan Nama",
                      );
                    },
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFF0F0F0),
                    ),
                  ),
                ),
                child: ListTile(
                  onTap: () {
                    context.go('/edit_profile/email');
                  },
                  leading: Text(
                    "Email",
                    style: TextStyle(fontSize: 16),
                  ),
                  minLeadingWidth: 100,
                  title: Text(
                    style: context.read<AppBloc>().state.user.email == null
                        ? TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF999999),
                          )
                        : null,
                    context.read<AppBloc>().state.user.email ??
                        "Tambahkan Email",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
