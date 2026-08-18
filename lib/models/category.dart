import 'package:flutter/foundation.dart';

@immutable
class Category {
  final int? id;
  final String name;
  final String? icon;
  final bool isDefault;

  const Category({this.id, required this.name, this.icon, this.isDefault = false});
}
