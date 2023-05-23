import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_blog/component/my_colors.dart';
import 'package:tech_blog/component/my_strings.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/models/data_models.dart';
import 'package:tech_blog/utils/default_physics.dart';
import 'package:tech_blog/utils/devise_size.dart';

class MyCategories extends StatefulWidget {
  const MyCategories({super.key});

  @override
  State<MyCategories> createState() => _MyCategoriesState();
}

class _MyCategoriesState extends State<MyCategories> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var bodyMargin = DeviseSize.getWidth(context) / 11;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: bodyMargin),
          child: Center(
            child: SingleChildScrollView(
              physics: defaultPhysics,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.images.tcbot
                      .svg(height: DeviseSize.getHeight(context) / 5),
                  SizedBox(height: DeviseSize.getHeight(context) / 50),
                  Text(
                    MySctrings.successfulRegistration,
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: 'نام و خانوادگی',
                    ),
                  ),
                  SizedBox(height: DeviseSize.getHeight(context) / 40),
                  Text(
                    MySctrings.chooseCats,
                    style: textTheme.headlineMedium,
                  ),
                  SizedBox(height: DeviseSize.getHeight(context) / 30),
                  SizedBox(
                    width: DeviseSize.getWidth(context),
                    height: 100,
                    child: GridView.builder(
                      physics: defaultPhysics,
                      scrollDirection: Axis.horizontal,
                      itemCount: tagList.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 0.3,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (!myCats.contains(tagList[index])) {
                                myCats.add(
                                  tagList[index],
                                );
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: const LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: GradientColors.tags,
                              ),
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  Assets.icons.hashtagicon.image(height: 18),
                                  SizedBox(
                                      width: DeviseSize.getWidth(context) / 60),
                                  Text(
                                    tagList[index].title,
                                    style: textTheme.displayLarge,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: DeviseSize.getHeight(context) / 80),
                  Assets.icons.downCatArrow.image(height: 50),
                  SizedBox(height: DeviseSize.getHeight(context) / 50),
                  SizedBox(
                    width: DeviseSize.getWidth(context),
                    height: 100,
                    child: GridView.builder(
                      physics: defaultPhysics,
                      scrollDirection: Axis.horizontal,
                      itemCount: myCats.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 0.3,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: SolidColors.surface,
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      myCats.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.delete,
                                    color: SolidColors.greyColor,
                                  ),
                                ),
                                Text(
                                  myCats[index].title,
                                  style: textTheme.headlineMedium,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: DeviseSize.getHeight(context) / 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('ادامه'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
