import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'cubit/cubit_layout.dart';
import 'cubit/states_layout.dart';

class PlantLayoutScreen extends StatelessWidget {
  const PlantLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PlantLayoutCubit(),
      child: BlocConsumer<PlantLayoutCubit, PlantLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          PlantLayoutCubit cubit = PlantLayoutCubit.get(context);
          return Scaffold(
              body: cubit.screens[cubit.currentIndex],
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  cubit.detectPlant(context);
                },
                backgroundColor: Colors.green,
                child: const Icon(
                  Icons.touch_app_outlined,
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: StylishBottomBar(
                items: cubit.bottomItems,
                hasNotch: true,
                fabLocation: StylishBarFabLocation.center,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNavBar(index);
                },
                option: AnimatedBarOptions(
                  // iconSize: 32,
                  barAnimation: BarAnimation.fade,
                  iconStyle: IconStyle.animated,
                  // opacity: 0.3,
                ),
              ));
        },
      ),
    );
  }
}
/*
Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(40)),
                child: BottomNavigationBar(
                  items: cubit.bottomItems,
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    cubit.changeBottomNavBar(index);
                  },
                  selectedItemColor: activeColorIndicator,
                  unselectedItemColor: descriptionTextColor,
                  elevation: 30,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                ),
              )
*/ 