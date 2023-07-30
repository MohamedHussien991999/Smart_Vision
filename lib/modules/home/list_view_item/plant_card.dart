import 'dart:io';

import 'package:flutter/material.dart';
import '../../../model/plant_model.dart';

class PlantCard extends StatelessWidget {
  const PlantCard({Key? key, this.active, this.index, required this.plant})
      : super(key: key);

  final bool? active;
  final int? index;
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    final double blur = active! ? 13 : 0;
    final double offset = active! ? 4 : 0;
    final double top = active! ? 0 : 46;
    return Column(
      children: [
        SizedBox(
          height: 320,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutQuint,
            margin: EdgeInsets.only(
              top: top,
              bottom: 0,
              right: 15.5,
              left: active! ? 28 : 0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: plant.startColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black87.withOpacity(0.3),
                    blurRadius: blur,
                    offset: Offset(0, offset)),
              ],
              image: DecorationImage(
                  fit: BoxFit.cover, image: FileImage(File(plant.imagePath!))),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      gradient: LinearGradient(
                        colors: [
                          plant.startColor,
                          plant.endColor.withOpacity(0.01),
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        tileMode: TileMode.clamp,
                        stops: const [0.1, 0.4],
                      )),
                ),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${plant.createdAt}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ]),
        )
      ],
    );
  }
}
