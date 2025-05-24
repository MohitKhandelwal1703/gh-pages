import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/theme.dart';
import '../config/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet = MediaQuery.of(context).size.width < 800 && MediaQuery.of(context).size.width >= 600;
    
    return Container(
      color: AppTheme.backgroundColor,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ResponsiveRowColumn(
          rowMainAxisAlignment: MainAxisAlignment.center,
          rowCrossAxisAlignment: CrossAxisAlignment.center,
          columnMainAxisAlignment: MainAxisAlignment.center,
          columnCrossAxisAlignment: CrossAxisAlignment.center,
          layout: ResponsiveBreakpoints.of(context).largerThan(MOBILE)
              ? ResponsiveRowColumnType.ROW
              : ResponsiveRowColumnType.COLUMN,
          children: [
            // Left side - Text content
            ResponsiveRowColumnItem(
              rowFlex: 1,
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 16 : 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Greeting
                    Text(
                      'Hi, my name is',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.secondaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),

                    const SizedBox(height: 12),

                    // Name
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          AppTheme.textColor,
                          AppTheme.secondaryColor,
                        ],
                      ).createShader(bounds),
                      child: Text(
                        AppConstants.name,
                        style: isMobile 
                            ? Theme.of(context).textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              )
                            : Theme.of(context).textTheme.displayLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 200.ms)
                        .slideY(begin: 0.3, end: 0),

                    const SizedBox(height: 12),

                    // Title
                    Text(
                      AppConstants.title,
                      style: isMobile
                          ? Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppTheme.subtitleColor,
                              )
                          : Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: AppTheme.subtitleColor,
                              ),
                    )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 400.ms)
                        .slideY(begin: 0.3, end: 0),

                    const SizedBox(height: 24),

                    // Description
                    Text(
                      AppConstants.aboutMe,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.textColor.withOpacity(0.9),
                          ),
                    )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 600.ms)
                        .slideY(begin: 0.3, end: 0),

                    const SizedBox(height: 32),
                    
                    // Download Resume Button
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => _launchURL(AppConstants.resumeUrl),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: AppTheme.secondaryColor,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Download Resume',
                                style: TextStyle(
                                  color: AppTheme.secondaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.download,
                                color: AppTheme.secondaryColor,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).animate().fadeIn(duration: 600.ms, delay: 800.ms).slideY(begin: 0.3, end: 0),

                    const SizedBox(height: 24),

                    // Social Links
                    Row(
                      children: AppConstants.socialLinks.map((social) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => _launchURL(social['url']!),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppTheme.surfaceColor,
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  social['icon']!,
                                  width: 24,
                                  height: 24,
                                  colorFilter: const ColorFilter.mode(
                                    AppTheme.textColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ).animate().fadeIn(duration: 600.ms, delay: 1000.ms),
                  ],
                ),
              ),
            ),

            // Right side - Profile image or illustration
            ResponsiveRowColumnItem(
              rowFlex: 1,
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 16 : 32),
                child: Center(
                  child: Container(
                    width: isMobile ? 200 : 300,
                    height: isMobile ? 200 : 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.secondaryColor,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.secondaryColor.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/profile.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ).animate()
                    .fadeIn(duration: 800.ms, delay: 400.ms)
                    .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1), duration: 800.ms, curve: Curves.easeOutBack),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 