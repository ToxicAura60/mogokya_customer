import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(page: 0));

  void pageChanged(int page) {
    emit(HomeState(page: page));
  }
}
