import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Beautiful overlay showing Zen session statistics
class ZenSummaryOverlay extends StatefulWidget {
  final int score;
  final int totalLinesCleared;
  final int maxCombo;
  final int blocksPlaced;
  final Duration playTime;
  final VoidCallback onPlayAgain;
  final VoidCallback onGoHome;

  const ZenSummaryOverlay({
    super.key,
    required this.score,
    required this.totalLinesCleared,
    required this.maxCombo,
    required this.blocksPlaced,
    required this.playTime,
    required this.onPlayAgain,
    required this.onGoHome,
  });

  @override
  State<ZenSummaryOverlay> createState() => _ZenSummaryOverlayState();
}

class _ZenSummaryOverlayState extends State<ZenSummaryOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnim = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes;
    final s = d.inSeconds % 60;
    return '${m}m ${s}s';
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: Container(
        color: Colors.black.withValues(alpha: 0.7),
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnim,
            child: Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
              constraints: const BoxConstraints(maxWidth: 380),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1A1A3E), Color(0xFF0D0D2B)],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C5CE7).withValues(alpha: 0.25),
                    blurRadius: 40,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Zen icon
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                          const Color(0xFFA29BFE).withValues(alpha: 0.15),
                        ],
                      ),
                    ),
                    child: const Text('🧘', style: TextStyle(fontSize: 40)),
                  ),
                  const SizedBox(height: 16),

                  // Title
                  Text(
                    'PHIÊN THIỀN KẾT THÚC',
                    style: GoogleFonts.fredoka(
                      color: const Color(0xFFA29BFE),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Play time highlight
                  Text(
                    _formatDuration(widget.playTime),
                    style: GoogleFonts.fredoka(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Thời gian thiền',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Stats grid
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _statItem(
                                '🏆',
                                '${widget.score}',
                                'Điểm',
                                const Color(0xFFFFD700),
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 48,
                              color: Colors.white.withValues(alpha: 0.1),
                            ),
                            Expanded(
                              child: _statItem(
                                '📦',
                                '${widget.blocksPlaced}',
                                'Khối đặt',
                                const Color(0xFF74B9FF),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 1,
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _statItem(
                                '✨',
                                '${widget.totalLinesCleared}',
                                'Hàng xóa',
                                const Color(0xFF55EFC4),
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 48,
                              color: Colors.white.withValues(alpha: 0.1),
                            ),
                            Expanded(
                              child: _statItem(
                                '🔥',
                                'x${widget.maxCombo}',
                                'Combo max',
                                const Color(0xFFFF6B6B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: _buildButton(
                          'Tiếp tục',
                          const Color(0xFF6C5CE7),
                          Icons.self_improvement,
                          widget.onPlayAgain,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildButton(
                          'Về Lobby',
                          const Color(0xFF2D3436),
                          Icons.home_rounded,
                          widget.onGoHome,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _statItem(String emoji, String value, String label, Color color) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.fredoka(
            color: color,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildButton(
    String label,
    Color bgColor,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: bgColor.withValues(alpha: 0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.fredoka(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
