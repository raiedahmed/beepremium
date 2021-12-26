import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/screens/order/widgets/order_billing.dart';
import 'package:cirilla/screens/order/widgets/order_item.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/models/order/order.dart';
import 'package:cirilla/store/auth/auth_store.dart';
import 'package:cirilla/store/order/order_store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:ui/ui.dart';
import 'package:cirilla/types/types.dart';

import '../screens.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrderData? orderDetail;
  OrderDetailScreen({this.orderDetail});
  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen>
    with Utility, LoadingMixin, AppBarMixin, NavigationMixin, OrderMixin {
  OrderStore? _orderStore;
  late AuthStore _authStore;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authStore = Provider.of<AuthStore>(context);
    RequestHelper requestHelper = Provider.of<RequestHelper>(context);
    _orderStore = OrderStore(
      requestHelper,
    )..getOrderNodes(orderId: widget.orderDetail!.id, userId: _authStore.user!.id);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    Map? billingData = widget.orderDetail!.billing;

    Map? shippingData = widget.orderDetail!.shipping;

    TextTheme textTheme = theme.textTheme;

    Color? textColor = textTheme.subtitle1!.color;

    OrderData orderData = widget.orderDetail!;

    String? currencySymbol = get(widget.orderDetail!.currencySymbol, [], '');

    String? currency = get(widget.orderDetail!.currency, [], '');

    final lineItems = orderData.lineItems;

    final shippingLines = orderData.shippingLines;

    if (_orderStore == null) {
      return Container();
    }
    return Observer(
        builder: (_) => Scaffold(
            appBar:
                baseStyleAppBar(context, title: translate('order_title', {'id': '# ${get(orderData.id, [], '')}'})!),
            body: ListView(
              padding: EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).dividerColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildItem(
                        padding: EdgeInsetsDirectional.only(
                            start: itemPaddingMedium, end: itemPaddingMedium, top: itemPaddingMedium),
                        title: Text(translate('order_number')!, style: textTheme.caption),
                        subTitle: Text(
                          orderData.id.toString(),
                          style: textTheme.subtitle2,
                        ),
                        trailing: buildStatus(theme, translate, orderData),
                      ),
                      buildItem(
                          padding: EdgeInsetsDirectional.only(start: itemPaddingMedium),
                          title: Text(translate('order_date')!, style: textTheme.caption),
                          subTitle:
                              Text(formatDate(date: widget.orderDetail!.dateCreated!), style: textTheme.subtitle2)),
                      buildItem(
                          padding: EdgeInsetsDirectional.only(start: itemPaddingMedium),
                          title: Text(translate('order_email')!, style: textTheme.caption),
                          subTitle: Text(_authStore.user!.userEmail!, style: textTheme.subtitle2)),
                      buildItem(
                          padding: EdgeInsetsDirectional.only(start: itemPaddingMedium),
                          title: Text(translate('order_total')!, style: textTheme.caption),
                          subTitle: Text(
                              formatCurrency(context,
                                  currency: orderData.currency,
                                  price: orderData.total,
                                  symbol: orderData.currencySymbol),
                              style: textTheme.subtitle2)),
                      buildItem(
                          padding: EdgeInsetsDirectional.only(start: itemPaddingMedium),
                          title: Text(translate('order_payment_method')!, style: textTheme.caption),
                          subTitle: Text(orderData.paymentMethodTitle ?? '', style: textTheme.subtitle2)),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: itemPaddingMedium, end: itemPaddingMedium, bottom: itemPaddingMedium),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(translate('order_shipping_method')!, style: textTheme.caption),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: Text(shippingLines!.map((e) => e.methodTitle).join(' , '),
                                        style: textTheme.subtitle2)),
                                Text(
                                    formatCurrency(context,
                                        currency: orderData.currency,
                                        price: orderData.shippingTotal,
                                        symbol: orderData.currencySymbol),
                                    style: textTheme.subtitle2)
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: layoutPadding * 2, bottom: _orderStore!.orderNode.length > 0 ? itemPaddingLarge : 0),
                  child: Text(
                    translate('order_notes')!,
                    style: textTheme.subtitle1,
                  ),
                ),
                ...List.generate(_orderStore!.orderNode.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8), color: Theme.of(context).colorScheme.surface),
                      child: OrderReturnItem(
                        name: Text(
                          "${index + 1} . ${formatDate(date: _orderStore!.orderNode.elementAt(index).dateCreated!)}",
                          style: textTheme.caption,
                        ),
                        dateTime: Text(
                          _orderStore!.orderNode.elementAt(index).note!,
                          style: textTheme.bodyText2!.copyWith(color: textColor),
                        ),
                        onClick: () {},
                      ),
                    ),
                  );
                }),
                Padding(
                  padding: EdgeInsets.only(top: layoutPadding * 2, bottom: itemPaddingLarge),
                  child: Text(
                    translate('order_information')!,
                    style: textTheme.subtitle1,
                  ),
                ),
                ...List.generate(lineItems!.length, (index) {
                  LineItems productData = lineItems.elementAt(index);
                  int? id = productData.productId;
                  return OrderItem(
                    productData: productData,
                    currency: currency,
                    currencySymbol: currencySymbol,
                    onClick: () {
                      Navigator.pushNamed(context, ProductScreen.routeName, arguments: {'id': id});
                    },
                  );
                }),
                Padding(
                  padding: EdgeInsets.only(top: layoutPadding * 2, bottom: itemPaddingMedium),
                  child: Text(
                    translate('order_billing_address')!,
                    style: textTheme.subtitle1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(itemPaddingMedium),
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).dividerColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: OrderBilling(billingData: billingData, style: textTheme.bodyText2),
                ),
                Padding(
                  padding: EdgeInsets.only(top: layoutPadding * 2, bottom: itemPaddingMedium),
                  child: Text(
                    translate('order_shipping_address')!,
                    style: textTheme.subtitle1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(itemPaddingMedium),
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).dividerColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: OrderBilling(billingData: shippingData, style: textTheme.bodyText2),
                ),
                SizedBox(height: layoutPadding * 2),
                buildItem(
                    leading: Text(translate('order_shipping')!, style: textTheme.caption),
                    trailing: Text(
                        formatCurrency(context,
                            currency: orderData.currency,
                            price: orderData.shippingTotal,
                            symbol: orderData.currencySymbol),
                        style: textTheme.caption!.copyWith(color: textColor))),
                buildItem(
                    leading: Text(translate('order_shipping_tax')!, style: textTheme.caption),
                    trailing: Text(
                        formatCurrency(context,
                            currency: orderData.currency,
                            price: orderData.shippingTax,
                            symbol: orderData.currencySymbol),
                        style: textTheme.caption!.copyWith(color: textColor))),
                buildItem(
                  leading: Text(translate('order_tax')!, style: textTheme.caption),
                  trailing: Text(
                    formatCurrency(
                      context,
                      currency: orderData.currency,
                      price: orderData.cartTax,
                      symbol: orderData.currencySymbol,
                    ),
                    style: textTheme.caption!.copyWith(color: textColor),
                  ),
                ),
                buildItem(
                    leading: Text(translate('order_discount')!, style: textTheme.caption),
                    trailing: Text(
                        formatCurrency(context,
                            currency: orderData.currency,
                            price: orderData.discountTotal,
                            symbol: orderData.currencySymbol),
                        style: textTheme.caption!.copyWith(color: textColor))),
                buildItem(
                    leading: Text(translate('order_discount_tax')!, style: textTheme.caption),
                    trailing: Text(
                        formatCurrency(context,
                            currency: orderData.currency,
                            price: orderData.discountTax,
                            symbol: orderData.currencySymbol),
                        style: textTheme.caption!.copyWith(color: textColor))),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(translate('order_total')!, style: textTheme.subtitle2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          formatCurrency(context,
                              currency: orderData.currency, price: orderData.total, symbol: orderData.currencySymbol),
                          style: textTheme.headline6),
                      Text(translate('order_include')!, style: textTheme.overline)
                    ],
                  )
                ]),
                SizedBox(height: 48)
              ],
            )));
  }
}

Widget buildItem(
    {Widget? title,
    Widget? subTitle,
    Widget? leading,
    Widget? trailing,
    EdgeInsetsDirectional? padding,
    bool divider = true}) {
  return Column(
    children: [
      Padding(
          padding: padding ?? EdgeInsetsDirectional.zero,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            if (leading != null) leading,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [title ?? Container(), subTitle ?? Container()],
            ),
            if (trailing != null) trailing
          ])),
      if (divider)
        Divider(
          height: itemPaddingExtraLarge,
          thickness: 1,
        ),
    ],
  );
}
