import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc()
      : super(ProfileInitial(
          isEditing: false,
          isPayment: false,
        )) {
    on<SetEdit>((event, emit) {
      emit(ProfileEditing());
    });

    on<SetPayment>((event, emit) {
      emit(ProfilePayment());
    });

    on<SetHome>((event, emit) {
      emit(ProfileHome());
    });
  }

  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is SetEdit) {
      yield ProfileEditing();
    }
    if (event is SetPayment) {
      yield ProfilePayment();
    }
    if (event is SetHome) {
      yield ProfileHome();
    }
  }
}
