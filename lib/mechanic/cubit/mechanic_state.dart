part of 'mechanic_cubit.dart';

class MechanicState extends Equatable {
  MechanicState({
    this.mechanicId = "",
  });

  final String mechanicId;

  MechanicState copyWith({
    String? mechanicId,
  }) {
    return MechanicState(
      mechanicId: mechanicId ?? this.mechanicId,
    );
  }

  @override
  List<Object> get props => [mechanicId];
}
