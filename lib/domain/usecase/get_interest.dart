import 'package:dartz/dartz.dart';
import 'package:flutter_you_app/core/errors/app_error.dart';
import 'package:flutter_you_app/domain/repositories/interest_repository.dart';

class GetInterest {
  final InterestRepository interestRepository;

  GetInterest(this.interestRepository);
  Future<Either<AppError, List<String>>> execute() async {
    return await interestRepository.getAllInterest();
  }
}
