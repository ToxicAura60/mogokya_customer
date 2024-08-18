import 'package:app1/app/app.dart';
import 'package:app1/edit_profile/pages/name/cubit/name_cubit.dart';
import 'package:app1/edit_profile/pages/name/view/name_view.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NamePage extends StatelessWidget {
  const NamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NameCubit(
        initialName: context.read<AppBloc>().state.user.name,
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: NameView(),
    );
  }
}
