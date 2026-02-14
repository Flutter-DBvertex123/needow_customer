/*import 'package:flutter/material.dart';

class AppSnackBar {
  /// Shows a success snackbar
  static void showSuccess(
      BuildContext context, {
        required String message,
        Duration duration = const Duration(seconds: 3),
        SnackBarAction? action,
      }) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: Colors.green[600]!,
      duration: duration,
      action: action,
      icon: Icons.check_circle,
      iconColor: Colors.white,
    );
  }

  /// Shows an error snackbar
  static void showError(
      BuildContext context, {
        required String message,
        Duration duration = const Duration(seconds: 3),
        SnackBarAction? action,
      }) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: Colors.red[600]!,
      duration: duration,
      action: action,
      icon: Icons.error_outline,
      iconColor: Colors.white,
    );
  }

  /// Shows an info snackbar
  static void showInfo(
      BuildContext context, {
        required String message,
        Duration duration = const Duration(seconds: 3),
        SnackBarAction? action,
      }) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: Colors.blue[600]!,
      duration: duration,
      action: action,
      icon: Icons.info_outline,
      iconColor: Colors.white,
    );
  }

  /// Shows a warning snackbar
  static void showWarning(
      BuildContext context, {
        required String message,
        Duration duration = const Duration(seconds: 3),
        SnackBarAction? action,
      }) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: Colors.amber[600]!,
      duration: duration,
      action: action,
      icon: Icons.warning_amber,
      iconColor: Colors.white,
    );
  }

  /// Shows a custom snackbar
  static void show(
      BuildContext context, {
        required String message,
        Color backgroundColor = const Color(0xFF323232),
        Duration duration = const Duration(seconds: 3),
        SnackBarAction? action,
        IconData? icon,
        Color iconColor = Colors.white,
      }) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: backgroundColor,
      duration: duration,
      action: action,
      icon: icon,
      iconColor: iconColor,
    );
  }

  /// Internal method to show snackbar
  static void _showSnackBar(
      BuildContext context, {
        required String message,
        required Color backgroundColor,
        required Duration duration,
        SnackBarAction? action,
        IconData? icon,
        required Color iconColor,
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: iconColor),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 6,
      ),
    );
  }
}*/
// import 'package:flutter/material.dart';
//
// class AppSnackBar {
//   /// Shows a success snackbar with smooth easeInOut animation
//   static void showSuccess(
//       BuildContext context, {
//         required String message,
//         Duration duration = const Duration(seconds: 3),
//       }) {
//     _showSnackBar(
//       context,
//       message: message,
//       backgroundColor: Colors.green[600]!,
//       duration: duration,
//       icon: Icons.check_circle,
//     );
//   }
//
//   /// Shows an error snackbar with smooth easeInOut animation
//   static void showError(
//       BuildContext context, {
//         required String message,
//         Duration duration = const Duration(seconds: 3),
//       }) {
//     _showSnackBar(
//       context,
//       message: message,
//       backgroundColor: Colors.red[600]!,
//       duration: duration,
//       icon: Icons.error_outline,
//     );
//   }
//
//   /// Shows an info snackbar with smooth easeInOut animation
//   static void showInfo(
//       BuildContext context, {
//         required String message,
//         Duration duration = const Duration(seconds: 3),
//       }) {
//     _showSnackBar(
//       context,
//       message: message,
//       backgroundColor: Colors.blue[600]!,
//       duration: duration,
//       icon: Icons.info_outline,
//     );
//   }
//
//   /// Shows a warning snackbar with smooth easeInOut animation
//   static void showWarning(
//       BuildContext context, {
//         required String message,
//         Duration duration = const Duration(seconds: 3),
//       }) {
//     _showSnackBar(
//       context,
//       message: message,
//       backgroundColor: Colors.amber[600]!,
//       duration: duration,
//       icon: Icons.warning_amber,
//     );
//   }
//
//   /// Shows a custom snackbar with smooth easeInOut animation
//   static void show(
//       BuildContext context, {
//         required String message,
//         Color backgroundColor = const Color(0xFF323232),
//         Duration duration = const Duration(seconds: 3),
//         IconData? icon,
//       }) {
//     _showSnackBar(
//       context,
//       message: message,
//       backgroundColor: backgroundColor,
//       duration: duration,
//       icon: icon,
//     );
//   }
//
//   /// Internal method with smooth easeInOut animation
//   static void _showSnackBar(
//       BuildContext context, {
//         required String message,
//         required Color backgroundColor,
//         required Duration duration,
//         IconData? icon,
//       }) {
//     if (!context.mounted) return;
//
//     final overlay = Overlay.of(context);
//     late OverlayEntry overlayEntry;
//
//     overlayEntry = OverlayEntry(
//       builder: (context) => _AnimatedSnackBar(
//         message: message,
//         backgroundColor: backgroundColor,
//         duration: duration,
//         icon: icon,
//         onDismissed: () => overlayEntry.remove(),
//       ),
//     );
//
//     overlay.insert(overlayEntry);
//   }
// }
//
// class _AnimatedSnackBar extends StatefulWidget {
//   final String message;
//   final Color backgroundColor;
//   final Duration duration;
//   final IconData? icon;
//   final VoidCallback onDismissed;
//
//   const _AnimatedSnackBar({
//     required this.message,
//     required this.backgroundColor,
//     required this.duration,
//     this.icon,
//     required this.onDismissed,
//   });
//
//   @override
//   State<_AnimatedSnackBar> createState() => _AnimatedSnackBarState();
// }
//
// class _AnimatedSnackBarState extends State<_AnimatedSnackBar>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _slideAnimation;
//   late Animation<double> _fadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );
//
//     // Slide animation from top
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, -1),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
//
//     // Fade animation
//     _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//
//     _controller.forward();
//
//     // Auto dismiss after duration
//     Future.delayed(widget.duration, () {
//       if (mounted) {
//         _controller.reverse().then((_) {
//           if (mounted) {
//             widget.onDismissed();
//           }
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SlideTransition(
//       position: _slideAnimation,
//       child: FadeTransition(
//         opacity: _fadeAnimation,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Material(
//             color: Colors.transparent,
//             child: Container(
//               height: 80,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               decoration: BoxDecoration(
//                 color: widget.backgroundColor,
//                 borderRadius: BorderRadius.circular(8),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.2),
//                     blurRadius: 8,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   if (widget.icon != null) ...[
//                     Icon(widget.icon, color: Colors.white),
//                     const SizedBox(width: 12),
//                   ],
//                   Expanded(
//                     child: Text(
//                       widget.message,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       _controller.reverse().then((_) {
//                         if (mounted) {
//                           widget.onDismissed();
//                         }
//                       });
//                     },
//                     child: const Icon(Icons.close, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class AppSnackBar {
  /// Shows a success snackbar with smooth easeInOut animation
  static void showSuccess(
      BuildContext context, {
        required String message,
        Duration duration = const Duration(seconds: 2),
      }) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: Colors.green[600]!,
      duration: duration,
      icon: Icons.check_circle,
    );
  }

  /// Shows an error snackbar with smooth easeInOut animation
  static void showError(
      BuildContext context, {
        required String message,
        Duration duration = const Duration(seconds: 2),
      }) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: Colors.red[600]!,
      duration: duration,
      icon: Icons.error_outline,
    );
  }

  /// Shows an info snackbar with smooth easeInOut animation
  static void showInfo(
      BuildContext context, {
        required String message,
        Duration duration = const Duration(seconds: 2),
      }) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: Colors.blue[600]!,
      duration: duration,
      icon: Icons.info_outline,
    );
  }

  /// Shows a warning snackbar with smooth easeInOut animation
  static void showWarning(
      BuildContext context, {
        required String message,
        Duration duration = const Duration(seconds: 2),
      }) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: Colors.amber[600]!,
      duration: duration,
      icon: Icons.warning_amber,
    );
  }

  /// Shows a custom snackbar with smooth easeInOut animation
  static void show(
      BuildContext context, {
        required String message,
        Color backgroundColor = const Color(0xFF323232),
        Duration duration = const Duration(seconds: 2),
        IconData? icon,
      }) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: backgroundColor,
      duration: duration,
      icon: icon,
    );
  }

  /// Internal method with smooth easeInOut animation
  static void _showSnackBar(
      BuildContext context, {
        required String message,
        required Color backgroundColor,
        required Duration duration,
        IconData? icon,
      }) {
    if (!context.mounted) return;

    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _AnimatedSnackBar(
        message: message,
        backgroundColor: backgroundColor,
        duration: duration,
        icon: icon,
        onDismissed: () => overlayEntry.remove(),
      ),
    );

    overlay.insert(overlayEntry);
  }
}

class _AnimatedSnackBar extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final Duration duration;
  final IconData? icon;
  final VoidCallback onDismissed;

  const _AnimatedSnackBar({
    required this.message,
    required this.backgroundColor,
    required this.duration,
    this.icon,
    required this.onDismissed,
  });

  @override
  State<_AnimatedSnackBar> createState() => _AnimatedSnackBarState();
}

class _AnimatedSnackBarState extends State<_AnimatedSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Slide animation from top
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Fade animation
    _fadeAnimation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    // Auto dismiss after duration
    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse().then((_) {
          if (mounted) {
            widget.onDismissed();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, color: Colors.white),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: Text(
                        widget.message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        _controller.reverse().then((_) {
                          if (mounted) {
                            widget.onDismissed();
                          }
                        });
                      },
                      child: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}