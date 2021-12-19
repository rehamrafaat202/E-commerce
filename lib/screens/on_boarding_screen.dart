import 'package:flutter/material.dart';
import 'package:shop_app/models/page_veiw_model.dart';
import '../widgets/shared/network/local/shared_preference.dart';
import 'package:shop_app/screens/login_page_screen.dart';
import 'package:shop_app/styles/colors.dart';
import 'package:shop_app/widgets/shared/components/shared_component.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  void submit() {
    CashHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navagateToAndReplace(context, const LoginPageScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var boardingController = PageController();
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: const Text("SKIP"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardingController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  print(index);
                  if (index == items.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    defaultBoardingPage(items[index]),
                itemCount: items.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    effect: const ExpandingDotsEffect(
                        dotHeight: 10,
                        activeDotColor: defaultColor,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5.0),
                    controller: boardingController,
                    count: items.length),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    }
                    boardingController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn);
                  },
                  child: const Icon(Icons.arrow_forward),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
