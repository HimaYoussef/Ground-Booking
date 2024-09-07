import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/auth/presentation/View/sign_in_view.dart';
import 'package:pitch_test/features/on_boarding/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  var pageController = PageController();
  int curruntPage = 0;

  List<OnboardingModel> pages = [
    OnboardingModel(
        image: 'assets/OnBoarding1.png',
        title: 'Booking different courts',
        desc:
            'The application brings together all of the different sports stadiums, allowing you to choose what works best for you in terms of stadium and time'),
    OnboardingModel(
        image: 'assets/OnBoarding2.png',
        title: 'Offers group',
        desc:
            'Many bundled offers are applied for people who always book continuously and receive points for each booking.'),
    OnboardingModel(
        image: 'assets/OnBoarding3.png',
        title: 'rating & find partner',
        desc:
            'Find out all the impartial reviews of flooring and its workers, and also find a partner for me to play in an easy way'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: PageView.builder(
            controller: pageController,
            itemCount: pages.length,
            onPageChanged: (value) {
              setState(() {
                curruntPage = value;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(
                    pages[index].image,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.contain,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()));
                        },
                        child: Text(
                          textAlign: TextAlign.center,
                          'Skip',
                          style: getbodyStyle(color: AppColors.color1),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    pages[index].title,
                    style: getTitleStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),
                  ),
                  const Gap(15),
                  Text(
                    pages[index].desc,
                    textAlign: TextAlign.center,
                    style: getbodyStyle(),
                    
                  ),
                  const Spacer(),
                ],
              );
            },
          )),
          Padding(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              height: 100,
              child: Column(
                children: [
                  SmoothPageIndicator(
                      onDotClicked: (index) {
                        pageController.animateToPage(index,
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.linear);
                      },
                      effect: SlideEffect(
                          dotColor: AppColors.color1,
                          activeDotColor: AppColors.color2),
                      controller: pageController,
                      count: 3),
                  Gap(20),
                  if (curruntPage == pages.length - 1)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.color1,
                              foregroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const LoginView(),
                            ));
                          },
                          child: const Text('Get started')),
                    )
                  else
                    (SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.color1,
                              foregroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            pageController.animateToPage(curruntPage + 1,
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.linear);
                          },
                          child: const Text('Next')),
                    ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
