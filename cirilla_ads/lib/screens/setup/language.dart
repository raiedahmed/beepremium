import 'package:cirilla/constants/app.dart';
import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LanguageSetupScreen extends StatefulWidget {
  final SettingStore? store;

  LanguageSetupScreen({
    Key? key,
    this.store,
  }) : super(key: key);

  @override
  _LanguageSetupScreenState createState() => _LanguageSetupScreenState();
}

class _LanguageSetupScreenState extends State<LanguageSetupScreen> {
  late String _language;

  @override
  void initState() {
    _language = widget.store?.locale ?? defaultLanguage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<Language> languages = widget.store?.supportedLanguages ?? [];

    return Theme(
      data: theme.copyWith(
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 48,
          margin: EdgeInsets.symmetric(horizontal: layoutPadding, vertical: itemPaddingMedium),
          child: ElevatedButton(
            onPressed: () {
              if (_language != widget.store?.locale) {
                widget.store?.changeLanguage(_language);
              }

              widget.store?.closeSelectLanguage();
            },
            child: Text('Save'),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 60, horizontal: layoutPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsetsDirectional.only(end: 25),
                  child: Icon(
                    FontAwesomeIcons.language,
                    size: 76,
                    color: theme.primaryColor,
                    textDirection: TextDirection.ltr,
                  ),
                ),
                SizedBox(height: 24),
                Text('Select Language', style: theme.textTheme.subtitle1),
                if (languages.isNotEmpty) ...[
                  SizedBox(height: 26),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: layoutPadding),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(itemPaddingMedium),
                      boxShadow: initBoxShadow,
                    ),
                    child: Column(
                      children: List.generate(languages.length, (index) {
                        Language lang = languages[index];
                        bool isSelected = lang.locale == _language;
                        return CirillaTile(
                          title: Text(
                            lang.language!,
                            style: theme.textTheme.subtitle2
                                ?.copyWith(color: isSelected ? theme.primaryColor : theme.textTheme.caption!.color),
                          ),
                          trailing: isSelected
                              ? Icon(
                                  FeatherIcons.check,
                                  size: 16,
                                  color: theme.primaryColor,
                                )
                              : null,
                          isChevron: false,
                          isDivider: index < 3,
                          onTap: () {
                            if (!isSelected) {
                              setState(() {
                                _language = lang.locale!;
                              });
                            }
                          },
                        );
                      }),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
