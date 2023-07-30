import 'package:flutter/material.dart';
import 'package:smart_farm/model/video_model.dart';
import 'package:video_player/video_player.dart';
import '../../../config/constants.dart';
import '../../../layout/plantlayoutscreen.dart';
import '../../../shared/components/components.dart';
import '../../chewie_list_item/chewie_list_item.dart';

class VideoDetailsScreenDetailTest extends StatelessWidget {
  const VideoDetailsScreenDetailTest(
      {Key? key, required this.des, required this.video})
      : super(key: key);
  final VideoModel des;
  final VideoPlayerController video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          "Details Detection Video ",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontFamily: "gillsans",
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .5,
              child: ChewieListItem(
                looping: true,
                videoPlayerController: video,
              ),
            ),
            const Divider(
              height: 8,
              color: deactiveColorIndicator,
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Center(
                child: Text(
                  "About Plants",
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                " Number Of Fruits : ${des.number}",
                style:
                    const TextStyle(fontSize: 25, color: descriptionTextColor),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: () {
            navigateAndFinish(context, const PlantLayoutScreen());
          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0XFF0D6EFD),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text(
              "Ok",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'switzer'),
            ),
          ),
        ),
      ),
    );
  }
}
