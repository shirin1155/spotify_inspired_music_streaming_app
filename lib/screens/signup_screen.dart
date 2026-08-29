import 'package:flutter/material.dart';

import '../services/email_store.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Colors
  static const Color background = Color(0xFF121212);
  static const Color cardColor = Color(0xFF1B1B1B);
  static const Color borderColor = Color(0xFF414141);
  static const Color spotifyGreen = Color(0xFF1ED760);

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _saveEnteredEmail() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();

    if (name.isNotEmpty) {
      await EmailStore.saveName(name);
    }

    if (email.isEmpty) return;
    if (!email.contains('@') || !email.contains('.')) {
      return;
    }

    await EmailStore.saveEmail(email);
  }

  Future<void> _onNext() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your name.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email address.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    await EmailStore.saveEmail(email);
    await EmailStore.saveName(name);
    await EmailStore.setCurrentUser(email);

    if (!mounted) return;

    Navigator.pushNamed(context, '/onboarding');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            // Responsive horizontal padding
            final horizontalPadding = width > 600 ? 70.0 : 24.0;

            return SingleChildScrollView(
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

                    SizedBox(
                      height: 64,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
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
                      ),
                    ),

                    const SizedBox(height: 30),

                    // =====================================================
                    // TITLE
                    // =====================================================

                    Center(
                      child: Column(
                        children: [
                          _titleText(
                            'Sign up to',
                            fontSize: 28,
                          ),

                          const SizedBox(height: 8),

                          _titleText(
                            'start listening',
                            fontSize: 28,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 60),

                    _sectionTitle('Your name'),

                    const SizedBox(height: 16),

                    Container(
                      height: 64,
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.7),
                          width: 1.3,
                        ),
                      ),
                      child: TextField(
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                        cursorColor: spotifyGreen,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.35),
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: Colors.white.withOpacity(0.5),
                            size: 22,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 19,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    _sectionTitle('Email address'),

                    const SizedBox(height: 16),

                    Container(
                      height: 64,
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.7),
                          width: 1.3,
                        ),
                      ),
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                        cursorColor: spotifyGreen,
                        decoration: InputDecoration(
                          hintText: 'Email address',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.35),
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.white.withOpacity(0.5),
                            size: 22,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 19,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // =====================================================
                    // NEXT BUTTON
                    // =====================================================

                    SizedBox(
                      width: double.infinity,
                      height: 62,
                      child: ElevatedButton(
                        onPressed: _onNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: spotifyGreen,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 42),

                    // =====================================================
                    // OR DIVIDER
                    // =====================================================

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.white.withOpacity(0.12),
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: Text(
                            'Or',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.white.withOpacity(0.12),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // =====================================================
                    // GOOGLE
                    // =====================================================

                    _socialButton(
                      icon: _googleIcon(),
                      text: 'Continue with Google',
                      onTap: () async {
                        await _saveEnteredEmail();
                        if (!mounted) return;
                        Navigator.pushNamed(
                          context,
                          '/onboarding',
                        );
                      },
                    ),

                    const SizedBox(height: 14),

                    // =====================================================
                    // APPLE
                    // =====================================================

                    _socialButton(
                      icon: const Icon(
                        Icons.apple,
                        color: Colors.white,
                        size: 29,
                      ),
                      text: 'Continue with Apple',
                      onTap: () async {
                        await _saveEnteredEmail();
                        if (!mounted) return;
                        Navigator.pushNamed(
                          context,
                          '/onboarding',
                        );
                      },
                    ),

                    const SizedBox(height: 58),

                    // =====================================================
                    // LOGIN
                    // =====================================================

                    Center(
                      child: Column(
                        children: [
                          const Text(
                            'Already have an account?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 14),

                          TextButton(
                            onPressed: () {
                              // Navigate to Login
                              Navigator.pushReplacementNamed(
                              context,
                               '/login',
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 8,
                              ),
                            ),
                            child: const Text(
                              'Log in',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                                decorationThickness: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 35),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ===============================================================
  // TITLE TEXT
  // ===============================================================

  Widget _titleText(
    String text, {
    double fontSize = 28,
  }) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        letterSpacing: 5.5,
      ),
    );
  }

  // ===============================================================
  // SECTION TITLE
  // ===============================================================

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
      ),
    );
  }

  // ===============================================================
  // SOCIAL BUTTON
  // ===============================================================

  Widget _socialButton({
    required Widget icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: cardColor,
          side: const BorderSide(
            color: borderColor,
            width: 1.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 42,
              child: Center(
                child: icon,
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
            ),

            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Colors.white.withOpacity(0.35),
            ),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // GOOGLE ICON
  // ===============================================================

  Widget _googleIcon() {
    return const Text(
      'G',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    );
  }

}