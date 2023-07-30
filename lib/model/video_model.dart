import 'dart:io';

class VideoModel {
  String? videoPath;
  File? video;
  String? resultVideoPath;
  File? resultVideo;
  int? number;

  VideoModel({this.number, this.resultVideoPath, this.videoPath});

  VideoModel.fromJson(data) {
    videoPath = data['video'];
    number = data['number'];
    resultVideoPath = data['resultVideo'];
  }

  var videoHistory = <VideoModel>[];
}
