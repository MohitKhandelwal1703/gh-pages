import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import 'dart:ui';

class CustomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  void _openDrawer() {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet = MediaQuery.of(context).size.width < 800 && MediaQuery.of(context).size.width >= 600;
    
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: isMobile ? 0 : 10, sigmaY: isMobile ? 0 : 10),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24, 
            vertical: isMobile ? 12 : 16
          ),
          decoration: BoxDecoration(
            color: AppTheme.backgroundColor.withOpacity(0.95),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo/Name - Wrap in Flexible to handle overflow
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        isMobile ? AppConstants.name.split(' ')[0] : AppConstants.name,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: AppTheme.secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ).animate().fadeIn(duration: 600.ms),
                    ),
                    
                    if (!isMobile && !isTablet)
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "/ " + AppConstants.title.split('/')[0].trim(),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppTheme.subtitleColor,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                        ),
                      ),
                  ],
                ),
              ),

              // Navigation Items - Hide on mobile, use SingleChildScrollView for tablet
              if (!isMobile)
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        AppConstants.navigationItems.length,
                        (index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: isTablet ? 4 : 8),
                          child: _NavItem(
                            title: AppConstants.navigationItems[index]['title']!,
                            index: index,
                            isSelected: widget.currentIndex == index,
                            onTap: () => widget.onTap(index),
                          ),
                        ),
                      ),
                    ),
                  ),
                ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                
              // Mobile menu button
              if (isMobile)
                IconButton(
                  icon: const Icon(Icons.menu, color: AppTheme.textColor),
                  onPressed: _openDrawer,
                ).animate().fadeIn(duration: 600.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String title;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.title,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.secondaryColor.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: isSelected ? Border.all(
              color: AppTheme.secondaryColor.withOpacity(0.3),
              width: 1,
            ) : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "0${index + 1}.",
                style: TextStyle(
                  color: AppTheme.secondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isSelected ? AppTheme.secondaryColor : AppTheme.textColor,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
              ),
            ],
          ),
        ),
      ),
    ).animate(target: isSelected ? 1 : 0).scale(
          duration: 200.ms,
          curve: Curves.easeOut,
          begin: const Offset(1, 1),
          end: const Offset(1.05, 1.05),
        );
  }
}

class CustomDrawer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  
  const CustomDrawer({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.surfaceColor,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppTheme.backgroundColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppConstants.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppConstants.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.subtitleColor,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: AppConstants.navigationItems.length,
              itemBuilder: (context, index) {
                final item = AppConstants.navigationItems[index];
                final isSelected = index == currentIndex;
                
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        "0${index + 1}.",
                        style: TextStyle(
                          color: AppTheme.secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item['title']!,
                        style: TextStyle(
                          color: isSelected ? AppTheme.secondaryColor : AppTheme.textColor,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  tileColor: isSelected ? AppTheme.secondaryColor.withOpacity(0.1) : null,
                  onTap: () {
                    onTap(index);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          const Divider(color: AppTheme.subtitleColor),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: AppConstants.socialLinks.map((social) {
                return IconButton(
                  icon: Icon(
                    _getSocialIcon(social['name']!),
                    color: AppTheme.textColor,
                  ),
                  onPressed: () {
                    // TODO: Implement social link navigation
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
  
  IconData _getSocialIcon(String name) {
    switch (name.toLowerCase()) {
      case 'github':
        return Icons.code;
      case 'linkedin':
        return Icons.business;
      case 'twitter':
        return Icons.flutter_dash;
      default:
        return Icons.link;
    }
  }
} 