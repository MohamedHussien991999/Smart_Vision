import 'package:flutter/material.dart';
import '../../../config/constants.dart';
import '../../../shared/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../login/login_screen.dart';

// ignore: must_be_immutable
class SecondPageSlider extends StatelessWidget {
  SecondPageSlider({Key? key, required this.controllerPageSlider})
      : super(key: key);
  PageController controllerPageSlider = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40)),
                image: DecorationImage(
                  image: AssetImage('assets/images/2.png'),
                  fit: BoxFit.contain,
                ),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: () => navigateTo(context, const LoginScreen()),
                    child: const Text(
                      "SKiP",
                      style: TextStyle(
                          color: skipColorButton,
                          fontSize: 24,
                          fontFamily: 'switzer'),
                    )),
              ),
            ),
          ),
          Column(
            children: [
              Stack(
                children: [
                  RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                          text:
                              ' We love helping you to \n\t \t\t\t  safe Your ',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'geometric',
                              fontSize: 30)),
                      TextSpan(
                          text: 'Farm\n',
                          style: TextStyle(
                              color: Color(0xffFF7029),
                              fontFamily: 'geometric',
                              fontSize: 30)),
                    ]),
                  ),
                  Positioned(
                      right: MediaQuery.of(context).size.width / 7,
                      top: MediaQuery.of(context).size.height * 10 / 100,
                      child: SvgPicture.asset('assets/images/Vector.svg')),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text:
                          'Our platform promotes sustainable agriculture by reducing pesticide use, promoting biodiversity, and ensuring long-term viability while protecting the environment',
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: descriptionTextColor,
                          fontSize: 18,
                          fontFamily: 'gillsans')),
                  TextSpan(
                      text:
                          " and Our platform offers detailed reports on plant diseases, helping farmers and researchers make informed decisions to manage crops and prevent disease spread.",
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: descriptionTextColor,
                          fontSize: 18,
                          fontFamily: 'gillsans'))
                ])),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              controllerPageSlider.nextPage(
                  duration: const Duration(microseconds: 750),
                  curve: Curves.fastLinearToSlowEaseIn);
            },
            child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                    left: 30, right: 30, bottom: 20, top: 17),
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'switzer'),
                )),
          )
        ]),
      ),
    );
  }
}
