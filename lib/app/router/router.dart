import 'package:app1/edit_profile/edit_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app1/login/login.dart';
import 'package:app1/home/home.dart';
import 'package:app1/phone_verification/phone_verification.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  GoRouter get router {
    final LoginCubit loginCubit = LoginCubit(_authenticationRepository);
    return GoRouter(
      initialLocation: "/login",
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => BlocProvider.value(
            value: loginCubit,
            child: LoginPage(),
          ),
          routes: [
            GoRoute(
              path: 'verification',
              builder: (context, state) => BlocProvider.value(
                value: loginCubit,
                child: PhoneVerificationPage(),
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => HomePage(),
          routes: [
            GoRoute(
              path: 'edit_profile',
              builder: (context, state) => EditProfilePage(),
              routes: [
                GoRoute(
                  path: 'name',
                  builder: (context, state) => NamePage(),
                ),
                GoRoute(
                  path: 'email',
                  builder: (context, state) => EmailPage(),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
