part of 'profile_cubit.dart';

enum Status { initial, loading, success }

class ProfileState {
  ProfileState({
    this.name,
    this.status = Status.initial,
  });

  String? name;
  Status status;
}
