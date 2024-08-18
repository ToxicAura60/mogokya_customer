part of 'app_bloc.dart';

enum AppStatus {
  initial,
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState({
    required this.status,
    this.user = User.empty,
  });

  AppState copyWith({
    AppStatus? status,
    User? user,
  }) {
    return AppState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  const AppState.initial() : this(status: AppStatus.initial);

  const AppState.unauthenticated() : this(status: AppStatus.unauthenticated);

  const AppState.authenticated(User user)
      : this(status: AppStatus.authenticated, user: user);

  final AppStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
