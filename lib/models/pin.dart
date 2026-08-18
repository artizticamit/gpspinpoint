import 'package:flutter/foundation.dart';

@immutable
class Pin {
  final int? id;
  final double latitude;
  final double longitude;
  final double? altitude;
  final double accuracy;
  final String? title;
  final String? description;
  final int? categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isArchived;

  const Pin({
    this.id,
    required this.latitude,
    required this.longitude,
    this.altitude,
    required this.accuracy,
    this.title,
    this.description,
    this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    this.isArchived = false,
  });

  Pin copyWith({
    int? id,
    double? latitude,
    double? longitude,
    double? altitude,
    double? accuracy,
    String? title,
    String? description,
    int? categoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isArchived,
  }) {
    return Pin(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      altitude: altitude ?? this.altitude,
      accuracy: accuracy ?? this.accuracy,
      title: title ?? this.title,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isArchived: isArchived ?? this.isArchived,
    );
  }
}
