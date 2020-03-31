import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../generated/i18n.dart';
import '../../../core/notification_helper.dart';
import '../../shared_widgets.dart';
import 'failure_container.dart';

typedef OnPermissionGranted = void Function();

class NoLocationPermission extends StatefulWidget {
  final OnPermissionGranted onPermissionGranted;

  const NoLocationPermission({
    Key key,
    this.onPermissionGranted,
  }) : super(key: key);

  @override
  _NoLocationPermissionState createState() => _NoLocationPermissionState();
}

//ignore_for_file: prefer_mixin
class _NoLocationPermissionState extends State<NoLocationPermission>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final granted = await Permission.location.isGranted;
      if (granted) {
        widget.onPermissionGranted?.call();
      }
    }
  }

  void _requestAppSettings() async {
    //opens App'wide system settings
    final opened = await openAppSettings();

    if (!opened) {
      context.showNotificationSnackBar(
        text: I18n.of(context).notification_cantOpenAppSetting,
        duration: const Duration(seconds: 30),
      );
    }
  }

  void _refreshPermission() async {
    final permissionPernamentlyDenied =
        await Permission.location.isPermanentlyDenied;

    if (!permissionPernamentlyDenied) {
      final status = await Permission.location.request();

      if (status == PermissionStatus.granted) {
        widget.onPermissionGranted?.call();
      }
    } else {
      _requestAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = I18n.of(context);
    return FailureContainer(
      title: tr.failure_locationPermission_title,
      refreshText: tr.failure_locationPermission_refreshText,
      titleIcon: FontAwesomeIcons.globe,
      refreshIcon: FontAwesomeIcons.cogs,
      onRefresh: _refreshPermission,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
