import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_you_app/data/models/confirmation_password.dart';
import 'package:flutter_you_app/data/models/email.dart';
import 'package:flutter_you_app/data/models/name.dart';
import 'package:flutter_you_app/data/models/password.dart';
import 'package:flutter_you_app/domain/usecase/register.dart';
import 'package:formz/formz.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final Register register;

  RegisterBloc(this.register) : super(const RegisterState()) {
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterConfirmationPasswordChanged>(_onConfirmationPasswordChanged);
    on<RegisterUsernameChanged>(_onUsernameChanged);
    on<RegisterPressed>(_register);
  }

  FutureOr<void> _onEmailChanged(RegisterEmailChanged event, emit) {
    final email = Email.dirty(event.email);
    bool allFieldValid =
        Formz.validate([email, state.username, state.password, state.confirmationPassword]);
    emit(
      state.copyWith(email: email, isValid: allFieldValid),
    );
  }

  FutureOr<void> _onPasswordChanged(RegisterPasswordChanged event, emit) {
    final password = Password.dirty(event.password);
    bool allFieldValid =
        Formz.validate([password, state.confirmationPassword, state.email, state.username]);
    emit(
      state.copyWith(
        password: password,
        isValid: allFieldValid,
      ),
    );
  }

  FutureOr<void> _onConfirmationPasswordChanged(RegisterConfirmationPasswordChanged event, emit) {
    final confirmPassword = ConfirmationPassword.dirty([
      event.confirmationPassword,
      state.password.value,
    ]);
    bool allFieldValid =
        Formz.validate([confirmPassword, state.password, state.email, state.username]);
    log('errorConfirmPass: ${confirmPassword.displayError}');
    emit(
      state.copyWith(
        confirmationPassword: confirmPassword,
        isValid: allFieldValid,
      ),
    );
  }

  FutureOr<void> _onUsernameChanged(RegisterUsernameChanged event, emit) {
    final username = Username.dirty(event.username);
    bool allFieldValid =
        Formz.validate([username, state.password, state.confirmationPassword, state.email]);
    emit(
      state.copyWith(name: username, isValid: allFieldValid),
    );
  }

  Future<void> _register(RegisterPressed event, emit) async {
    // if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    var entity = RegisterParams(
      email: state.email.value,
      password: state.password.value,
      name: state.username.value,
    );
    final result = await register.execute(entity);

    result.fold((error) {
      emit(
        state.copyWith(status: FormzSubmissionStatus.failure, errorMessage: error.message),
      );
    }, (data) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
      ));
    });
  }
}
