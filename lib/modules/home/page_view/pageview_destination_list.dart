import 'package:flutter/material.dart';
import 'package:smart_farm/shared/components/constants.dart';
import '../../../config/route/scale_route.dart';
import '../list_view_item/listView_Item.dart';
import '../list_view_item/plant_card.dart';

class PageViewPlantList extends StatefulWidget {
  const PageViewPlantList({Key? key}) : super(key: key);

  @override
  State<PageViewPlantList> createState() => _PageViewPlantListState();
}

class _PageViewPlantListState extends State<PageViewPlantList> {
  final PageController pageController = PageController(viewportFraction: 0.90);
  int curettage = 0;
  @override
  Widget build(BuildContext context) {
    return plantModelFinal?.plantsHistory == null
        ? const SizedBox(
            height: 420,
            child: Image(
              image: AssetImage('assets/images/empty_data_set.png'),
              height: 420,
            ),
          )
        : GestureDetector(
            onTap: () {
              Navigator.push(context, ScaleRoute(page: const ListViewItem()));
            },
            child: SizedBox(
              height: 420,
              child: PageView.builder(
                padEnds: false,
                controller: pageController,
                itemCount: plantModelFinal!.plantsHistory.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  bool active = index == curettage;
                  return Opacity(
                    opacity: curettage == index ? 1.0 : 0.5,
                    child: PlantCard(
                      active: active,
                      index: index,
                      plant: plantModelFinal!.plantsHistory[index],
                    ),
                  );
                },
              ),
            ));
  }

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      int position = pageController.page!.round();
      if (curettage != position) {
        setState(() {
          curettage = position;
        });
      }
    });
  }
}
