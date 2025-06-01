import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'config/theme.dart';
import 'widgets/custom_cursor.dart';
import 'widgets/navigation_bar.dart';
import 'screens/home_screen.dart';
import 'screens/about_screen.dart';
import 'screens/projects_screen.dart';
import 'screens/experience_screen.dart';
import 'screens/contact_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mohit Khandelwal | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavItemTap(int index) {
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: isMobile ? CustomDrawer(
        currentIndex: _currentIndex,
        onTap: _onNavItemTap,
      ) : null,
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content with padding for navigation
            Padding(
              padding: EdgeInsets.only(top: isMobile ? 60 : 80),
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                children: const [
                  HomeScreen(),
                  AboutScreen(),
                  ProjectsScreen(),
                  ExperienceScreen(),
                  ContactScreen(),
                ],
              ),
            ),

            // Navigation Bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomNavigationBar(
                currentIndex: _currentIndex,
                onTap: _onNavItemTap,
              ),
            ),

            // Custom Cursor (only for web)
            if (Theme.of(context).platform == TargetPlatform.windows ||
                Theme.of(context).platform == TargetPlatform.linux ||
                Theme.of(context).platform == TargetPlatform.macOS)
              const CustomCursor(),
          ],
        ),
      ),
      // Bottom navigation for mobile
      bottomNavigationBar: isMobile ? BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavItemTap,
        selectedItemColor: AppTheme.secondaryColor,
        unselectedItemColor: AppTheme.textColor.withOpacity(0.6),
        backgroundColor: AppTheme.surfaceColor,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'About'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Projects'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Experience'),
          BottomNavigationBarItem(icon: Icon(Icons.email), label: 'Contact'),
        ],
      ) : null,
    );
  }
}
