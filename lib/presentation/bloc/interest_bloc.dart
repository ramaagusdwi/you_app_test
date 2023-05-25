import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'interest_event.dart';
part 'interest_state.dart';

class InterestBloc extends Bloc<InterestEvent, List<String>> {
  InterestBloc() : super(<String>[]) {
    on<InterestTextFieldSubmited>((event, emit) async {
      // handle incoming `InterestInputed` event
      state.add(event.interest);
      // List<String> list = state.add(event.interest);
      emit(state);
    });

    on<InterestRemoved>((event, emit) async {
      // handle incoming `InterestRemoved` event
      state.removeWhere((element) => element == event.interest);    
      emit(state);
    });
  }
}



// class InterestBloc extends Bloc<InterestEvent, InterestState> {
//   final SaveInterest saveInterest;
//   final GetInterest getInterest;

//   InterestBloc(this.saveInterest, this.getInterest) : super(const InterestState()) {
//     on<InterestInputed>((event, emit) async {
//       // handle incoming `InterestInputed` event
//       final result = await saveInterest.execute(event.interest);
      
//       result.fold((l) => null, (r) => emit(state.copyWith(status: InterestStatus.success,)));
//     });

//     // on<InterestFetched>((event, emit) async {
//     //   // handle incoming `InterestFetched` event
//     //   final result = await getInterest.execute();
//     //   result.fold((l) => null, (r) => null);
//     // });
//   }
// }
