import 'package:cirilla/models/models.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/store/auth/auth_store.dart';
import 'package:mobx/mobx.dart';

part 'transaction_wallet_store.g.dart';

class TransactionWalletStore = _TransactionWalletStore with _$TransactionWalletStore;

abstract class _TransactionWalletStore with Store {
  late AuthStore _auth;

  final String? key;
  // Request helper instance
  RequestHelper _requestHelper;

  // store for handling errors
  // final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _TransactionWalletStore(
    this._requestHelper, {
    int? perPage,
    this.key,
    required AuthStore auth,
  }) {
    if (perPage != null) _perPage = perPage;
    _auth = auth;
    _reaction();
  }

  // store variables:-----------------------------------------------------------
  static ObservableFuture<List<TransactionWallet>> emptyTransactionWalletResponse = ObservableFuture.value([]);

  @observable
  ObservableFuture<List<TransactionWallet>?> fetchTransactionWalletsFuture = emptyTransactionWalletResponse;

  @observable
  ObservableList<TransactionWallet> _transactionWallets = ObservableList<TransactionWallet>.of([]);

  @observable
  bool success = false;

  @observable
  int _nextPage = 1;

  @observable
  int _perPage = 1;

  @observable
  bool _canLoadMore = true;

  @observable
  String? _userId;

  @observable
  double _amountBalance = 0;

  // computed:-------------------------------------------------------------------
  @computed
  bool get loading => fetchTransactionWalletsFuture.status == FutureStatus.pending;

  @computed
  ObservableList<TransactionWallet> get transactionWallets => _transactionWallets;

  @computed
  bool get canLoadMore => _canLoadMore;

  @computed
  int get perPage => _perPage;

  @computed
  double get amountBalance => _amountBalance;

  // actions:-------------------------------------------------------------------

  @action
  Future<void> getAmountBalance() async {
    try {
      print('getAmountBalance');
      print(_userId);
      double amount = await _requestHelper.getAmountBalance(userId: _auth.user?.id ?? '');
      _amountBalance = amount;
    } catch (e) {
      print('Error getAmountBalance');
      _amountBalance = 0;
    }
  }

  @action
  Future<void> getTransactionWallets() async {
    final future = _requestHelper.getTransactionWallet(userId: _auth.user?.id ?? '');
    fetchTransactionWalletsFuture = ObservableFuture(future);
    return future.then((data) {
      // Replace state in the first time or refresh
      if (_nextPage <= 1) {
        _transactionWallets = ObservableList<TransactionWallet>.of(data!);
      } else {
        // Add posts when load more page
        _transactionWallets.addAll(ObservableList<TransactionWallet>.of(data!));
      }

      // Check if can load more item
      if (data.length >= _perPage) {
        _nextPage++;
      } else {
        _canLoadMore = false;
      }
    }).catchError((error) {
      print(error);
      // errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future<void> refresh() {
    _canLoadMore = true;
    _nextPage = 1;
    return getTransactionWallets();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _reaction() {
    _disposers = [];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
