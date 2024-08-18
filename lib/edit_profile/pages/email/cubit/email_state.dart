part of 'email_cubit.dart';

class EmailState {
  EmailState({
    this.email,
    this.password,
    this.status = FormzSubmissionStatus.initial,
  });

  EmailState copyWith({
    String? email,
    String? password,
    FormzSubmissionStatus? status,
  }) {
    return EmailState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  final String? email;
  final String? password;
  FormzSubmissionStatus status;
}
