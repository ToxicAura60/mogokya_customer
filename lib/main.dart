import 'package:app1/app/app.dart';
import 'package:app_repository/app_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    App(
      authenticationRepository: AuthenticationRepository(),
      appRepository: AppRepository(),
      appRouter: AppRouter(authenticationRepository: AuthenticationRepository())
          .router,
    ),
  );
}

class App extends StatelessWidget {
  const App({
    required authenticationRepository,
    required appRepository,
    required appRouter,
    super.key,
  })  : _authenticationRepository = authenticationRepository,
        _appRepository = appRepository,
        _appRouter = appRouter;

  final AppRepository _appRepository;
  final AuthenticationRepository _authenticationRepository;
  final GoRouter _appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _authenticationRepository,
        ),
        RepositoryProvider.value(
          value: _appRepository,
        ),
      ],
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: AppView(
          router: _appRouter,
        ),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    required GoRouter router,
    super.key,
  }) : _router = router;

  final GoRouter _router;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case AppStatus.unauthenticated:
            _router.go("/login");
          default:
            _router.go("/");
        }
      },
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Montserrat",
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF5999FF)),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
          appBarTheme: const AppBarTheme(
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}
