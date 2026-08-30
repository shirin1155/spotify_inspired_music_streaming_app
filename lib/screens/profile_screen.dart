import 'package:flutter/material.dart';

import '../services/email_store.dart';
import 'home_screen.dart';
import '../utils/responsive.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    this.showBottomNavigationBar = false,
  });

  final bool showBottomNavigationBar;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // =========================================================
  // DATA SAVER STATE
  // =========================================================

  bool dataSaverEnabled = true;

  bool showNotification = false;
  int selectedBottomNavIndex = 3;

  String notificationTitle = '';
  String notificationSubtitle = '';
  String profileName = 'USER';

  @override
  void initState() {
    super.initState();
    _loadProfileName();
  }

  Future<void> _loadProfileName() async {
    final currentEmail = await EmailStore.getCurrentUserEmail();
    final name = currentEmail.isEmpty
        ? await EmailStore.getName()
        : await EmailStore.getNameForEmail(currentEmail);

    if (!mounted) return;

    setState(() {
      profileName = name.toUpperCase();
    });
  }

  // =========================================================
  // DATA SAVER TOGGLE
  // =========================================================

  void _toggleDataSaver() {
    setState(() {
      dataSaverEnabled = !dataSaverEnabled;

      if (dataSaverEnabled) {
        notificationTitle = 'Data Saver is ON';
        notificationSubtitle = 'Mobile data usage will be reduced';
      } else {
        notificationTitle = 'Data Saver is OFF';
        notificationSubtitle = 'Full quality streaming is enabled';
      }

      showNotification = true;
    });

    // Hide notification automatically
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      setState(() {
        showNotification = false;
      });
    });
  }

  // =========================================================
  // SIMPLE MESSAGE
  // =========================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color(0xFF292929),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // =========================================================
  // LOGOUT DIALOG
  // =========================================================

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFF202020),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  width: R.w(context, 58),
                  height: R.w(context, 58),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.logout_rounded,
                    color: Colors.redAccent,
                    size: R.w(context, 27),
                  ),
                ),

                SizedBox(height: R.h(context, 18)),

                Text(
                  'Log out?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: R.sp(context, 21),
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: R.h(context, 8)),

                Text(
                  'Are you sure you want to log out from your account?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: R.sp(context, 13),
                    height: 1.5,
                  ),
                ),

                SizedBox(height: R.h(context, 24)),

                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil(
                            '/',
                            (route) => false,
                          );
                        },
                        child: Container(
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Text(
                            'Log out',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  // NORMAL SETTING TILE
  // =========================================================

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: const Color(0xFF1ED760).withOpacity(0.08),
        highlightColor: Colors.white.withOpacity(0.025),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF1B1B1B),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.045),
            ),
          ),
          child: Row(
            children: [
              // Icon box
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFF282828),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 22,
                ),
              ),

              const SizedBox(width: 14),

              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: R.h(context, 4)),

                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: R.sp(context, 13),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: R.w(context, 10)),

              const SizedBox(width: 10),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white38,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // DATA SAVER TILE
  // =========================================================

  Widget _buildDataSaverTile() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _toggleDataSaver,
        borderRadius: BorderRadius.circular(20),
        splashColor: const Color(0xFF1ED760).withOpacity(0.08),
        highlightColor: Colors.white.withOpacity(0.025),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF1B1B1B),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: dataSaverEnabled
                  ? const Color(0xFF1ED760).withOpacity(0.20)
                  : Colors.white.withOpacity(0.045),
            ),
          ),
          child: Row(
            children: [
              // DATA SAVER ICON
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: dataSaverEnabled
                      ? const Color(0xFF1ED760).withOpacity(0.13)
                      : const Color(0xFF282828),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  dataSaverEnabled
                      ? Icons.data_saver_on_rounded
                      : Icons.data_saver_off_rounded,
                  color: dataSaverEnabled
                      ? const Color(0xFF1ED760)
                      : Colors.white60,
                  size: 22,
                ),
              ),

              const SizedBox(width: 14),

              // TITLE + SUBTITLE
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Data Saver',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: Text(
                        dataSaverEnabled
                            ? 'Saving mobile data'
                            : 'Using normal data',
                        key: ValueKey(dataSaverEnabled),
                        style: TextStyle(
                          color: dataSaverEnabled
                              ? const Color(0xFF1ED760)
                              : Colors.white38,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // CUSTOM SWITCH
              GestureDetector(
                onTap: _toggleDataSaver,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  width: 54,
                  height: 31,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: dataSaverEnabled
                        ? const Color(0xFF1ED760)
                        : const Color(0xFF3A3A3A),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    alignment: dataSaverEnabled
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.30),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // TOP DATA SAVER NOTIFICATION
  // =========================================================

  Widget _buildDataSaverNotification() {
    return IgnorePointer(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: showNotification ? 1 : 0,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
          scale: showNotification ? 1 : 0.90,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 13,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF242424),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: dataSaverEnabled
                    ? const Color(0xFF1ED760).withOpacity(0.30)
                    : Colors.white.withOpacity(0.10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.40),
                  blurRadius: 22,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                // Notification icon
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: dataSaverEnabled
                        ? const Color(0xFF1ED760).withOpacity(0.13)
                        : Colors.white.withOpacity(0.07),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    dataSaverEnabled
                        ? Icons.data_saver_on_rounded
                        : Icons.data_saver_off_rounded,
                    color: dataSaverEnabled
                        ? const Color(0xFF1ED760)
                        : Colors.white70,
                    size: 21,
                  ),
                ),

                const SizedBox(width: 12),

                // Notification text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notificationTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        notificationSubtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                Icon(
                  Icons.check_circle_rounded,
                  color: dataSaverEnabled
                      ? const Color(0xFF1ED760)
                      : Colors.white38,
                  size: 21,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // PROFILE SCREEN
  // =========================================================

  void _onBottomNavTap(int index) {
    setState(() {
      selectedBottomNavIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen(initialIndex: 0)),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen(initialIndex: 1)),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen(initialIndex: 2)),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ProfileScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final navBar = widget.showBottomNavigationBar
        ? BottomNavigationBar(
            currentIndex: selectedBottomNavIndex,
            onTap: _onBottomNavTap,
            backgroundColor: const Color(0xFF121212),
            selectedItemColor: const Color(0xFF1ED760),
            unselectedItemColor: Colors.white54,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_music_rounded),
                label: 'Library',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
          )
        : null;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 90),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: R.sp(context, 32),
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Container(
                          width: R.w(context, 44),
                          height: R.w(context, 44),
                          decoration: BoxDecoration(
                            color: const Color(0xFF202020),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            Icons.more_horiz_rounded,
                            color: Colors.white70,
                            size: R.w(context, 25),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: R.h(context, 26)),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF292929),
                            Color(0xFF171717),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.06),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: R.w(context, 118),
                            height: R.w(context, 118),
                            padding: EdgeInsets.all(R.w(context, 3)),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF1ED760),
                                  Color(0xFF8AFFB5),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF1ED760)
                                      .withOpacity(0.20),
                                  blurRadius: 25,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/profile.png',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: const Color(0xFF303030),
                                    child: const Icon(
                                      Icons.person_rounded,
                                      color: Colors.white,
                                      size: 55,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          SizedBox(height: R.h(context, 18)),

                          Text(
                            profileName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: R.sp(context, 25),
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.5,
                            ),
                          ),

                          SizedBox(height: R.h(context, 7)),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1ED760).withOpacity(0.10),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'PREMIUM MEMBER',
                              style: TextStyle(
                                color: Color(0xFF1ED760),
                                fontSize: R.sp(context, 11),
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                          ),

                          SizedBox(height: R.h(context, 18)),

                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                _showMessage('Profile opened');
                              },
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22,
                                  vertical: 11,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.08),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'View profile',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: R.sp(context, 14),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: R.w(context, 7)),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: R.w(context, 17),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: R.h(context, 30)),

                    Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: R.sp(context, 22),
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: R.h(context, 14)),

                    _buildSettingTile(
                      icon: Icons.person_outline_rounded,
                      title: 'Account',
                      subtitle: 'Manage your account',
                      onTap: () {
                        _showMessage('Account settings');
                      },
                    ),

                    SizedBox(height: R.h(context, 10)),

                    _buildSettingTile(
                      icon: Icons.headphones_rounded,
                      title: 'Playback',
                      subtitle: 'Audio quality and playback',
                      onTap: () {
                        _showMessage('Playback settings');
                      },
                    ),

                    SizedBox(height: R.h(context, 10)),

                    _buildDataSaverTile(),

                    SizedBox(height: R.h(context, 10)),

                    _buildSettingTile(
                      icon: Icons.notifications_none_rounded,
                      title: 'Notifications',
                      subtitle: 'Manage your notifications',
                      onTap: () {
                        _showMessage('Notification settings');
                      },
                    ),

                    SizedBox(height: R.h(context, 10)),

                    _buildSettingTile(
                      icon: Icons.info_outline_rounded,
                      title: 'About',
                      subtitle: 'App information and version',
                      onTap: () {
                        _showMessage('About this app');
                      },
                    ),

                    SizedBox(height: R.h(context, 28)),

                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _showLogoutDialog,
                        borderRadius: BorderRadius.circular(18),
                        splashColor: Colors.redAccent.withOpacity(0.08),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 17,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF211919),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: Colors.redAccent.withOpacity(0.15),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout_rounded,
                                color: Colors.redAccent,
                                size: 21,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Log out',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: R.h(context, 20)),

                    Center(
                      child: Text(
                        'Music App • Premium',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.25),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 8,
              left: 20,
              right: 20,
              child: _buildDataSaverNotification(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: navBar,
    );
  }
}