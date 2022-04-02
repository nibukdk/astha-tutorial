import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:temple/globals/providers/app_state_provider.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

void onSubmitDone(AppStateProvider stateProvider, BuildContext context) {
  // When user pressed skip/done button we'll finally set onboardCount integer
  stateProvider.hasOnboarded();
  // After that onboard state is done we'll go to homepage.
  GoRouter.of(context).go("/");
}

class _OnBoardScreenState extends State<OnBoardScreen> {
// Create a private index to track image index
  int _currentImgIndex = 0;

// Create list with images to use while onboarding
  // #2
  final onBoardScreenImages = [
    "assets/onboard/FindTemples.png",
    "assets/onboard/FindVenues.png",
    "assets/onboard/FindTemples.png",
    "assets/onboard/FindVenues.png",
  ];

// Function to display next image in the list when next button  is clicked
  void nextImage() {
    if (_currentImgIndex < onBoardScreenImages.length - 1) {
      setState(() => _currentImgIndex += 1);
    }
  }

// Function to display previous image in the list when previous button  is clicked
  void prevImage() {
    if (_currentImgIndex > 0) {
      setState(() => _currentImgIndex -= 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appStateProvider = Provider.of<AppStateProvider>(context);
    return Scaffold(
        body: SafeArea(
            child: Container(
                color: const Color.fromARGB(255, 255, 209, 166),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    // Animated switcher class to animated between images
                    // #4
                    AnimatedSwitcher(
                      switchInCurve: Curves.easeInOut,
                      switchOutCurve: Curves.easeOut,
                      transitionBuilder: ((child, animation) =>
                          ScaleTransition(scale: animation, child: child)),
                      duration: const Duration(milliseconds: 800),
                      child: Image.asset(
                        onBoardScreenImages[_currentImgIndex],
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: double.infinity,
                        // Key is needed since widget type is same i.e Image
                        key: ValueKey<int>(_currentImgIndex),
                      ),
                    ),
                    // Container to that contains set butotns
                    // #5
                    Container(
                        color: Colors.black26,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              // Change visibility by currentImgIndex
                              onPressed: prevImage,
                              icon: _currentImgIndex == 0
                                  ? const Icon(null)
                                  : const Icon(Icons.arrow_back),
                            ),
                            IconButton(
                              // Change visibility by currentImgIndex
                              onPressed: _currentImgIndex ==
                                      onBoardScreenImages.length - 1
                                  ? () =>
                                      onSubmitDone(appStateProvider, context)
                                  : nextImage,
                              icon: _currentImgIndex ==
                                      onBoardScreenImages.length - 1
                                  ? const Icon(Icons.done)
                                  : const Icon(Icons.arrow_forward),
                            )
                          ],
                        ))
                  ],
                ))));
  }
}
