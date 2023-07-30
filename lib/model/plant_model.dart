import 'dart:io';

import 'package:flutter/material.dart';

class Plant {
  String? imageFile64;
  File? image;
  String? imagePath;
  String? resultImage64;
  File? resultImage;
  String? resultImagePath;
  String? name;
  double? rate;
  Color startColor = Colors.green;
  Color endColor = Colors.green;
  double? confidence;
  List? diseases;
  String? createdAt;
  int? id;
  String? type;

  Plant({
    this.id,
    this.resultImage64,
    this.name,
    this.rate,
    this.confidence,
    this.diseases,
    this.imageFile64,
    this.type,
  });

  Plant.fromJson(data) {
    confidence = data['confidence'];
    diseases = data['diseases'];
    imageFile64 = data['image'] as String?;
    type = data['type'] as String?;
    resultImage64 = data['resultImage'] as String?;
    createdAt = data['createdAt'];
    id = data['id'];
  }

  var plantsHistory = <Plant>[];
}
