import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'interest_event.dart';
part 'interest_state.dart';

class InterestBloc extends Bloc<InterestEvent, List<String>> {
  InterestBloc() : super(<String>[]) {
    on<InterestFetched>((event, emit) async {
      // handle incoming `InterestFetched` event
      emit(state);
    });

    on<InterestTextFieldSubmited>((event, emit) async {
      // handle incoming `InterestTextFieldSubmited` event
      emit([...state]..add(event.interest));
    });

    on<InterestRemoved>((event, emit) async {
      // handle incoming `InterestRemoved` event
      state.removeWhere((element) => element == event.interest);
      emit(state);
    });
  }
}
