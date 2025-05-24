import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../config/theme.dart';
import '../config/constants.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Container(
      color: AppTheme.backgroundColor,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 16 : 32),
          child: ResponsiveRowColumn(
            rowMainAxisAlignment: MainAxisAlignment.center,
            rowCrossAxisAlignment: CrossAxisAlignment.start,
            columnMainAxisAlignment: MainAxisAlignment.center,
            columnCrossAxisAlignment: CrossAxisAlignment.center,
            layout: ResponsiveBreakpoints.of(context).largerThan(MOBILE)
                ? ResponsiveRowColumnType.ROW
                : ResponsiveRowColumnType.COLUMN,
            children: [
              // Left side - Contact Form
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: Padding(
                  padding: EdgeInsets.all(isMobile ? 16 : 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Get in Touch',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppTheme.secondaryColor,
                            ),
                      ).animate().fadeIn(duration: 600.ms),

                      const SizedBox(height: 24),

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _ContactTextField(
                              controller: _nameController,
                              label: 'Name',
                              icon: Icons.person,
                              delay: 200,
                            ),
                            const SizedBox(height: 16),
                            _ContactTextField(
                              controller: _emailController,
                              label: 'Email',
                              icon: Icons.email,
                              delay: 400,
                            ),
                            const SizedBox(height: 16),
                            _ContactTextField(
                              controller: _messageController,
                              label: 'Message',
                              icon: Icons.message,
                              maxLines: 5,
                              delay: 600,
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // TODO: Implement form submission
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.secondaryColor,
                                  foregroundColor: AppTheme.backgroundColor,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: const Text('Send Message'),
                              ).animate().fadeIn(duration: 600.ms, delay: 800.ms),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Right side - Contact Info
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: Padding(
                  padding: EdgeInsets.all(isMobile ? 16 : 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Info',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppTheme.secondaryColor,
                            ),
                      ).animate().fadeIn(duration: 600.ms),

                      const SizedBox(height: 24),

                      // Email
                      _ContactInfoItem(
                        icon: Icons.email,
                        title: 'Email',
                        content: AppConstants.email,
                        onTap: () => _launchUrl('mailto:${AppConstants.email}'),
                        delay: 200,
                      ),

                      const SizedBox(height: 16),

                      // Location
                      _ContactInfoItem(
                        icon: Icons.location_on,
                        title: 'Location',
                        content: AppConstants.location,
                        delay: 400,
                      ),

                      const SizedBox(height: 32),

                      // Social Links
                      Text(
                        'Social Links',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppTheme.secondaryColor,
                            ),
                      ).animate().fadeIn(duration: 600.ms, delay: 600.ms),

                      const SizedBox(height: 16),

                      // Use Row instead of Wrap for better control
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: AppConstants.socialLinks.map((social) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: _SocialLink(
                              icon: social['icon']!,
                              url: social['url']!,
                              delay: 800,
                            ),
                          );
                        }).toList(),
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

class _ContactTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final int maxLines;
  final int delay;

  const _ContactTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.maxLines = 1,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppTheme.textColor,
          ),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppTheme.secondaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppTheme.secondaryColor.withOpacity(0.2),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppTheme.secondaryColor.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppTheme.secondaryColor,
          ),
        ),
        labelStyle: TextStyle(
          color: AppTheme.secondaryColor.withOpacity(0.8),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
    ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: delay));
  }
}

class _ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final VoidCallback? onTap;
  final int delay;

  const _ContactInfoItem({
    required this.icon,
    required this.title,
    required this.content,
    this.onTap,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: AppTheme.secondaryColor,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.secondaryColor,
                      ),
                ),
                Text(
                  content,
                  style: Theme.of(context).textTheme.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: delay));
  }
}

class _SocialLink extends StatelessWidget {
  final String icon;
  final String url;
  final int delay;

  const _SocialLink({
    required this.icon,
    required this.url,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        icon,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          AppTheme.textColor,
          BlendMode.srcIn,
        ),
      ),
      onPressed: () async {
        if (!await launchUrl(Uri.parse(url))) {
          throw Exception('Could not launch $url');
        }
      },
    ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: delay));
  }
} 