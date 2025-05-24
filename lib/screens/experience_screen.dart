import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/theme.dart';
import '../config/constants.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Container(
      color: AppTheme.backgroundColor,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 16 : 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Work Experience',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.secondaryColor,
                    ),
              ).animate().fadeIn(duration: 600.ms),

              const SizedBox(height: 24),

              // Experience Timeline
              ...List.generate(
                AppConstants.experience.length,
                (index) {
                  final experience = AppConstants.experience[index];
                  return _ExperienceCard(
                    company: experience['company'] as String,
                    position: experience['position'] as String,
                    duration: experience['duration'] as String,
                    description: experience['description'] as String,
                    technologies: List<String>.from(experience['technologies'] as List),
                    delay: 200 * index,
                    isMobile: isMobile,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final String company;
  final String position;
  final String duration;
  final String description;
  final List<String> technologies;
  final int delay;
  final bool isMobile;

  const _ExperienceCard({
    required this.company,
    required this.position,
    required this.duration,
    required this.description,
    required this.technologies,
    required this.delay,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.secondaryColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company and Duration - Responsive layout
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  company,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.secondaryColor,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  duration,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.subtitleColor,
                      ),
                ),
              ],
            ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: delay))
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    company,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppTheme.secondaryColor,
                        ),
                  ),
                ),
                Text(
                  duration,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.subtitleColor,
                      ),
                ),
              ],
            ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: delay)),

          const SizedBox(height: 8),

          // Position
          Text(
            position,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.textColor,
                ),
          ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: delay + 200)),

          const SizedBox(height: 16),

          // Description
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium,
          ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: delay + 400)),

          const SizedBox(height: 16),

          // Technologies
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: technologies.map((tech) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      tech,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.secondaryColor,
                          ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: delay + 600)),
        ],
      ),
    );
  }
} 