import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  void countryChanged({
    required String phoneCode,
    required String countryCode,
  }) {
    emit(state.copyWith(
      phoneCode: phoneCode,
      countryCode: countryCode,
    ));
  }

  void phoneNumberChanged(String phoneNumber) {
    emit(state.copyWith(
      phoneNumber: phoneNumber,
      status: FormzSubmissionStatus.initial,
    ));
  }

  void verifyPhoneNumber({
    void Function()? onCodeSent,
  }) {
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));

    _authenticationRepository.verifyPhoneNumber(
      phoneNumber: "+${state.phoneCode} ${state.phoneNumber}",
      codeSent: (
        verificationId,
        resendToken,
      ) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.initial,
          verificationId: verificationId,
          resendToken: resendToken,
        ));
        if (onCodeSent != null) {
          onCodeSent();
        }
      },
      verificationFailed: (message) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: message,
        ));
      },
    );
  }
}
