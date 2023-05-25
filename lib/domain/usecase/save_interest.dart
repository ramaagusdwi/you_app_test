import 'package:dartz/dartz.dart';
import 'package:flutter_you_app/core/errors/app_error.dart';
import 'package:flutter_you_app/domain/repositories/interest_repository.dart';

class SaveInterest {
  final InterestRepository interestRepository;

  SaveInterest(this.interestRepository);
  Future<Either<AppError, bool>> execute(String interest) async {
    return await interestRepository.addInterest(interest);
  }
}
