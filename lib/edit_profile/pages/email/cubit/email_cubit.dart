import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'email_state.dart';

class EmailCubit extends Cubit<EmailState> {
  EmailCubit({
    String? email,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(EmailState(email: email));

  final AuthenticationRepository _authenticationRepository;

  void changeEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void changePassword(String password) {
    emit(state.copyWith(password: password));
  }

  Future<void> sendEmailVerification() async {
    try {
      if (_authenticationRepository.currentUser.email != null) {
        // unlink
      }
      await _authenticationRepository.linkEmailAndPassword(
        email: state.email!,
        password: state.password!,
      );

      await _authenticationRepository.sendEmailVerification();
    } catch (_) {}
  }
}
