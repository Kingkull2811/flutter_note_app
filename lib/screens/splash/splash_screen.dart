import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../routes.dart';
import '../../util/app_theme.dart';
import '../../util/shared_preferences_storage.dart';
import '../../widgets/button.dart';
import 'splash_notifier.dart';

class SplashScreen extends StatefulHookConsumerWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(splashStateNotifier);

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 34),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            PageView(
              scrollDirection: Axis.horizontal,
              reverse: false,
              onPageChanged: (index) {
                ref.read(splashStateNotifier.notifier).changePage(index);
              },
              controller: pageController,
              pageSnapping: true,
              physics: const ClampingScrollPhysics(),
              children: [
                pageView(
                  context,
                  'title of page 1',
                  'content of page 1',
                  'images/image_1.jpg',
                  1,
                  'Next',
                ),
                pageView(
                  context,
                  'title of page 2',
                  'content of page 2',
                  'images/image_1.jpg',
                  2,
                  'Next',
                ),
                pageView(
                  context,
                  'title of page 3',
                  'content of page 3',
                  'images/image_1.jpg',
                  3,
                  'Get started',
                ),
              ],
            ),
            Positioned(
              bottom: 150,
              child: DotsIndicator(
                mainAxisAlignment: MainAxisAlignment.center,
                reversed: false,
                dotsCount: 3,
                position: state.page.toDouble(),
                decorator: DotsDecorator(
                  color: AppColor.linkWater,
                  activeColor: AppColor.midGrey,
                  size: const Size.square(10.0),
                  activeSize: const Size(18.0, 10.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pageView(
    BuildContext context,
    String title,
    String content,
    String imageUrl,
    int index,
    String buttonLabel,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 345,
          width: 345,
          alignment: Alignment.center,
          child: Image.asset(
            imageUrl,
            fit: BoxFit.contain,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Text(
            content,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                ),
          ),
        ),
        const Spacer(),
        buildButton(context, index, buttonLabel),
      ],
    );
  }

  Widget buildButton(BuildContext context, int index, String buttonLabel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(64, 16, 64, 48),
      child: PrimaryButton(
        width: MediaQuery.of(context).size.width,
        text: buttonLabel,
        onTap: () async {
          if (index < 3) {
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.ease,
            );
          } else {
            //set first time open app & navigate to login screen
            await SharedPreferencesStorage().setFirstTimeOpenApp(true);
            Navigator.pushNamedAndRemoveUntil(
              this.context,
              AppRoute.auth,
              (route) => false,
            );
          }
        },
      ),
    );
  }
}
