import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../config/theme.dart';
import '../config/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _launchURL(BuildContext context, String url) async {
    try {
      // Check if this is the local resume file
      if (url.startsWith('assets/')) {
        if (kIsWeb) {
          // For web, we can't use PDFView directly
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: AppTheme.surfaceColor,
                title: const Text('Resume', style: TextStyle(color: AppTheme.secondaryColor)),
                content: const Text(
                  'On web platform, you would need to download the PDF file first. Please use the download button below.',
                  style: TextStyle(color: AppTheme.textColor),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close', style: TextStyle(color: AppTheme.secondaryColor)),
                  ),
                  TextButton(
                    onPressed: () {
                      // Replace with actual download URL
                      launchUrl(Uri.parse('https://github.com/MohitKhandelwal1703/gh-pages/raw/main/assets/pdf/resume.pdf'), 
                        mode: LaunchMode.externalApplication);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Download', style: TextStyle(color: AppTheme.secondaryColor)),
                  ),
                ],
              );
            },
          );
          return;
        } else {
          // For mobile, load the PDF file from assets
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PDFViewerPage(pdfAssetPath: url),
            ),
          );
          return;
        }
      }

      // For regular URLs
      final uri = url.startsWith('http')
          ? Uri.parse(url)
          : Uri.parse('https://$url');

      debugPrint('Trying to launch: $uri');

      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
          webOnlyWindowName: '_blank',
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
        );
      } else {
        debugPrint('Could not launch $url');
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery
        .of(context)
        .size
        .width < 600;
    final isTablet = MediaQuery
        .of(context)
        .size
        .width < 800 &&
        MediaQuery
            .of(context)
            .size
            .width >= 600;

    return Container(
      color: AppTheme.backgroundColor,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section with Profile Image
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isMobile ? 16 : 32),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.backgroundColor,
                    AppTheme.surfaceColor,
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Top Action Button
                  Align(
                    alignment: Alignment.topRight,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => _launchURL(context, AppConstants.resumeUrl),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppTheme.secondaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: AppTheme.secondaryColor,
                              width: 1.5,
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'View Resume',
                                style: TextStyle(
                                  color: AppTheme.secondaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.visibility,
                                color: AppTheme.secondaryColor,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: -0.2, end: 0),

                  const SizedBox(height: 40),

                  // Profile Picture and Hero Text
                  ResponsiveRowColumn(
                    rowMainAxisAlignment: MainAxisAlignment.center,
                    rowCrossAxisAlignment: CrossAxisAlignment.center,
                    columnMainAxisAlignment: MainAxisAlignment.center,
                    columnCrossAxisAlignment: CrossAxisAlignment.center,
                    layout: isMobile
                        ? ResponsiveRowColumnType.COLUMN
                        : ResponsiveRowColumnType.ROW,
                    children: [
                      // Profile Image
                      ResponsiveRowColumnItem(
                        rowFlex: 1,
                        child: Center(
                          child: Container(
                            width: isMobile ? 150 : 220,
                            height: isMobile ? 150 : 220,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppTheme.secondaryColor,
                                width: 3,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x33009688),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: kIsWeb
                                  ? Image.asset(
                                'assets/images/profile.jpeg',
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) {
                                  return Container(
                                    color: AppTheme.surfaceColor,
                                    child: const Icon(
                                      Icons.person,
                                      color: AppTheme.secondaryColor,
                                      size: 100,
                                    ),
                                  );
                                },
                              )
                                  : Image.asset(
                                'assets/images/profile.jpeg',
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) {
                                  return Container(
                                    color: AppTheme.surfaceColor,
                                    child: const Icon(
                                      Icons.person,
                                      color: AppTheme.secondaryColor,
                                      size: 80,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 800.ms, delay: 200.ms)
                            .scale(
                            begin: const Offset(0.8, 0.8),
                            end: const Offset(1, 1),
                            duration: 800.ms,
                            curve: Curves.easeOutBack),
                      ),

                      // Hero Text
                      ResponsiveRowColumnItem(
                        rowFlex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(isMobile ? 16 : 32),
                          child: Column(
                            crossAxisAlignment: isMobile
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.start,
                            children: [
                              // Name
                              ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                      colors: [
                                        AppTheme.textColor,
                                        AppTheme.secondaryColor,
                                      ],
                                    ).createShader(bounds),
                                child: Text(
                                  AppConstants.name,
                                  textAlign: isMobile
                                      ? TextAlign.center
                                      : TextAlign.start,
                                  style: TextStyle(
                                    fontSize: isMobile ? 36 : 52,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 1.2,
                                    height: 1.1,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.3),
                                        offset: const Offset(2, 2),
                                        blurRadius: 5,
                                      ),
                                    ],
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              )
                                  .animate()
                                  .fadeIn(duration: 600.ms, delay: 400.ms)
                                  .slideY(begin: 0.3, end: 0),

                              const SizedBox(height: 12),

                              // Title
                              Text(
                                AppConstants.title,
                                textAlign: isMobile
                                    ? TextAlign.center
                                    : TextAlign.start,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                  color: AppTheme.subtitleColor,
                                ),
                              )
                                  .animate()
                                  .fadeIn(duration: 600.ms, delay: 600.ms)
                                  .slideY(begin: 0.3, end: 0),

                              const SizedBox(height: 16),

                              // Taglines - conditionally display based on screen size
                              ...(isMobile
                                  ? [
                                "Flutter: Android/IOS/Window",
                                "Android Native java / Kotlin",
                                "UI/UX Enthusiast",
                                "CURSOR AI Specialist"
                              ]
                                  : [
                                "Flutter & Android Expert • UI/UX Enthusiast • CURSOR AI Specialist",
                                "Building Beautiful Mobile Experiences with Flutter, Android & AI",
                                "Solving Complex Problems with Clean Code, Smart Design & AI Integration",
                                "From UI Design to AI-Powered Apps — I Craft Mobile Excellence",
                                "Blending Code, Creativity & Intelligence for Next-Gen Mobile Apps"
                              ]
                              ).map((tagline) {
                                final index = isMobile?
                                ["Flutter: Android/IOS/Window","Android Native java / Kotlin","UI/UX Enthusiast","CURSOR AI Specialist"].indexOf(tagline):
                                ["Flutter & Android Expert • UI/UX Enthusiast • CURSOR AI Specialist","Building Beautiful Mobile Experiences with Flutter, Android & AI","Solving Complex Problems with Clean Code, Smart Design & AI Integration","From UI Design to AI-Powered Apps — I Craft Mobile Excellence","Blending Code, Creativity & Intelligence for Next-Gen Mobile Apps"].indexOf(tagline);
                                return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                Icon(
                                isMobile
                                ? [
                                Icons.flutter_dash,
                                Icons.design_services,
                                Icons.smart_toy,
                                Icons.lightbulb,
                                ][index]
                                    : [
                                Icons.check_circle,
                                Icons.check_circle,
                                Icons.brush,
                                Icons.brush,
                                Icons.lightbulb,
                                ][index],
                                color: AppTheme.secondaryColor,
                                size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                tagline,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                color: AppTheme.textColor,
                                ),
                                ),
                                ],
                                ),
                                ).animate().fadeIn(
                                duration: 600.ms,
                                delay: Duration(
                                milliseconds: 700 + (index
                                *
                                100
                                )
                                )
                                );
                              }).toList(),

                              const SizedBox(height: 24),

                              // Contact info row
                              Wrap(
                                spacing: 16,
                                runSpacing: 12,
                                alignment: isMobile
                                    ? WrapAlignment.center
                                    : WrapAlignment.start,
                                children: [
                                  // Location
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: AppTheme.secondaryColor,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        AppConstants.location,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),

                                  // Email
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.email,
                                        color: AppTheme.secondaryColor,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        AppConstants.email,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                                  .animate()
                                  .fadeIn(duration: 600.ms, delay: 900.ms),

                              const SizedBox(height: 16),

                              // Social media icons
                              Row(
                                mainAxisAlignment: isMobile
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.start,
                                children:
                                AppConstants.socialLinks.map((social) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () => _launchURL(context, social['url']!),
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: AppTheme.surfaceColor,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: SvgPicture.asset(
                                            social['icon']!,
                                            width: 20,
                                            height: 20,
                                            colorFilter: const ColorFilter.mode(
                                              AppTheme.secondaryColor,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )
                                  .animate()
                                  .fadeIn(duration: 600.ms, delay: 1000.ms),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tech Stack Section
            Container(
              padding: EdgeInsets.all(isMobile ? 16 : 32),
              color: AppTheme.surfaceColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 5,
                        decoration: BoxDecoration(
                          color: AppTheme.secondaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Tech Stack",
                        style: TextStyle(
                          color: AppTheme.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 600.ms, delay: 1100.ms),

                  const SizedBox(height: 30),

                  // Tech icons in a card layout
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppTheme.backgroundColor,
                          Color(0xCCD5F5E7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Wrap(
                      spacing: isMobile ? 12 : 20,
                      runSpacing: isMobile ? 20 : 30,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildEnhancedTechIcon(
                            context, "Flutter", Icons.flutter_dash),
                        _buildEnhancedTechIcon(context, "Dart", Icons.code),
                        _buildEnhancedTechIcon(
                            context, "Android", Icons.android),
                        _buildEnhancedTechIcon(context, "Java", Icons.coffee),
                        _buildEnhancedTechIcon(
                            context, "Kotlin", Icons.local_fire_department),
                        _buildEnhancedTechIcon(
                            context, "Cursor AI", Icons.smart_toy),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 1200.ms),
                ],
              ),
            ),

            // Quick Stats
            Container(
              padding: EdgeInsets.all(isMobile ? 16 : 32),
              color: AppTheme.backgroundColor,
              child: Column(
                children: [
                  const Text(
                    "Quick Stats",
                    style: TextStyle(
                      color: AppTheme.secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 1300.ms),

                  const SizedBox(height: 24),

                  // Stats row - redesigned for better appearance across all devices
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppTheme.surfaceColor,
                          Color(0xCCD5F5E7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: _buildEnhancedStatCard(
                            context,
                            "8.8+",
                            "Years Experience",
                            Icons.access_time,
                          ).animate().fadeIn(duration: 600.ms, delay: 1400.ms),
                        ),
                        Container(
                          height: 70,
                          width: 1,
                          color: AppTheme.secondaryColor.withOpacity(0.3),
                        ),
                        Expanded(
                          child: _buildEnhancedStatCard(
                            context,
                            "20+",
                            "Published Apps",
                            Icons.app_shortcut,
                          ).animate().fadeIn(duration: 600.ms, delay: 1500.ms),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Featured Projects
            Container(
              padding: EdgeInsets.all(isMobile ? 16 : 32),
              color: AppTheme.surfaceColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Featured Projects",
                    style: TextStyle(
                      color: AppTheme.secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 1700.ms),

                  const SizedBox(height: 24),

                  // Featured projects grid/list
                  ResponsiveRowColumn(
                    rowCrossAxisAlignment: CrossAxisAlignment.start,
                    layout: isMobile
                        ? ResponsiveRowColumnType.COLUMN
                        : ResponsiveRowColumnType.ROW,
                    children: [
                      // Project 1
                      ResponsiveRowColumnItem(
                        rowFlex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildProjectCard(
                            context,
                            "DealZapp: Save at Restaurants",
                            "A mobile app that offers discounts and deals at restaurants and entertainment venues.",
                            "https://play-lh.googleusercontent.com/-M0yf6A-CkaAUJvQXOWLPaIYSKvp71SRoRQXsIOe8maxdcZ0HjaHLRvm_8bI2t7sCkQ=w2560-h1440-rw",
                            "https://play.google.com/store/apps/details?id=co.apnaa.apnaajpr",
                            1800,
                          ),
                        ),
                      ),

                      // Project 2
                      ResponsiveRowColumnItem(
                        rowFlex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildProjectCard(
                            context,
                            "TarotLife Psychic Reading",
                            "Live psychic reading app with 4M+ downloads offering guidance on relationships and life.",
                            "https://i.ytimg.com/vi/nsGk84m8C44/hqdefault.jpg",
                            "https://play.google.com/store/apps/details?id=com.tarotlife.tarot.card.reading.numerology",
                            2000,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechIcon(BuildContext context, String name, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Icon(
            icon,
            color: AppTheme.secondaryColor,
            size: 32,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: Theme
              .of(context)
              .textTheme
              .bodyMedium,
        ),
      ],
    );
  }

  Widget _buildEnhancedTechIcon(BuildContext context, String name,
      IconData icon) {
    final isMobile = MediaQuery
        .of(context)
        .size
        .width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: isMobile ? 70 : 90,
          height: isMobile ? 70 : 90,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.surfaceColor,
                AppTheme.surfaceColor.withOpacity(0.7),
              ],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.secondaryColor.withOpacity(0.2),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
            border: Border.all(
              color: AppTheme.secondaryColor.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Icon(
            icon,
            color: AppTheme.secondaryColor,
            size: isMobile ? 32 : 42,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: TextStyle(
            color: AppTheme.textColor,
            fontWeight: FontWeight.w500,
            fontSize: isMobile ? 14 : 16,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String number, String label) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            number,
            style: Theme
                .of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(
              color: AppTheme.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme
                .of(context)
                .textTheme
                .bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedStatCard(BuildContext context, String number,
      String label, IconData icon) {
    final isMobile = MediaQuery
        .of(context)
        .size
        .width < 600;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon in circle
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0x1A009688),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppTheme.secondaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            // Number
            Text(
              number,
              style: TextStyle(
                fontSize: isMobile ? 32 : 42,
                fontWeight: FontWeight.bold,
                color: AppTheme.secondaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Label
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: AppTheme.textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildProjectCard(BuildContext context, String title,
      String description, String imageUrl, String link, int delay) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project image
          ClipRRect(
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(8)),
            child: SizedBox(
              height: 150,
              width: double.infinity,
              child: imageUrl.isNotEmpty
                  ? imageUrl.startsWith('http')
                  ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(
                      color: AppTheme.backgroundColor,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.secondaryColor,
                        ),
                      ),
                    ),
                errorWidget: (context, url, error) {
                  print('Error loading cached image: $error');
                  return _buildPlaceholderImage();
                },
              )
                  : Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading asset image: $error');
                  return _buildPlaceholderImage();
                },
              )
                  : _buildPlaceholderImage(),
            ),
          ),

          // Project details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                    color: AppTheme.secondaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _launchURL(context, link),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.secondaryColor.withOpacity(0.1),
                    foregroundColor: AppTheme.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: AppTheme.secondaryColor,
                        width: 1,
                      ),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.launch, size: 16),
                      SizedBox(width: 8),
                      Text("View Project"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: delay));
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: AppTheme.backgroundColor,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.app_shortcut,
              color: AppTheme.secondaryColor,
              size: 40,
            ),
            SizedBox(height: 8),
            Text(
              'App Screenshot',
              style: TextStyle(
                color: Color(0xB3FFFFFF),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class PDFViewerPage extends StatefulWidget {
  final String pdfAssetPath;

  const PDFViewerPage({super.key, required this.pdfAssetPath});

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  String? _pdfPath;
  bool _isLoading = true;
  int _pageNumber = 1;
  int _totalPages = 0;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  @override
  void dispose() {
    // Clean up any resources when the page is closed
    super.dispose();
  }

  Future<void> _loadPDF() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = '';
    });
    
    try {
      final bytes = await rootBundle.load(widget.pdfAssetPath);
      final dir = await getApplicationDocumentsDirectory();
      
      // Use a timestamp to ensure a unique filename each time
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${dir.path}/resume_$timestamp.pdf');
      
      await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);
      
      if (mounted) {
        setState(() {
          _pdfPath = file.path;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading PDF: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
          _errorMessage = 'Failed to load PDF: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume', style: TextStyle(color: AppTheme.textColor)),
        backgroundColor: AppTheme.backgroundColor,
        iconTheme: const IconThemeData(color: AppTheme.secondaryColor),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPDF,
            tooltip: 'Reload PDF',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppTheme.secondaryColor,
              ),
            )
          : _hasError
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading PDF',
                        style: const TextStyle(color: AppTheme.textColor, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          _errorMessage,
                          style: const TextStyle(color: AppTheme.subtitleColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _loadPDF,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.secondaryColor,
                          foregroundColor: AppTheme.backgroundColor,
                        ),
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                )
              : _pdfPath == null
                  ? const Center(
                      child: Text(
                        'Failed to load PDF',
                        style: TextStyle(color: AppTheme.textColor),
                      ),
                    )
                  : Stack(
                      children: [
                        PDFView(
                          filePath: _pdfPath!,
                          enableSwipe: true,
                          swipeHorizontal: true,
                          autoSpacing: true,
                          pageFling: true,
                          pageSnap: true,
                          fitPolicy: FitPolicy.BOTH,
                          preventLinkNavigation: false,
                          onRender: (pages) {
                            setState(() {
                              _totalPages = pages!;
                            });
                          },
                          onPageChanged: (page, total) {
                            setState(() {
                              _pageNumber = page! + 1;
                            });
                          },
                          onError: (error) {
                            setState(() {
                              _hasError = true;
                              _errorMessage = error.toString();
                            });
                          },
                        ),
                        if (_totalPages > 0)
                          Positioned(
                            bottom: 16,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.surfaceColor.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  'Page $_pageNumber of $_totalPages',
                                  style: const TextStyle(color: AppTheme.textColor),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
    );
  }
}
