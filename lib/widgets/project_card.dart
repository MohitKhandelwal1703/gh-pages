import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../config/theme.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final List<String> technologies;
  final String playStoreUrl;
  final String githubUrl;
  final List<String> features;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.technologies,
    required this.playStoreUrl,
    required this.githubUrl,
    required this.features,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Show toast message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch $url'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
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
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Project Image
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: widget.image.isNotEmpty
                      ? widget.image.startsWith('http')
                          ? CachedNetworkImage(
                              imageUrl: widget.image,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
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
                              widget.image,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                print('Error loading asset image: $error');
                                return _buildPlaceholderImage();
                              },
                            )
                      : _buildPlaceholderImage(),
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
                      maxLines: 2,
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
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 12),

                    // Features
                    if (widget.features.isNotEmpty) ...[
                      Text(
                        'Features:',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 100),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const ClampingScrollPhysics(),
                          itemCount: widget.features.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    size: 16,
                                    color: AppTheme.secondaryColor,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      widget.features[index],
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],

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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
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
                                onTap: () {
                                  if (widget.playStoreUrl !=
                                      "UnderDevelopment") {
                                    _launchUrl(widget.playStoreUrl);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('App is under development'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                },
                                fullWidth: true,
                              ),
                              if (widget.githubUrl.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                _LinkButton(
                                  icon: Icons.code,
                                  label: 'GitHub',
                                  onTap: () => _launchUrl(widget.githubUrl),
                                  fullWidth: true,
                                ),
                              ],
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: _LinkButton(
                                  icon: Icons.android,
                                  label: 'Play Store',
                                  onTap: () {
                                    if (widget.playStoreUrl !=
                                        "UnderDevelopment") {
                                      _launchUrl(widget.playStoreUrl);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('App is under development'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  },
                                  fullWidth: true,
                                ),
                              ),
                              if (widget.githubUrl.isNotEmpty) ...[
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _LinkButton(
                                    icon: Icons.code,
                                    label: 'GitHub',
                                    onTap: () => _launchUrl(widget.githubUrl),
                                    fullWidth: true,
                                  ),
                                ),
                              ],
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ).animate(target: isHovered ? 1 : 0).scale(
            duration: 200.ms,
            curve: Curves.easeOut,
            begin: const Offset(1, 1),
            end: const Offset(1.02, 1.02),
          ),
    );
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
            color: const Color(0x1A009688),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment:
                fullWidth ? MainAxisAlignment.center : MainAxisAlignment.start,
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
