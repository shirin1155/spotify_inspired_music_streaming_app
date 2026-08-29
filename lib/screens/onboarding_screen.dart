import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() =>
      _OnBoardingScreenState();
}

class _OnBoardingScreenState
    extends State<OnBoardingScreen> {

  final PageController _pageController =
      PageController();

  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Discover\nnew music',
      'subtitle':
          'Personalized recommendation\npicked just for you',
      'image':
          'assets/images/onboarding/onboarding1.png',
    },

    {
      'title': 'Play your\nfavourites',
      'subtitle':
          'Listen anytime,anywhere\nwith comfortable player',
      'image':
          'assets/images/onboarding/onboarding2.png',
    },

    {
      'title': 'Create & Share\nplaylists',
      'subtitle':
          'Make playlists for every mood\n& share with friends',
      'image':
          'assets/images/onboarding/onboarding3.png',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration:
            const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    } else {
      _goToHome();
    }
  }

  void _skip() {
    _goToHome();
  }

  void _goToHome() {
    Navigator.pushReplacementNamed(
      context,
      '/home',
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor:
          const Color(0xFF121212),

      body: SafeArea(
        child: Column(
          children: [

            // =====================================================
            // PAGE CONTENT
            // =====================================================

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,

                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },

                itemBuilder: (context, index) {
                  final page = _pages[index];

                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),

                    child: Column(
                      children: [

                        SizedBox(
                          height:
                              size.height * 0.09,
                        ),

                        // ================================
                        // TITLE
                        // ================================

                        Text(
                          page['title']!,
                          textAlign: TextAlign.center,

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 46,
                            fontWeight:
                                FontWeight.w700,
                            letterSpacing: 2,
                            height: 1.3,
                          ),
                        ),

                        const SizedBox(height: 42),

                        // ================================
                        // SUBTITLE
                        // ================================

                        Text(
                          page['subtitle']!,
                          textAlign: TextAlign.center,

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight:
                                FontWeight.w600,
                            letterSpacing: 4,
                            height: 1.8,
                          ),
                        ),

                        const SizedBox(height: 40),

                        // ================================
                        // IMAGE
                        // ================================

                        Expanded(
                          child: Image.asset(
                            page['image']!,

                            fit: BoxFit.contain,

                            errorBuilder:
                                (
                                  context,
                                  error,
                                  stackTrace,
                                ) {
                              return const Icon(
                                Icons
                                    .headphones_rounded,
                                color:
                                    Color(0xFF1ED760),
                                size: 180,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // =====================================================
            // BOTTOM CONTROLS
            // =====================================================

            Padding(
              padding:
                  const EdgeInsets.fromLTRB(
                30,
                10,
                30,
                28,
              ),

              child: Row(
                children: [

                  // ================================
                  // SKIP
                  // ================================

                  GestureDetector(
                    onTap: _skip,

                    child: const SizedBox(
                      width: 80,
                      child: Text(
                        'Skip',

                        style: TextStyle(
                          color:
                              Color(0xFF777777),
                          fontSize: 17,
                          fontWeight:
                              FontWeight.w600,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
                  ),

                  // ================================
                  // PAGE INDICATORS
                  // ================================

                  Expanded(
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,

                      children: List.generate(
                        3,
                        (index) {
                          final active =
                              index ==
                                  _currentPage;

                          return AnimatedContainer(
                            duration:
                                const Duration(
                              milliseconds: 250,
                            ),

                            margin:
                                const EdgeInsets
                                    .symmetric(
                              horizontal: 7,
                            ),

                            width:
                                active ? 16 : 12,

                            height:
                                active ? 16 : 12,

                            decoration:
                                BoxDecoration(
                              shape:
                                  BoxShape.circle,

                              color: active
                                  ? Colors.white
                                  : const Color(
                                      0xFF666666,
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // ================================
                  // NEXT / START
                  // ================================

                  GestureDetector(
                    onTap: _nextPage,

                    child: SizedBox(
                      width: 80,

                      child: Text(
                        _currentPage == 2
                            ? 'Start'
                            : 'Next',

                        textAlign:
                            TextAlign.right,

                        style: const TextStyle(
                          color:
                              Color(0xFF1ED760),
                          fontSize: 17,
                          fontWeight:
                              FontWeight.w700,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}