import 'package:app1/app/app.dart';
import 'package:app1/edit_profile/edit_profile.dart';
import 'package:app1/edit_profile/pages/email/view/email_view.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailPage extends StatelessWidget {
  const EmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmailCubit(
        email: context.read<AppBloc>().state.user.email,
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: const EmailView(),
    );
  }
}
