import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/builder/vendor/vendor.dart';

class VendorBestSellingWidget extends StatefulWidget {
  final WidgetConfig? widgetConfig;

  VendorBestSellingWidget({
    Key? key,
    required this.widgetConfig,
  }) : super(key: key);

  @override
  _VendorBestSellingWidgetState createState() => _VendorBestSellingWidgetState();
}

class _VendorBestSellingWidgetState extends State<VendorBestSellingWidget> with Utility {
  late AppStore _appStore;
  late SettingStore _settingStore;
  late AuthStore _authStore;
  VendorStore? _vendorStore;

  @override
  void didChangeDependencies() {
    _appStore = Provider.of<AppStore>(context);
    _settingStore = Provider.of<SettingStore>(context);
    _authStore = Provider.of<AuthStore>(context);

    Map<String, dynamic> fields = widget.widgetConfig?.fields ?? {};

    // Filter
    int limit = ConvertData.stringToInt(get(fields, ['limit'], 4));

    String? key = StringGenerate.getVendorKeyStore(
      widget.widgetConfig!.id,
      language: _settingStore.locale,
      limit: limit,
      radius: 50,
    );

    // Add store to list store
    if (widget.widgetConfig != null && _appStore.getStoreByKey(key) == null) {
      VendorStore store = VendorStore(
        _settingStore.requestHelper,
        key: key,
        perPage: limit,
        lang: _settingStore.locale,
        sort: {
          'key': 'vendor_list_selling_asc',
          'query': {
            'orderby': 'selling',
            'order': 'asc',
          },
        },
        rangeDistance: 50,
        locationStore: _authStore.locationStore,
      )..getVendors();
      _appStore.addStore(store);
      _vendorStore ??= store;
    } else {
      _vendorStore = _appStore.getStoreByKey(key);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (_vendorStore == null) {
          return Container();
        }
        List<Vendor> vendors = _vendorStore!.vendors;
        bool loading = _vendorStore!.loading;

        Map fields = widget.widgetConfig?.fields ?? {};
        int limit = ConvertData.stringToInt(get(fields, ['limit'], 4));

        List<Vendor> emptyVendors = List.generate(limit, (index) => Vendor());
        return VendorWidget(
          widgetConfig: widget.widgetConfig,
          vendors: loading ? emptyVendors : vendors,
        );
      },
    );
  }
}
