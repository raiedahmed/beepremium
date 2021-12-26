import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/order/order.dart';
import 'package:cirilla/screens/order/order_detail.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class CirillaOrderItem extends StatelessWidget with OrderMixin {
  final OrderData? order;

  CirillaOrderItem({
    Key? key,
    this.order,
  }) : super(key: key);

  navigateDetail(BuildContext context) {
    if (order != null) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _a1, _a2) => OrderDetailScreen(
            orderDetail: order,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            Offset begin = Offset(0.0, 1.0);

            Offset end = Offset.zero;

            Curve curve = Curves.ease;

            Animatable<Offset> tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    OrderData data = order ?? OrderData();

    return OrderReturnItem(
      name: buildName(theme, data),
      dateTime: buildDate(theme, data),
      code: buildCode(theme, data),
      total: buildTotal(theme, translate, data),
      price: buildPrice(context, theme, data),
      status: buildStatus(theme, translate, data),
      onClick: () => navigateDetail(context),
      color: theme.colorScheme.surface,
    );
  }
}
