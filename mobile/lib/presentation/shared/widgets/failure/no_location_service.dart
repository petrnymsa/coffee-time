import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../generated/i18n.dart';
import '../../shared_widgets.dart';
import 'failure_container.dart';

typedef OnLocationServiceEnabled = void Function();

class NoLocationService extends StatefulWidget {
  final OnLocationServiceEnabled onLocationServiceOpened;

  const NoLocationService({
    Key key,
    this.onLocationServiceOpened,
  }) : super(key: key);

  @override
  _NoLocationServiceState createState() => _NoLocationServiceState();
}

//ignore_for_file: prefer_mixin
class _NoLocationServiceState extends State<NoLocationService>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      widget.onLocationServiceOpened?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = I18n.of(context);
    return FailureContainer(
      title: tr.failure_locationService_title,
      refreshText: tr.failure_locationService_refreshText,
      titleIcon: FontAwesomeIcons.compass,
      refreshIcon: FontAwesomeIcons.cogs,
      onRefresh: () async {
        await AppSettings.openLocationSettings();
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
