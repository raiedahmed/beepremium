import 'package:cirilla/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LocationSetupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(itemPaddingExtraLarge),
          child: Column(
            children: [
              Text(
                'Looking for your location...',
                style: theme.textTheme.caption,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Icon(
                FontAwesomeIcons.mapMarked,
                size: 94,
                color: theme.primaryColor,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(height: 60),
                  Positioned(
                    top: 24,
                    left: 0,
                    right: 0,
                    child: Text(
                      '396 NY-52, Woodbourne, NY 12788',
                      style: theme.textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
