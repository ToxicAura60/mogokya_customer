part of 'name_cubit.dart';

class NameState extends Equatable {
  const NameState({
    this.name = '',
    this.status = FormzSubmissionStatus.initial,
  });

  final String? name;
  final FormzSubmissionStatus status;

  NameState copyWith({
    String? name,
    FormzSubmissionStatus? status,
  }) {
    return NameState(
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        name,
        status,
      ];
}
