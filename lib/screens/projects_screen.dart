import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import '../widgets/project_card.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

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
              // Title
              Text(
                'Featured Projects',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppTheme.secondaryColor,
                    ),
              ).animate().fadeIn(duration: 600.ms),

              const SizedBox(height: 16),

              // Projects List - Mobile-friendly approach
              LayoutBuilder(
                builder: (context, constraints) {
                  // Use list for mobile, grid for larger screens
                  if (constraints.maxWidth < 600) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: AppConstants.projects.length,
                      itemBuilder: (context, index) {
                        final project = AppConstants.projects[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: ProjectCard(
                            title: project['title'] as String,
                            description: project['description'] as String,
                            image: project['image'] as String,
                            technologies: List<String>.from(project['technologies'] as List),
                            playStoreUrl: project['playStoreUrl'] as String,
                            githubUrl: project['githubUrl'] as String,
                          ).animate().fadeIn(
                                duration: 600.ms,
                                delay: Duration(milliseconds: 200 * index),
                              ),
                        );
                      },
                    );
                  } else {
                    // Grid for larger screens
                    return ResponsiveGridView.builder(
                      gridDelegate: const ResponsiveGridDelegate(
                        crossAxisExtent: 350,
                        mainAxisSpacing: 24,
                        crossAxisSpacing: 24,
                        childAspectRatio: 0.7,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: AppConstants.projects.length,
                      itemBuilder: (context, index) {
                        final project = AppConstants.projects[index];
                        return ProjectCard(
                          title: project['title'] as String,
                          description: project['description'] as String,
                          image: project['image'] as String,
                          technologies: List<String>.from(project['technologies'] as List),
                          playStoreUrl: project['playStoreUrl'] as String,
                          githubUrl: project['githubUrl'] as String,
                        ).animate().fadeIn(
                              duration: 600.ms,
                              delay: Duration(milliseconds: 200 * index),
                            );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
} 