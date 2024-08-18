import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const AppState.initial()) {
    on<_AppUserDataChanged>(_onUserDataChanged);
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user.listen((user) =>
        _authenticationRepository.user
            .listen((user) => add(_AppUserChanged(user))));
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;
  StreamSubscription<User>? _userDataSubscription;

  void _onUserDataChanged(_AppUserDataChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(user: event.user));
  }

  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
    if (event.user.isNotEmpty) {
      _userDataSubscription?.cancel();
      _userDataSubscription =
          _authenticationRepository.userData(id: event.user.id).listen(
                (user) => add(
                  _AppUserDataChanged(user),
                ),
              );

      emit(AppState.authenticated(event.user));
    } else {
      emit(const AppState.unauthenticated());
    }
  }

  void _onLogoutRequested(
    AppLogoutRequested event,
    Emitter<AppState> emit,
  ) {
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _userDataSubscription?.cancel();
    return super.close();
  }
}
