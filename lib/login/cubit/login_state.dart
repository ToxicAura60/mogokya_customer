part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.countryCode = "ID",
    this.phoneCode = "62",
    this.phoneNumber = "",
    this.verificationId,
    this.errorMessage,
    this.resendToken,
    this.status = FormzSubmissionStatus.initial,
  });

  final String countryCode;
  final String phoneCode;
  final String phoneNumber;
  final String? verificationId;
  final String? errorMessage;
  final int? resendToken;
  final FormzSubmissionStatus status;

  LoginState copyWith({
    String? countryCode,
    String? phoneCode,
    String? phoneNumber,
    String? verificationId,
    String? errorMessage,
    int? resendToken,
    FormzSubmissionStatus? status,
  }) {
    return LoginState(
      countryCode: countryCode ?? this.countryCode,
      phoneCode: phoneCode ?? this.phoneCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      verificationId: verificationId ?? this.verificationId,
      errorMessage: errorMessage ?? this.errorMessage,
      resendToken: resendToken ?? this.resendToken,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        countryCode,
        phoneCode,
        phoneNumber,
        verificationId,
        errorMessage,
        resendToken,
        status,
      ];
}
