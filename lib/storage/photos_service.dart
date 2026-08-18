import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PhotosService {
  Future<Directory> getPhotosDir() async {
    final doc = await getApplicationDocumentsDirectory();
    final dir = Directory('${doc.path}/photos');
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  Future<String> savePhoto(File file, String filename) async {
    final dir = await getPhotosDir();
    final dest = File('${dir.path}/$filename');
    await file.copy(dest.path);
    return dest.path;
  }
}
