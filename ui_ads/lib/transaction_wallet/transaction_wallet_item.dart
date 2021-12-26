import 'package:flutter/material.dart';

class TransactionWalletContainedItem extends StatelessWidget {
  final Widget title;
  final Widget date;
  final Widget amount;
  final Widget type;
  final EdgeInsets? padding;
  final double radius;
  final Color? color;
  final GestureTapCallback? onClick;

  TransactionWalletContainedItem({
    Key? key,
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
    this.padding,
    this.color,
    this.radius = 8,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onClick,
      child: Container(
        padding: padding ?? EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            date,
            SizedBox(height: 8),
            title,
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [type])),
                SizedBox(width: 12),
                amount,
              ],
            )
          ],
        ),
      ),
    );
  }
}
