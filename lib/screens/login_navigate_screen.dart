import 'package:flutter/material.dart';

import '../services/email_store.dart';

class LoginNavigateScreen extends StatefulWidget {
  const LoginNavigateScreen({super.key});

  @override
  State<LoginNavigateScreen> createState() =>
      _LoginNavigateScreenState();
}

class _LoginNavigateScreenState
    extends State<LoginNavigateScreen> {
  final TextEditingController emailController =
      TextEditingController(
    text: 'alshirin1155@gmail.com',
  );

  // ===============================================================
  // COLORS
  // ===============================================================

  static const Color backgroundColor = Color(0xFF121212);
  static const Color cardColor = Color(0xFF1B1B1B);
  // borderColor removed (unused)
  static const Color spotifyGreen = Color(0xFF1ED760);

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> _onContinue() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email address.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final isRegistered = await EmailStore.hasEmail(email);

    if (!isRegistered) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This email is not registered. Please sign up first.'),
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pushReplacementNamed(context, '/signup');
      return;
    }

    await EmailStore.setCurrentUser(email);

    if (!mounted) return;
    Navigator.pushNamed(context, '/onboarding');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final horizontalPadding =
        size.width >= 600 ? 60.0 : 24.0;

    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // =====================================================
                // HEADER
                // =====================================================

                const SizedBox(height: 20),

                Row(
                  children: [

                    // Back Button
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },

                      child: Container(
                        width: 46,
                        height: 46,

                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 21,
                        ),
                      ),
                    ),

                    // Center title
                    Expanded(
                      child: Center(
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 5.5,
                          ),
                        ),
                      ),
                    ),

                    // Balance the back button
                    const SizedBox(width: 46),
                  ],
                ),

                // =====================================================
                // EMAIL
                // =====================================================

                const SizedBox(height: 70),

                const Text(
                  'Email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),

                const SizedBox(height: 16),

                // =====================================================
                // EMAIL FIELD
                // =====================================================

                Container(
                  width: double.infinity,
                  height: 64,

                  decoration: BoxDecoration(
                    color: cardColor,

                    borderRadius:
                        BorderRadius.circular(18),

                    border: Border.all(
                      color: Colors.white.withOpacity(0.70),
                      width: 1.3,
                    ),
                  ),

                  child: TextField(
                    controller: emailController,

                    keyboardType:
                        TextInputType.emailAddress,

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),

                    cursorColor: spotifyGreen,

                    decoration: const InputDecoration(
                      border: InputBorder.none,

                      contentPadding:
                          EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 19,
                      ),
                    ),
                  ),
                ),

                // =====================================================
                // CONTINUE
                // =====================================================

                const SizedBox(height: 18),

                SizedBox(
                  width: double.infinity,
                  height: 62,

                  child: ElevatedButton(
                    onPressed: _onContinue,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: spotifyGreen,
                      foregroundColor: Colors.black,

                      elevation: 0,

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(32),
                      ),
                    ),

                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),

                // =====================================================
                // OR LOGIN WITH
                // =====================================================

                const SizedBox(height: 58),

                Center(
                  child: const Text(
                    'Or log in with',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.5,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // =====================================================
                // PHONE NUMBER
                // =====================================================

                const _SocialLoginButton(
                  icon: Icons.phone_android_rounded,
                  text: 'Continue with phone number',
                  iconSize: 30,
                  route: '/onboarding',
                ),

                const SizedBox(height: 14),

                // =====================================================
                // GOOGLE
                // =====================================================

                const _SocialLoginButton(
                  icon: Icons.g_mobiledata_rounded,
                  text: 'Continue with Google',
                  iconSize: 43,
                  route: '/onboarding',
                ),

                const SizedBox(height: 14),

                // =====================================================
                // FACEBOOK
                // =====================================================

                const _SocialLoginButton(
                  icon: Icons.facebook_rounded,
                  text: 'Continue with Facebook',
                  iconSize: 30,
                  route: '/onboarding',
                ),

                const SizedBox(height: 14),

                // =====================================================
                // APPLE
                // =====================================================

                const _SocialLoginButton(
                  icon: Icons.apple,
                  text: 'Continue with Apple',
                  iconSize: 34,
                  route: '/onboarding',
                ),

                const SizedBox(height: 35),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// ===================================================================
// SOCIAL LOGIN BUTTON
// ===================================================================

class _SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final double iconSize;
  final String route;

  const _SocialLoginButton({
    required this.icon,
    required this.text,
    this.iconSize = 34,
    this.route = '/onboarding',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,

      child: OutlinedButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            route,
          );
        },

        style: OutlinedButton.styleFrom(
          backgroundColor:
              const Color(0xFF1B1B1B),

          side: const BorderSide(
            color: Color(0xFF414141),
            width: 1.2,
          ),

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(30),
          ),

          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
        ),

        child: Row(
          children: [

            // -------------------------------------------------------
            // ICON
            // -------------------------------------------------------

            SizedBox(
              width: 48,

              child: Center(
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: iconSize,
                ),
              ),
            ),

            const SizedBox(width: 8),

            // -------------------------------------------------------
            // TEXT
            // -------------------------------------------------------

            Expanded(
              child: Text(
                text,

                maxLines: 1,
                overflow: TextOverflow.ellipsis,

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}