import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatefulWidget {
  WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> with AppBarMixin, LoadingMixin {
  late SettingStore _settingStore;
  late TransactionWalletStore _transactionWalletStore;
  final ScrollController _controller = ScrollController();

  @override
  void didChangeDependencies() {
    AuthStore authStore = Provider.of<AuthStore>(context);
    _settingStore = Provider.of<SettingStore>(context);
    _transactionWalletStore = authStore.transactionWalletStoreStore..getTransactionWallets();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_controller.hasClients || _transactionWalletStore.loading || !_transactionWalletStore.canLoadMore) return;
    final thresholdReached = _controller.position.extentAfter < endReachedThreshold;

    if (thresholdReached) {
      _transactionWalletStore.getTransactionWallets();
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return Observer(
      builder: (_) {
        List<TransactionWallet> transactionWallets = _transactionWalletStore.transactionWallets;
        bool loading = _transactionWalletStore.loading;

        bool isShimmer = transactionWallets.length == 0 && loading;
        List<TransactionWallet> loadingProduct = List.generate(10, (index) => TransactionWallet()).toList();

        List<TransactionWallet> data = isShimmer ? loadingProduct : transactionWallets;
        return Scaffold(
          appBar: baseStyleAppBar(context, title: translate('wallet_txt')!),
          body: CustomScrollView(
            slivers: [
              CupertinoSliverRefreshControl(
                onRefresh: _transactionWalletStore.refresh,
                builder: buildAppRefreshIndicator,
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Text(
                        formatCurrency(context, price: '${_transactionWalletStore.amountBalance}'),
                        style: theme.textTheme.headline4,
                        textAlign: TextAlign.center,
                      ),
                      Text(translate('wallet_balance_subtitle')!, style: theme.textTheme.caption),
                      SizedBox(height: 32),
                      Column(
                        children: List.generate(data.length, (index) {
                          double padBottom = index < data.length - 1 ? 16 : 0;
                          return Padding(
                            padding: EdgeInsets.only(bottom: padBottom),
                            child: CirillaTransactionWalletItem(item: data[index]),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              if (loading)
                SliverToBoxAdapter(
                  child: buildLoading(context, isLoading: _transactionWalletStore.canLoadMore),
                ),
            ],
          ),
        );
      },
    );
  }
}
