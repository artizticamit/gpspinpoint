import 'package:permission_handler/permission_handler.dart';

class PermissionsHelper {
  Future<bool> ensureLocation() async {
    final status = await Permission.location.status;
    if (status.isGranted) return true;
    final res = await Permission.location.request();
    return res.isGranted;
  }
}
