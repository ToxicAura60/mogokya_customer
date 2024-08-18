part of 'dashboard_cubit.dart';

class DashboardState {
  DashboardState({
    this.mechanics,
  });
  final List<Mechanic>? mechanics;

  DashboardState copyWith({
    List<Mechanic>? mechanics,
  }) {
    return DashboardState(
      mechanics: mechanics ?? this.mechanics,
    );
  }
}
