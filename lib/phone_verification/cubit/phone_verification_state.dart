part of 'phone_verification_cubit.dart';

class PhoneVerificationState extends Equatable {
  PhoneVerificationState({
    this.smsCode = "",
    this.errorMessage,
    this.status = FormzSubmissionStatus.initial,
  });

  final String smsCode;
  final String? errorMessage;
  final FormzSubmissionStatus status;

  PhoneVerificationState copyWith({
    String? smsCode,
    String? errorMessage,
    FormzSubmissionStatus? status,
  }) {
    return PhoneVerificationState(
      smsCode: smsCode ?? this.smsCode,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        smsCode,
        errorMessage,
        status,
      ];
}
