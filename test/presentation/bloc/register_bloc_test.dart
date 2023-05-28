import 'dart:collection';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_you_app/core/errors/app_error.dart';
import 'package:flutter_you_app/data/models/register_error.dart';
import 'package:flutter_you_app/domain/entities/login_entity.dart';
import 'package:flutter_you_app/domain/usecase/login.dart';
import 'package:flutter_you_app/domain/usecase/register.dart';
import 'package:flutter_you_app/presentation/bloc/login_bloc.dart';
import 'package:flutter_you_app/presentation/bloc/register_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_bloc_test.mocks.dart';
import 'register_bloc_test.mocks.dart';

@GenerateMocks([Register])
void main() {
  late RegisterBloc registerBloc;
  late MockRegister mockRegister;

  setUp(() {
    mockRegister = MockRegister();
    registerBloc = RegisterBloc(mockRegister);
  });

  group('do register bloc test', () {
    blocTest<RegisterBloc, RegisterState>(
      'should emit FormzSubmissionStatus.success if register successfully',
      setUp: () {
        //stub
        //stubbing means returning a fake object when the mock method is called.
        when(mockRegister.execute(any)).thenAnswer((_) async => const Right(true));
      },
      build: () => registerBloc,
      act: (registerBloc) {
        registerBloc.add(RegisterPressed());
      },
      expect: () => [
        const RegisterState(status: FormzSubmissionStatus.inProgress),
        const RegisterState(status: FormzSubmissionStatus.success)
      ],
      verify: (_) {
        verify(mockRegister.execute(any)).called(1);
      },
    );

    blocTest<RegisterBloc, RegisterState>(
      'should emit FormzSubmissionStatus.failure if register failure',
      setUp: () {
        //stub
        //stubbing means returning a fake object when the mock method is called.
        when(mockRegister.execute(any))
            .thenAnswer((_) async => const Left(RegisterError(message: 'User already exist')));
      },
      build: () => registerBloc,
      act: (registerBloc) {
        registerBloc.add(RegisterPressed());
      },
      expect: () => [
        const RegisterState(status: FormzSubmissionStatus.inProgress),
        const RegisterState(
            status: FormzSubmissionStatus.failure, errorMessage: 'User already exist')
      ],
      verify: (_) {
        verify(mockRegister.execute(any)).called(1);
      },
    );
  });
}
