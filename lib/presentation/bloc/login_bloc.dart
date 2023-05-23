import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_you_app/data/models/email.dart';
import 'package:flutter_you_app/data/models/password.dart';
import 'package:flutter_you_app/domain/usecase/login.dart';
import 'package:flutter_you_app/presentation/bloc/login_event.dart';

import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login login;

  LoginBloc(this.login) : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
  }

  FutureOr<void> _onEmailChanged(LoginEmailChanged event, emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  FutureOr<void> _onPasswordChanged(LoginPasswordChanged event, emit) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.password]),
      ),
    );
  }
}