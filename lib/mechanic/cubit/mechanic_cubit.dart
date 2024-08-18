import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

part 'mechanic_state.dart';

class MechanicCubit extends Cubit<MechanicState> {
  MechanicCubit({
    required mechanicId,
  })  : _mechanicId = mechanicId,
        super(MechanicState(
          mechanicId: mechanicId,
        ));

  final String _mechanicId;
}
