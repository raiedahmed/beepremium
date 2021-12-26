import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/models/location/prediction.dart';
import 'package:cirilla/screens/location/widgets/item_location.dart';
import 'package:cirilla/service/service.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui/notification/notification_screen.dart';

class Search extends StatefulWidget {
  final String? search;
  final GooglePlaceApiHelper apiClient;
  final Function setDataSearch;
  final List<Prediction> dataSearch;

  Search({
    Key? key,
    this.search,
    required this.apiClient,
    required this.setDataSearch,
    required this.dataSearch,
  });

  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Prediction> _data = [];
  CancelToken? _token;
  bool loading = true;
  String text = '';
  @override
  void dispose() {
    _token?.cancel('cancelled');
    super.dispose();
  }

  Future<List<Prediction>> search(CancelToken? token) async {
    setState(() {
      loading = true;
    });
    try {
      if (widget.search!.length >= 2 && widget.search!.length != text.length && widget.search!.trim() != '') {
        List<Prediction>? data = await widget.apiClient.getPlaceAutocomplete(queryParameters: {
          'input': widget.search,
          //'language': 'vi',
          //'components': 'country:vn',
        }, cancelToken: token);
        widget.setDataSearch(data);
        setState(() {
          text = widget.search!;
          _data = List<Prediction>.of(data);
          loading = false;
        });
      }
    } catch (e) {
      print('Cancel fetch');
      setState(() {
        loading = false;
      });
    }
    return _data;
  }

  @override
  void didUpdateWidget(oldWidget) {
    if (_token != null) {
      _token?.cancel('cancelled');
    }

    setState(() {
      _token = CancelToken();
    });

    search(_token);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    ThemeData theme = Theme.of(context);
    if (widget.search!.length >= 2 && widget.search!.trim() != '') {
      return ListView.builder(
        itemBuilder: (context, index) {
          Prediction item = _data.length == 0 ? widget.dataSearch[index] : _data[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: layoutPadding),
            child: ItemLocation(
              title: item.structuredFormatting.mainText,
              subTitle: item.structuredFormatting.secondaryText,
              search: widget.search ?? '',
              loading: _data.length == 0 && widget.dataSearch.length != 0 || widget.search!.length == text.length
                  ? false
                  : loading,
              onTap: () {
                Navigator.pop(context, item);
              },
            ),
          );
        },
        itemCount: _data.length == 0 ? widget.dataSearch.length : _data.length,
      );
    }
    return Center(
      child: NotificationScreen(
        title: Text(
          translate('search_location')!,
          style: theme.textTheme.headline6,
        ),
        content: Text(
          translate('search_enter_your_address')!,
          style: theme.textTheme.bodyText2,
        ),
        iconData: FontAwesomeIcons.mapMarked,
        isButton: false,
      ),
    );
  }
}
