part of 'interest_bloc.dart';

class InterestEvent {}

class InterestTextFieldSubmited extends InterestEvent {
  String interest;
  InterestTextFieldSubmited(this.interest);
}


class InterestRemoved extends InterestEvent {
  String interest;
  InterestRemoved(this.interest);
}


class InterestInputed extends InterestEvent {
  String interest;
  InterestInputed(this.interest);
}

class InterestFetched extends InterestEvent {}
