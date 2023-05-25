// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'interest_bloc.dart';

enum InterestStatus { initial, loading, success, failure }

class InterestState extends Equatable {
  final InterestStatus status;
  final List<String> interests;

  const InterestState({this.status = InterestStatus.initial, this.interests = const <String>[]});

  @override
  // TODO: implement props
  List<Object?> get props => [status, interests];

  InterestState copyWith({
    InterestStatus? status,
    List<String>? interests,
  }) {
    return InterestState(
      status: status ?? this.status,
      interests: interests ?? this.interests,
    );
  }
}
