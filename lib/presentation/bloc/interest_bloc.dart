import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'interest_event.dart';
part 'interest_state.dart';

class InterestBloc extends Bloc<InterestEvent, InterestState> {
  InterestBloc() : super(const InterestState.initial()) {

    on<InterestTextFieldSubmited>((event, emit) async {
      // handle incoming `InterestTextFieldSubmited` event
      // emit([...state]..add(event.interest));
      // emit(
      //   InterestState(
      //     interestsTemp: [...state.interestsTemp]..add(event.interest),
      //   ),
      // );

      emit(state.copyWith(
          status: InterestStatus.input,
          interestsTemp: [...state.interestsTemp, ...state.interests]..add(event.interest)));
    });

    on<InterestRemoved>((event, emit) async {
      // handle incoming `InterestRemoved` event
      // state.copyWith().removeWhere((element) => element == event.interest);
      // state.interests.removeWhere((element) => element == event.interest);
      // state.interestsTemp.removeWhere((element) => element == event.interest);
      // state.copyWith(interests: );
      // emit(state.copyWith(interests: ));
      emit(
        state.copyWith(
            interestsTemp: [...state.interestsTemp]
              ..removeWhere((element) => element == event.interest),
            interests: [...state.interests]..removeWhere((element) => element == event.interest)),
      );
    });

    on<InterestSaved>((event, emit) async {
      // handle incoming `InterestRemoved` event
      // state.removeWhere((element) => element == event.interest);
      var newList = <String>[];
      for (var data in state.interestsTemp) {
        newList.add(data);
      }
      //clear value on variable  interestTemporary after data move to variable interest
      state.interestsTemp.clear();
      emit(state.copyWith(interests: newList, status: InterestStatus.initial));
    });

    on<InterestRemovedAllTemp>((event, emit) async {
      state.interestsTemp.clear();
      emit(state.copyWith(
          interestsTemp: [...state.interests]..clear(), status: InterestStatus.initial));
    });
  }
}
