// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_farm/modules/home/page_view/pageview_destination_list.dart';
import 'package:smart_farm/shared/components/components.dart';
import 'package:smart_farm/shared/components/constants.dart';
import '../../config/constants.dart';
import '../../config/route/scale_route.dart';
import '../profile/Profile.dart';
import 'list_view_item/listView_Item.dart';

class HomeScreen extends StatelessWidget {
  bool? isEmpty;
  HomeScreen({super.key, this.isEmpty});
  ImageProvider changeImage() {
    if (loginModelFinal!.imageProfile == null) {
      return const AssetImage('assets/images/Default_prf.png');
    } else {
      return FileImage(loginModelFinal!.imageProfile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    isEmpty ??= false;
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 15, right: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, ScaleRoute(page: const Profile()));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 18, left: 2, right: 5),
                      padding: const EdgeInsets.all(5),
                      height: 55,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFEFEF),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Row(children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: changeImage(),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                          ),
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          loginModelFinal!.userName ?? '',
                          style: const TextStyle(
                            fontFamily: "geometric",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Text(
                          "   ",
                          style: TextStyle(
                            fontFamily: "geometric",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Stack(
                  children: [
                    RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: 'Explorer the\n',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'SFdisplay',
                                fontSize: 40)),
                        TextSpan(
                            text: 'Beautiful ',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'geometric',
                                fontSize: 40)),
                        TextSpan(
                            text: 'World\n',
                            style: TextStyle(
                                color: Color(0xffFF7029),
                                fontFamily: 'geometric',
                                fontSize: 40)),
                      ]),
                    ),
                    Positioned(
                      right: 20,
                      top: 95,
                      child: SvgPicture.asset('assets/images/Vector.svg'),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17, right: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "History",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  isEmpty!
                      ? const Text("")
                      : GestureDetector(
                          onTap: !isEmpty!
                              ? () {
                                  Navigator.push(context,
                                      ScaleRoute(page: const ListViewItem()));
                                }
                              : null,
                          child: const Text("View all",
                              style: TextStyle(
                                  fontSize: 15, color: activeColorIndicator)),
                        )
                ],
              ),
            ),
            const PageViewPlantList(),
          ]),
        ),
      ),
    );
  }
}
