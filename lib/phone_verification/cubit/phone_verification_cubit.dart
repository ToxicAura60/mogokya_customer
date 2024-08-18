import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
part 'phone_verification_state.dart';

class PhoneVerificationCubit extends Cubit<PhoneVerificationState> {
  PhoneVerificationCubit({
    required AuthenticationRepository authenticationRepository,
    required String verificationId,
  })  : _authenticationRepository = authenticationRepository,
        _verificationId = verificationId,
        super(PhoneVerificationState());

  final String _verificationId;
  final AuthenticationRepository _authenticationRepository;

  void pinChanged(String pin) {
    emit(state.copyWith(
      smsCode: pin,
      status: FormzSubmissionStatus.initial,
    ));
  }

  void verifyPhoneNumber() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.LogInWithPhoneNumber(
        verificationId: _verificationId,
        smsCode: state.smsCode,
      );
    } on LogInWithPhoneNumberFailure catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
      ));
    }
  }
}
