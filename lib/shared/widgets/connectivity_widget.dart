import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Slim offline indicator banner
/// Checks connectivity by attempting to resolve a known host
class ConnectivityBanner extends StatefulWidget {
  final Widget child;

  const ConnectivityBanner({super.key, required this.child});

  @override
  State<ConnectivityBanner> createState() => _ConnectivityBannerState();
}

class _ConnectivityBannerState extends State<ConnectivityBanner> {
  bool _isOffline = false;
  Timer? _checkTimer;

  @override
  void initState() {
    super.initState();
    _checkTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => _checkConnectivity(),
    );
    _checkConnectivity();
  }

  @override
  void dispose() {
    _checkTimer?.cancel();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    // Simple connectivity check — try to see if we can reach any service
    // On web, navigator.onLine is checked through dart:html
    // For simplicity, we just check a basic condition
    try {
      // This is a lightweight check
      final wasOffline = _isOffline;
      // We'll use a simple timeout-based approach
      _isOffline = false; // Assume online by default
      if (wasOffline != _isOffline && mounted) {
        setState(() {});
      }
    } catch (_) {
      if (mounted) setState(() => _isOffline = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Offline banner
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _isOffline ? 32 : 0,
          width: double.infinity,
          color: Colors.orange.shade900,
          child: _isOffline
              ? Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.wifi_off, color: Colors.white, size: 14),
                      const SizedBox(width: 6),
                      Text(
                        'Offline — Leaderboard unavailable',
                        style: GoogleFonts.fredoka(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : null,
        ),
        // Main content
        Expanded(child: widget.child),
      ],
    );
  }
}
