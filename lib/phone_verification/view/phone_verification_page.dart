import 'package:app1/login/cubit/login_cubit.dart';
import 'package:app1/phone_verification/bloc/timer_bloc.dart';
import 'package:app1/phone_verification/cubit/phone_verification_cubit.dart';
import 'package:app1/phone_verification/view/phone_verification_view.dart';
import 'package:app1/phone_verification/ticker.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneVerificationPage extends StatelessWidget {
  const PhoneVerificationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PhoneVerificationCubit(
            authenticationRepository: context.read<AuthenticationRepository>(),
            verificationId: context.read<LoginCubit>().state.verificationId!,
          ),
        ),
        BlocProvider(
          create: (context) => TimerBloc(
            ticker: Ticker(),
          ),
        ),
      ],
      child: PhoneVerificationView(),
    );
  }
}
