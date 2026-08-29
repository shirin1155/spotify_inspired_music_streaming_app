import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // ===============================================================
  // COLORS
  // ===============================================================

  static const Color backgroundColor = Color(0xFF121212);
  static const Color greenColor = Color(0xFF1ED760);
  static const Color pinkColor = Color(0xFFD9B0B0);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Responsive horizontal padding
    final horizontalPadding =
        size.width >= 600 ? 60.0 : 38.0;

    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ),

            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),

              child: IntrinsicHeight(
                child: Column(
                  children: [

                    // =================================================
                    // TOP SPACE
                    // =================================================

                    SizedBox(
                      height: size.height * 0.12,
                    ),

                    // =================================================
                    // SPOTIFY LOGO
                    // =================================================

                    Container(
                      width: 150,
                      height: 150,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        boxShadow: [
                          BoxShadow(
                            color: greenColor.withOpacity(0.10),
                            blurRadius: 35,
                            spreadRadius: 5,
                          ),
                        ],
                      ),

                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),

                    // =================================================
                    // GAP AFTER LOGO
                    // =================================================

                    SizedBox(
                      height: size.height * 0.065,
                    ),

                    // =================================================
                    // SLOGAN
                    // =================================================

                    _buildSlogan(),

                    // =================================================
                    // SPACE
                    // =================================================

                    const Spacer(),

                    // =================================================
                    // SIGN UP BUTTON
                    // =================================================

                    _PrimaryButton(
                      text: 'Sign up for free',
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/signup',
                        );
                      },
                    ),

                    // =================================================
                    // GAP
                    // =================================================

                    const SizedBox(height: 14),

                    // =================================================
                    // LOGIN BUTTON
                    // =================================================

                    _SecondaryButton(
                      text: 'Log in',
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/login',
                        );
                      },
                    ),

                    // =================================================
                    // BOTTOM SPACE
                    // =================================================

                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===============================================================
  // SLOGAN
  // ===============================================================

  Widget _buildSlogan() {
    return Column(
      children: [

        RichText(
          textAlign: TextAlign.center,

          text: const TextSpan(
            children: [

              TextSpan(
                text: 'Feel the ',
                style: TextStyle(
                  color: pinkColor,
                  fontSize: 39,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.5,
                ),
              ),

              TextSpan(
                text: 'music',
                style: TextStyle(
                  color: greenColor,
                  fontSize: 39,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.5,
                ),
              ),

              TextSpan(
                text: '.',
                style: TextStyle(
                  color: pinkColor,
                  fontSize: 39,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 5),

        const Text(
          'Live the moment.',
          textAlign: TextAlign.center,

          style: TextStyle(
            color: pinkColor,
            fontSize: 39,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.5,
          ),
        ),
      ],
    );
  }
}


// ===================================================================
// PRIMARY BUTTON
// ===================================================================

class _PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _PrimaryButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 62,

      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor:
              const Color(0xFF1ED760),

          foregroundColor: Colors.black,

          elevation: 0,

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(32),
          ),
        ),

        child: const Text(
          'Sign up for free',

          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.5,
          ),
        ),
      ),
    );
  }
}


// ===================================================================
// SECONDARY BUTTON
// ===================================================================

class _SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _SecondaryButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 62,

      child: OutlinedButton(
        onPressed: onPressed,

        style: OutlinedButton.styleFrom(
          backgroundColor:
              Colors.transparent,

          foregroundColor: Colors.white,

          side: BorderSide(
            color: Colors.white.withOpacity(0.85),
            width: 1.3,
          ),

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(32),
          ),
        ),

        child: const Text(
          'Log in',

          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.5,
          ),
        ),
      ),
    );
  }
}