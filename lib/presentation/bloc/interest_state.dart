// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'interest_bloc.dart';

enum InterestStatus { initial, loading, success, failure, input }

class InterestState extends Equatable {
  final InterestStatus status;
  final List<String> interests;
  final List<String> interestsTemp;

  const InterestState(
      {this.status = InterestStatus.initial,
      this.interests = const <String>[],
      this.interestsTemp = const <String>[]});

  const InterestState.initial(
      {this.status = InterestStatus.initial,
      this.interests = const <String>[],
      this.interestsTemp = const <String>[]});   

  @override
  // TODO: implement props
  List<Object?> get props => [status, interests, interestsTemp];

  InterestState copyWith({
    InterestStatus? status,
    List<String>? interests,
    List<String>? interestsTemp,
  }) {
    return InterestState(
      status: status ?? this.status,
      interests: interests ?? this.interests,
      interestsTemp: interestsTemp ?? this.interestsTemp, 
    );
  }
}
