import 'package:flutter/material.dart';

import '../constants.dart';
import '../main.dart';
import '../models/category.dart';
import '../models/mount_model.dart';
import '../models/qq.dart';
import 'details_screen.dart';

class MountsApp extends StatelessWidget {
  const MountsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title:
                Center(child: Icon(Icons.terrain, color: mainColor, size: 40)),
            actions: const [SizedBox(width: 40, height: 40)],
            iconTheme: IconThemeData(color: mainColor)),
        drawer: Drawer(
            child: Container(
                padding: const EdgeInsets.all(30),
                color: mainColor,
                alignment: Alignment.bottomLeft,
                child:
                    const Icon(Icons.terrain, color: Colors.white, size: 80))),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHeader(),
            AppSearch(),
            Expanded(child: AppMountListView()),
            AppCategoryList(),
            AppBottomBar()
          ],
        ));
  }
}

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                  'https://avatars.githubusercontent.com/u/5081804?v=4',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover),
            ),
            const SizedBox(width: 20),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Hello, Roman',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              Text('Good Morning',
                  style: TextStyle(color: mainColor, fontSize: 12))
            ])
          ],
        ));
  }
}

class AppSearch extends StatelessWidget {
  const AppSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Discover',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25)),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                      child: const Row(children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 10),
                        Text('Search', style: TextStyle(color: Colors.grey))
                      ])),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.tune, color: Colors.white))
              ],
            )
          ],
        ));
  }
}

class AppMountListView extends StatelessWidget {
  const AppMountListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: mountItems.length,
            itemBuilder: (context, index) {
              MountModel currentMount = mountItems[index];

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailsScreen(currentMount)));
                },
                child: Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(10),
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: NetworkImage(currentMount.path),
                            fit: BoxFit.cover)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(currentMount.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Text(currentMount.location,
                              style: const TextStyle(color: Colors.white))
                        ])),
              );
            }));
  }
}

class AppCategoryList extends StatelessWidget {
  const AppCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Category',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  Text('See More',
                      style: TextStyle(
                          color: mainColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ])),
        Container(
            height: 100,
            margin: const EdgeInsets.only(left: 10),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  CategoryModel currentCategory = categories[index];

                  return Container(
                      width: 100,
                      margin: const EdgeInsets.only(top: 10, right: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.2), width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(currentCategory.icon, color: mainColor),
                            Text(currentCategory.category,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold))
                          ]));
                })),
      ],
    );
  }
}

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({super.key});

  @override
  AppBottomBarState createState() => AppBottomBarState();
}

class AppBottomBarState extends State<AppBottomBar> {
  List<AppBottomBarItem> barItems = [
    AppBottomBarItem(icon: Icons.home, label: 'Home', isSelected: true),
    AppBottomBarItem(icon: Icons.explore, label: 'Explore', isSelected: false),
    AppBottomBarItem(
        icon: Icons.turned_in_not, label: 'Tag', isSelected: false),
    AppBottomBarItem(
        icon: Icons.person_outline, label: 'Profile', isSelected: false)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset.zero)
        ]),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(barItems.length, (index) {
              AppBottomBarItem currentBarItem = barItems[index];
              Widget barItemWidget;

              if (currentBarItem.isSelected) {
                barItemWidget = Container(
                    padding:
                        const EdgeInsets.only(left: 15, top: 5, bottom: 5, right: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: mainColor),
                    child: Row(children: [
                      Icon(currentBarItem.icon, color: Colors.white),
                      const SizedBox(width: 5),
                      Text(currentBarItem.label,
                          style: const TextStyle(color: Colors.white))
                    ]));
              } else {
                barItemWidget = IconButton(
                    icon: Icon(currentBarItem.icon, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        for (var item in barItems) {
                          item.isSelected = item == currentBarItem;
                        }
                      });
                    });
              }
              return barItemWidget;
            })));
  }
}
