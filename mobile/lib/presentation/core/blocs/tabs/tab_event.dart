import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/app_tab.dart';

part 'tab_event.freezed.dart';

@freezed
abstract class TabEvent with _$TabEvent {
  const factory TabEvent.setTab(AppTabKey tab) = SetTab;
}
