import 'package:permission_handler/permission_handler.dart';

//ignore_for_file: one_member_abstracts
abstract class AppPermissionProvider {
  Future<PermissionStatus> request();
}

class LocationAppPermissionProvider implements AppPermissionProvider {
  @override
  Future<PermissionStatus> request() => Permission.location.request();
}
