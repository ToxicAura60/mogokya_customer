import 'package:app1/app/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.go("/home/settings");
            },
            icon: Icon(Icons.settings),
          ),
        ],
        centerTitle: false,
        title: Text(
          'Profile Saya',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              return CircleAvatar(
                radius: 60,
                backgroundImage: state.user.photoURL == null
                    ? null
                    : NetworkImage("${state.user.photoURL}"),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              return Text(
                "${state.user.name ?? "User"}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFF693A),
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            ),
            onPressed: () {
              context.go("/edit_profile");
            },
            child: Text(
              "Ubah Profile",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  trailing: Icon(Icons.chevron_right_rounded),
                  leading: Icon(Icons.history),
                  title: Text('Daftar Alamat'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    'Keluar',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    context.read<AppBloc>().add(AppLogoutRequested());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
