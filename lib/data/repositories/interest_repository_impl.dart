import 'package:dartz/dartz.dart';
import 'package:flutter_you_app/core/errors/app_error.dart';
import 'package:flutter_you_app/data/datasources/interest_local_data_source.dart';
import 'package:flutter_you_app/domain/repositories/interest_repository.dart';

class InterestRepositoryImpl extends InterestRepository {
  InterestLocalDataSource interestLocalDataSource;

  InterestRepositoryImpl(this.interestLocalDataSource);

  @override
  Future<Either<AppError, bool>> addInterest(String interest) async {
    final result = interestLocalDataSource.addInterest(interest);
    if (result) {
      return const Right(true);
    } else {
      return const Left(AppError('Failed save interest!'));
    }
  }

  @override
  Future<Either<AppError, List<String>>> getAllInterest() async {
    try {
      final result = await interestLocalDataSource.getAllInterest();
      return Right(result ?? []);
    } on Exception catch (e) {
      return const Left(AppError('Faield get interest data!'));
    }
  }
}
