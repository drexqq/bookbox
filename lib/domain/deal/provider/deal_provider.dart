import 'package:bookbox/domain/deal/model/book_deal.dart';
import 'package:bookbox/domain/deal/repository/deal_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dealNotifierProvider =
    ChangeNotifierProvider<DealNotifier>((ref) => DealNotifier(ref));

class DealNotifier extends ChangeNotifier {
  DealNotifier(this._ref) : super();
  final Ref _ref;

  late final DealRepository _repository = _ref.read(dealRepositoryProvider);

  Future<List<BookDeal>> getDeals() async {
    return await _repository.getDeals();
  }
}
