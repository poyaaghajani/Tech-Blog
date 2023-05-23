import 'package:flutter/material.dart';
import 'package:tech_blog/component/my_colors.dart';
import 'package:tech_blog/component/my_strings.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/models/data_models.dart';
import 'package:tech_blog/utils/default_physics.dart';
import 'package:tech_blog/utils/devise_size.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.textTheme,
    required this.bodyMargin,
  });

  final TextTheme textTheme;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: defaultPhysics,
      child: Column(
        children: [
          SizedBox(height: DeviseSize.getHeight(context) / 90),

          // home poster
          HomePoster(textTheme: textTheme),

          SizedBox(height: DeviseSize.getHeight(context) / 40),

          // hashtags
          Hashtags(bodyMargin: bodyMargin, textTheme: textTheme),

          SizedBox(height: DeviseSize.getHeight(context) / 12),

          Padding(
            padding: EdgeInsets.only(right: bodyMargin),
            child: Row(
              children: [
                Assets.icons.bluePen.image(height: 20),
                const SizedBox(width: 8),
                Text(
                  MySctrings.viewHotestBlog,
                  style: textTheme.displaySmall,
                ),
              ],
            ),
          ),

          // hotest blogs
          HotestBlogs(bodyMargin: bodyMargin, textTheme: textTheme),

          SizedBox(height: DeviseSize.getHeight(context) / 16),

          Padding(
            padding: EdgeInsets.only(right: bodyMargin),
            child: Row(
              children: [
                Assets.icons.microphon.image(height: 20),
                const SizedBox(width: 8),
                Text(
                  MySctrings.viewHotestPodCasts,
                  style: textTheme.displaySmall,
                ),
              ],
            ),
          ),

          // hotest podcast
          HotestPodcast(bodyMargin: bodyMargin),
        ],
      ),
    );
  }
}

class HotestPodcast extends StatelessWidget {
  const HotestPodcast({
    super.key,
    required this.bodyMargin,
  });

  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
        bottom: DeviseSize.getHeight(context) / 12,
      ),
      height: DeviseSize.getHeight(context) / 4,
      child: ListView.builder(
        physics: defaultPhysics,
        padding: EdgeInsets.only(right: bodyMargin),
        itemCount: blogList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                width: DeviseSize.getWidth(context) / 2.4,
                height: DeviseSize.getHeight(context) / 5.3,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            blogList[index].imageUrl,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 4),
                child: SizedBox(
                  width: DeviseSize.getWidth(context) / 2.4,
                  child: Text(
                    blogList[index].writer,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class HotestBlogs extends StatelessWidget {
  const HotestBlogs({
    super.key,
    required this.bodyMargin,
    required this.textTheme,
  });

  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      height: DeviseSize.getHeight(context) / 3.9,
      child: ListView.builder(
        physics: defaultPhysics,
        padding: EdgeInsets.only(right: bodyMargin),
        itemCount: blogList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                width: DeviseSize.getWidth(context) / 2.4,
                height: DeviseSize.getHeight(context) / 5.3,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            blogList[index].imageUrl,
                          ),
                        ),
                      ),
                      foregroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: GradientColors.blogPost,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            blogList[index].writer,
                            style: textTheme.titleMedium,
                          ),
                          Row(
                            children: [
                              Text(
                                blogList[index].views,
                                style: textTheme.titleMedium,
                              ),
                              SizedBox(
                                  width: DeviseSize.getWidth(context) / 100),
                              const Icon(
                                Icons.remove_red_eye_sharp,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: DeviseSize.getWidth(context) / 2.4,
                  child: Text(
                    blogList[index].title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Hashtags extends StatelessWidget {
  const Hashtags({
    super.key,
    required this.bodyMargin,
    required this.textTheme,
  });

  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
        physics: defaultPhysics,
        padding: EdgeInsets.only(right: bodyMargin),
        itemCount: tagList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.only(left: 12),
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
                  SizedBox(width: DeviseSize.getWidth(context) / 60),
                  Text(
                    tagList[index].title,
                    style: textTheme.displayLarge,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomePoster extends StatelessWidget {
  const HomePoster({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: DeviseSize.getWidth(context) / 1.25,
          height: DeviseSize.getHeight(context) / 4.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Assets.images.posterTest.provider(),
            ),
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: GradientColors.homePosterCoverGradiant,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'پویا آقاجانی - یک روز پیش',
                  style: textTheme.titleMedium,
                ),
                Row(
                  children: [
                    Text(
                      '253',
                      style: textTheme.titleMedium,
                    ),
                    SizedBox(width: DeviseSize.getWidth(context) / 100),
                    const Icon(
                      Icons.remove_red_eye_sharp,
                      color: Colors.white,
                    )
                  ],
                ),
              ],
            ),
            Text(
              'دوارزده قدم برنامه نویسی....',
              style: textTheme.displayLarge,
            ),
            SizedBox(height: DeviseSize.getHeight(context) / 200),
          ],
        )
      ],
    );
  }
}
