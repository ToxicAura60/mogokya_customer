part of 'app_bloc.dart';

class AppEvent {
  const AppEvent();
}

class AppLogoutRequested extends AppEvent {}

class _AppUserDataChanged extends AppEvent {
  const _AppUserDataChanged(this.user);
  final User user;
}

class _AppUserChanged extends AppEvent {
  const _AppUserChanged(this.user);
  final User user;
}
