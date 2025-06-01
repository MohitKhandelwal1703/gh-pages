import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:clipboard/clipboard.dart';
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
                    location: experience['location'] as String,
                    position: experience['position'] as String,
                    duration: experience['duration'] as String,
                    description: experience['description'] as String,
                    technologies:
                        List<String>.from(experience['technologies'] as List),
                    companyUrl: experience['companyUrl'] as String,
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
  final String location;
  final String position;
  final String duration;
  final String description;
  final List<String> technologies;
  final String companyUrl;
  final int delay;
  final bool isMobile;

  const _ExperienceCard({
    required this.company,
    required this.location,
    required this.position,
    required this.duration,
    required this.description,
    required this.technologies,
    required this.companyUrl,
    required this.delay,
    required this.isMobile,
  });

  Future<void> _launchURL(String url, BuildContext context) async {
    try {
      debugPrint('Attempting to launch URL: $url');

      // Make sure the URL has proper scheme
      final uri =
          url.startsWith('http') ? Uri.parse(url) : Uri.parse('https://$url');

      debugPrint('Parsed URI: $uri');

      if (await canLaunchUrl(uri)) {
        debugPrint('Can launch URL, attempting to launch...');
        // Use universal_links mode for Android and external app mode as fallback
        final bool launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
          webOnlyWindowName: '_blank',
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
        );

        if (launched) {
          debugPrint('Launch successful');
        } else {
          debugPrint('Launch failed despite canLaunchUrl returning true');
          throw Exception('Failed to launch $url');
        }
      } else {
        debugPrint('Cannot launch URL');
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open website. Please try manually: $url'),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'COPY URL',
              onPressed: () {
                FlutterClipboard.copy(url).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('URL copied to clipboard'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                });
              },
            ),
          ),
        );
      }
    }
  }

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
                // Company name
                Text(
                  company,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),

                // Location
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: AppTheme.secondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.subtitleColor,
                          ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Website link
                InkWell(
                  onTap: () => _launchURL(companyUrl, context),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppTheme.secondaryColor.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.language,
                          size: 14,
                          color: AppTheme.secondaryColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Company Website',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.secondaryColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Duration
                Text(
                  duration,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.subtitleColor,
                      ),
                ),
              ],
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: Duration(milliseconds: delay))
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left column: Company info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Company name
                      Text(
                        company,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppTheme.secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),

                      // Location
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: AppTheme.secondaryColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            location,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppTheme.subtitleColor,
                                    ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      // Website link
                      InkWell(
                        onTap: () => _launchURL(companyUrl, context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppTheme.secondaryColor.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.language,
                                size: 14,
                                color: AppTheme.secondaryColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Company Website',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppTheme.secondaryColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Right column: Duration
                Text(
                  duration,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.subtitleColor,
                      ),
                ),
              ],
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: Duration(milliseconds: delay)),

          const SizedBox(height: 16),

          // Position
          Text(
            position,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.textColor,
                ),
          ).animate().fadeIn(
              duration: 600.ms, delay: Duration(milliseconds: delay + 200)),

          const SizedBox(height: 16),

          // Description
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium,
          ).animate().fadeIn(
              duration: 600.ms, delay: Duration(milliseconds: delay + 400)),

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
          ).animate().fadeIn(
              duration: 600.ms, delay: Duration(milliseconds: delay + 600)),
        ],
      ),
    );
  }
}
