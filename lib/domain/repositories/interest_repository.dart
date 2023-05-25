import 'package:dartz/dartz.dart';
import 'package:flutter_you_app/core/errors/app_error.dart';

abstract class InterestRepository {
  Future<Either<AppError, bool>> addInterest(String interest);
  Future<Either<AppError, List<String>>> getAllInterest();
}
