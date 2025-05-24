import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../config/theme.dart';
import '../config/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.backgroundColor,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ResponsiveRowColumn(
            rowMainAxisAlignment: MainAxisAlignment.center,
            rowCrossAxisAlignment: CrossAxisAlignment.start,
            columnMainAxisAlignment: MainAxisAlignment.center,
            columnCrossAxisAlignment: CrossAxisAlignment.center,
            layout: ResponsiveBreakpoints.of(context).largerThan(MOBILE)
                ? ResponsiveRowColumnType.ROW
                : ResponsiveRowColumnType.COLUMN,
            children: [
              // Left side - About text
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About Me',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: AppTheme.secondaryColor,
                            ),
                      ).animate().fadeIn(duration: 600.ms),

                      const SizedBox(height: 16),

                      Text(
                        AppConstants.aboutMe,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ).animate().fadeIn(duration: 600.ms, delay: 200.ms),

                      const SizedBox(height: 24),

                      // Location and Email
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: AppTheme.secondaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              AppConstants.location,
                              style: Theme.of(context).textTheme.bodyLarge,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ).animate().fadeIn(duration: 600.ms, delay: 400.ms),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          const Icon(
                            Icons.email,
                            color: AppTheme.secondaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              AppConstants.email,
                              style: Theme.of(context).textTheme.bodyLarge,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
                    ],
                  ),
                ),
              ),

              // Right side - Skills
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Skills',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: AppTheme.secondaryColor,
                            ),
                      ).animate().fadeIn(duration: 600.ms),

                      const SizedBox(height: 16),

                      // Skills Grid
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: constraints.maxWidth > 500 ? 3 : 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1.2,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              final skills = [
                                {'title': 'Android', 'icon': Icons.android},
                                {'title': 'Flutter', 'icon': Icons.flutter_dash},
                                {'title': 'Java', 'icon': Icons.code},
                                {'title': 'Kotlin', 'icon': Icons.code},
                                {'title': 'Firebase', 'icon': Icons.cloud},
                                {'title': 'Git', 'icon': Icons.cloud},
                              ];
                              
                              return _SkillCard(
                                title: skills[index]['title'] as String,
                                icon: skills[index]['icon'] as IconData,
                                delay: 200 * (index + 1),
                              );
                            },
                          );
                        }
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final int delay;

  const _SkillCard({
    required this.title,
    required this.icon,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.secondaryColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: AppTheme.secondaryColor,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppTheme.textColor,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: delay));
  }
} 