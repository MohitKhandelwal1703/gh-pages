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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveRowColumn(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About Me',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Skills',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  color: AppTheme.secondaryColor,
                                ),
                          ).animate().fadeIn(duration: 600.ms),

                          const SizedBox(height: 16),

                          // Skills Grid
                          LayoutBuilder(builder: (context, constraints) {
                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    constraints.maxWidth > 500 ? 3 : 2,
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
                                  {
                                    'title': 'Flutter',
                                    'icon': Icons.flutter_dash
                                  },
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
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // What I Do Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.work_outline,
                          color: AppTheme.secondaryColor,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'What I Do',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AppTheme.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: AppConstants.What_I_Do.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${index + 1}.',
                                style: TextStyle(
                                  color: AppTheme.secondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  AppConstants.What_I_Do[index],
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ).animate().fadeIn(
                              duration: 400.ms,
                              delay: Duration(milliseconds: 100 * index),
                            );
                      },
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 800.ms)
                  .slideY(begin: 0.3, end: 0),

              const SizedBox(height: 24),

              // Tech Stack Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.code,
                          color: AppTheme.secondaryColor,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Tech Stack',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AppTheme.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Categorized Tech Stack
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: AppConstants.Tech_Stack_Categories.entries
                          .map((category) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Category title
                            Container(
                              margin:
                                  const EdgeInsets.only(bottom: 10, top: 16),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppTheme.secondaryColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                category.key,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            // Technologies in this category
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: category.value.map((tech) {
                                final index = category.value.indexOf(tech);
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.secondaryColor
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: AppTheme.secondaryColor
                                          .withOpacity(0.3),
                                    ),
                                  ),
                                  child: Text(
                                    tech,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: AppTheme.secondaryColor,
                                        ),
                                  ),
                                ).animate().fadeIn(
                                      duration: 400.ms,
                                      delay: Duration(
                                        milliseconds: 100 * index +
                                            200 *
                                                AppConstants
                                                    .Tech_Stack_Categories.keys
                                                    .toList()
                                                    .indexOf(category.key),
                                      ),
                                    );
                              }).toList(),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 1000.ms)
                  .slideY(begin: 0.3, end: 0),

              const SizedBox(height: 24),

              // AI Tools Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1A2151),
                      Color(0xFF383F73),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.smart_toy,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'AI Tools I Use',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Responsive grid layout for AI tools
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        // First row
                        SizedBox(
                          width: ResponsiveBreakpoints.of(context)
                                  .largerThan(MOBILE)
                              ? (MediaQuery.of(context).size.width - 120) / 3
                              : double.infinity,
                          child: _buildAIToolCard(
                            context,
                            'Cursor AI',
                            'Advanced coding assistant',
                            Icons.code,
                            Colors.blue,
                            200,
                          ),
                        ),

                        SizedBox(
                          width: ResponsiveBreakpoints.of(context)
                                  .largerThan(MOBILE)
                              ? (MediaQuery.of(context).size.width - 120) / 3
                              : double.infinity,
                          child: _buildAIToolCard(
                            context,
                            'Firebase',
                            'Intelligent backend platform',
                            Icons.cloud,
                            Colors.orange,
                            600,
                          ),
                        ),
                        // Second row
                        SizedBox(
                          width: ResponsiveBreakpoints.of(context)
                                  .largerThan(MOBILE)
                              ? (MediaQuery.of(context).size.width - 120) / 3
                              : double.infinity,
                          child: _buildAIToolCard(
                            context,
                            'Figma',
                            'UI/UX design platform',
                            Icons.brush,
                            Colors.pink,
                            800,
                          ),
                        ),
                        SizedBox(
                          width: ResponsiveBreakpoints.of(context)
                                  .largerThan(MOBILE)
                              ? (MediaQuery.of(context).size.width - 120) / 3
                              : double.infinity,
                          child: _buildAIToolCard(
                            context,
                            'ChatGPT (Pro)',
                            'Research + code assistant',
                            Icons.chat_bubble_outline,
                            Colors.green,
                            1000,
                          ),
                        ),
                        SizedBox(
                          width: ResponsiveBreakpoints.of(context)
                                  .largerThan(MOBILE)
                              ? (MediaQuery.of(context).size.width - 120) / 3
                              : double.infinity,
                          child: _buildAIToolCard(
                            context,
                            'Codeium',
                            'Free AI code assistant',
                            Icons.auto_awesome,
                            Colors.amber,
                            1200,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 1200.ms)
                  .slideY(begin: 0.3, end: 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAIToolCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    int delay,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white30,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: delay));
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
