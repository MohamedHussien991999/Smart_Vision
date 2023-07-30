import 'package:flutter/material.dart';
import '../../../config/constants.dart';
import '../../../layout/plantlayoutscreen.dart';
import '../../../model/plant_model.dart';
import '../../../shared/components/components.dart';

class ImageDetailsScreenDetailTest extends StatelessWidget {
  ImageDetailsScreenDetailTest({Key? key, required this.des}) : super(key: key);
  final Plant des;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          "Details Detection Image ",
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
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: FileImage(des.image!),
                fit: BoxFit.cover,
              )),
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
                "1) type : ${des.type}",
                style:
                    const TextStyle(fontSize: 25, color: descriptionTextColor),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                "2) diseases : ${des.diseases}",
                style:
                    const TextStyle(fontSize: 25, color: descriptionTextColor),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                "3) confidence : ${des.confidence}",
                style:
                    const TextStyle(fontSize: 25, color: descriptionTextColor),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "4) Result Image  ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontFamily: "gillsans",
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            des.resultImage != null
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: FileImage(des.resultImage!),
                        fit: BoxFit.cover,
                      )),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .5,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/images/empty_data_set.png"),
                        fit: BoxFit.cover,
                      )),
                    ),
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
