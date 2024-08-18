import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'name_state.dart';

class NameCubit extends Cubit<NameState> {
  NameCubit({
    required AuthenticationRepository authenticationRepository,
    String? initialName,
  })  : _authenticationRepository = authenticationRepository,
        super(
          NameState(name: initialName),
        );

  final AuthenticationRepository _authenticationRepository;

  void nameChanged({required String name}) {
    emit(state.copyWith(
      status: FormzSubmissionStatus.initial,
      name: name,
    ));
  }

  void updateName({
    required String id,
    void Function()? onSuccess,
  }) {
    _authenticationRepository.updateProfile(
      id: id,
      data: {'name': state.name},
    );
    if (onSuccess != null) {
      onSuccess();
    }
  }
}
