import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:feather_icons/feather_icons.dart';

import 'package:ui/ui.dart';

import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/location/user_location.dart';
import 'package:cirilla/models/location/prediction.dart';
import 'package:cirilla/screens/screens.dart';
import 'package:cirilla/store/auth/location_store.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/models/location/place.dart';
import 'package:cirilla/service/helpers/google_place_helper.dart';

import 'search_location.dart';
import 'widgets/item_address.dart';
import 'widgets/use_my_current_location.dart';

class LocationScreen extends StatefulWidget {
  static const routeName = '/location';

  final SettingStore? store;

  LocationScreen({
    Key? key,
    this.store,
  }) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> with AppBarMixin, LoadingMixin {
  final apiClient = GooglePlaceApiHelper();

  late LocationStore _locationStore;

  bool _loading = false;

  @override
  void didChangeDependencies() {
    _locationStore = Provider.of<AuthStore>(context).locationStore;

    super.didChangeDependencies();
  }

  void onPressed(BuildContext context) async {
    try {
      TranslateType translate = AppLocalizations.of(context)!.translate;
      Prediction? result = await showSearch(
        context: context,
        delegate: SearchLocationScreen(context, translate),
      );

      if (result == null || result.placeId == null) return;
      setState(() {
        _loading = true;
      });

      Place place = await apiClient.getPlaceDetailFromId(queryParameters: {'place_id': result.placeId});

      _locationStore.setLocation(location: place.toUserLocation());

      setState(() {
        _loading = false;
      });

      Navigator.pop(context);
    } catch (_) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return Observer(builder: (_) {
      LocationStore locationStore = _locationStore;
      List<UserLocation> data = _locationStore.locations;
      return Stack(
        children: [
          Scaffold(
            appBar: baseStyleAppBar(
              context,
              title: translate('location_txt')!,
              actions: [
                InkResponse(
                  onTap: () => onPressed(context),
                  radius: 29,
                  child: Icon(
                    FeatherIcons.search,
                    size: 20,
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
            bottomNavigationBar: Container(
              // padding: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.symmetric(vertical: itemPaddingLarge, horizontal: layoutPadding),
              decoration: BoxDecoration(color: theme.canvasColor, boxShadow: initBoxShadow),
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, FormAddressScreen.routeName),
                  child: Text(translate('location_button_add_address')!),
                  style: ElevatedButton.styleFrom(
                    textStyle: theme.textTheme.subtitle2,
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: layoutPadding),
                    child: UseMyCurrentLocation(),
                  ),
                  // if (locationStore.location.id != null)
                  ItemAddress(
                    location: locationStore.location,
                    padding: EdgeInsets.symmetric(vertical: itemPaddingLarge, horizontal: layoutPadding),
                    isSelect: true,
                    addressBasic: true,
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectLocationScreen(
                            store: widget.store,
                            location: _locationStore.location,
                          ),
                        ),
                      );
                      if (result is UserLocation) {
                        await _locationStore.setLocation(location: result);
                      }
                    },
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: itemPaddingMedium, horizontal: layoutPadding),
                    color: theme.colorScheme.surface,
                    child: Text(
                      translate('location_saved')!,
                      style: theme.textTheme.caption!.copyWith(color: theme.textTheme.subtitle1!.color),
                    ),
                  ),
                  Column(
                    children: List.generate(data.length, (index) {
                      UserLocation item = data[index];
                      return DismissibleItem(
                        item: item.id!,
                        onDismissed: (direction) => _locationStore.deleteLocation(id: item.id!),
                        confirmDismiss: (DismissDirection direction) => Future.value(true),
                        child: Column(
                          children: [
                            ItemAddress(
                              location: item,
                              padding: EdgeInsets.symmetric(vertical: itemPaddingLarge, horizontal: layoutPadding),
                              onTap: () async {
                                setState(() {
                                  _loading = true;
                                });
                                await _locationStore.setLocation(location: item);
                                setState(() {
                                  _loading = false;
                                });
                                Navigator.pop(context);
                              },
                            ),
                            Divider(height: 1, thickness: 1, endIndent: layoutPadding, indent: layoutPadding),
                          ],
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
          if (_loading) entryLoading(context),
        ],
      );
    });
  }
}
