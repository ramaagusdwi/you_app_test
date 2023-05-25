import 'package:hive/hive.dart';

abstract class InterestLocalDataSource {
  bool addInterest(String data);
  Future<List<String>?> getAllInterest();
}

class InterestLocalDataSourceImpl extends InterestLocalDataSource {
  final Box<String> _interestBox;

  InterestLocalDataSourceImpl(this._interestBox);

  @override
  bool addInterest(String data) {
    _interestBox.add(data);
    String? interest = _interestBox.getAt(0);
    if (interest != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<String>?> getAllInterest() async {
    return _interestBox.values.toList();
  }
}
