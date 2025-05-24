import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/theme.dart';

class CustomCursor extends StatefulWidget {
  const CustomCursor({super.key});

  @override
  State<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends State<CustomCursor> {
  double x = 0;
  double y = 0;
  bool isHovering = false;
  bool isClicking = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => setState(() => isClicking = true),
      onPointerUp: (_) => setState(() => isClicking = false),
      onPointerCancel: (_) => setState(() => isClicking = false),
      child: MouseRegion(
        opaque: false,
        onEnter: (_) => setState(() => isHovering = true),
        onExit: (_) => setState(() => isHovering = false),
        onHover: (event) {
          setState(() {
            // Add slight delay for smoother movement
            x = event.localPosition.dx;
            y = event.localPosition.dy;
          });
        },
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              // Main cursor
              AnimatedPositioned(
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeOutExpo,
                left: x - 8,
                top: y - 8,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: isHovering ? 1.0 : 0.0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: isClicking ? 12 : 16,
                    height: isClicking ? 12 : 16,
                    decoration: BoxDecoration(
                      color: isClicking 
                          ? AppTheme.secondaryColor.withOpacity(0.8)
                          : AppTheme.secondaryColor.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                  )
                      .animate(target: isHovering ? 1 : 0)
                      .scale(duration: 200.ms, curve: Curves.easeOut)
                      .fade(duration: 200.ms),
                ),
              ),
              
              // Outer ring
              AnimatedPositioned(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeOutExpo,
                left: x - 16,
                top: y - 16,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: isHovering ? 1.0 : 0.0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: isClicking ? 24 : 32,
                    height: isClicking ? 24 : 32,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isClicking 
                            ? AppTheme.secondaryColor.withOpacity(0.8)
                            : AppTheme.secondaryColor,
                        width: isClicking ? 2 : 1,
                      ),
                      shape: BoxShape.circle,
                    ),
                  )
                      .animate(target: isHovering ? 1 : 0)
                      .scale(duration: 300.ms, curve: Curves.easeOut)
                      .fade(duration: 300.ms),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 