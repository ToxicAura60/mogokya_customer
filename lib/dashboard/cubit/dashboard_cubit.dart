import 'package:app_repository/app_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashbboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({required AppRepository appRepository})
      : _appRepository = appRepository,
        super(DashboardState()) {
    fetchData();
  }

  final AppRepository _appRepository;

  void fetchData() async {
    List<Mechanic> mechanics = await _appRepository.fetchNearbyMechanic();
    emit(state.copyWith(mechanics: mechanics));
  }
}
