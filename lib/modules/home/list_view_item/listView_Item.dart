import 'package:flutter/material.dart';
import 'package:smart_farm/modules/home/list_view_item/listView_ItemCard.dart';
import 'package:smart_farm/shared/components/constants.dart';
import '../../../../config/route/scale_route.dart';
import '../details/details_screen.dart';

class ListViewItem extends StatelessWidget {
  const ListViewItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "All Plants",
          style: TextStyle(color: Colors.black),
        ),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(
              Icons.navigate_before,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        }),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: plantModelFinal!.plantsHistory.length,
          itemBuilder: (context, item) {
            final des = plantModelFinal!.plantsHistory[item];
            return ListViewItemCard(
                image: des.imagePath!,
                name: '${des.createdAt}',
                onPress: () {
                  Navigator.push(
                      context,
                      ScaleRoute(
                          page: DetailsScreen(
                        des: des,
                      )));
                });
          }),
    );
  }
}
