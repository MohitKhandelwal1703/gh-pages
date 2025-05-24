import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../config/theme.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final List<String> technologies;
  final String playStoreUrl;
  final String githubUrl;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.technologies,
    required this.playStoreUrl,
    required this.githubUrl,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if we're on a small screen
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 350),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Project Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: SizedBox(
                height: 150,
                width: double.infinity,
                child: SvgPicture.asset(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Project Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppTheme.secondaryColor,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ).animate(target: isHovered ? 1 : 0).scale(
                        duration: 200.ms,
                        curve: Curves.easeOut,
                        begin: const Offset(1, 1),
                        end: const Offset(1.05, 1.05),
                      ),

                  const SizedBox(height: 8),

                  // Description
                  Text(
                    widget.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 12),

                  // Technologies
                  SizedBox(
                    height: 32,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: widget.technologies.map((tech) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
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
                  ),

                  const SizedBox(height: 12),

                  // Links - Responsive layout
                  isSmallScreen 
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _LinkButton(
                          icon: Icons.android,
                          label: 'Play Store',
                          onTap: () => _launchUrl(widget.playStoreUrl),
                          fullWidth: true,
                        ),
                        const SizedBox(height: 8),
                        _LinkButton(
                          icon: Icons.code,
                          label: 'GitHub',
                          onTap: () => _launchUrl(widget.githubUrl),
                          fullWidth: true,
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        _LinkButton(
                          icon: Icons.android,
                          label: 'Play Store',
                          onTap: () => _launchUrl(widget.playStoreUrl),
                        ),
                        const SizedBox(width: 12),
                        _LinkButton(
                          icon: Icons.code,
                          label: 'GitHub',
                          onTap: () => _launchUrl(widget.githubUrl),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ).animate(target: isHovered ? 1 : 0).scale(
            duration: 200.ms,
            curve: Curves.easeOut,
            begin: const Offset(1, 1),
            end: const Offset(1.02, 1.02),
          ),
    );
  }
}

class _LinkButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool fullWidth;

  const _LinkButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: fullWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: AppTheme.secondaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: fullWidth ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 16,
                color: AppTheme.secondaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.secondaryColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 