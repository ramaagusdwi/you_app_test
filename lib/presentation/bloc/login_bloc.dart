import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_you_app/data/models/email.dart';
import 'package:flutter_you_app/data/models/password.dart';
import 'package:flutter_you_app/domain/entities/login_entity.dart';
import 'package:flutter_you_app/domain/usecase/login.dart';

import 'package:formz/formz.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login login;

  LoginBloc(this.login) : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginPressed>(_logInWithEmailAndPassword);
  }

  FutureOr<void> _onEmailChanged(LoginEmailChanged event, emit) {
    final email = Email.dirty(event.email);
    bool isEmailAndPassValid = Formz.validate([email, state.password]);
    emit(
      state.copyWith(email: email, isValid: isEmailAndPassValid),
    );
  }

  FutureOr<void> _onPasswordChanged(LoginPasswordChanged event, emit) {
    final password = Password.dirty(event.password);
    bool isEmailAndPassValid = Formz.validate([password, state.email]);
    emit(
      state.copyWith(
        password: password,
        isValid: isEmailAndPassValid,
      ),
    );
  }

  Future<void> _logInWithEmailAndPassword(LoginPressed event, emit) async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    LoginEntity entity = LoginEntity(email: state.email.value, password: state.password.value);
    final result = await login.execute(entity);

    result.fold((error) {  
      emit(
        state.copyWith(status: FormzSubmissionStatus.failure, errorMessage: error.message),
      );
    }, (data) {      
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        errorMessage: data,
      ));
    });
  }
}
