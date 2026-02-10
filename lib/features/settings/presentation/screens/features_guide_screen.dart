import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grid_master/shared/widgets/animated_block_background.dart';

/// Features guide screen — explains all game features in Vietnamese
class FeaturesGuideScreen extends StatelessWidget {
  const FeaturesGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: Stack(
        children: [
          const AnimatedBlockBackground(),
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white70),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'FEATURES GUIDE',
                        style: GoogleFonts.fredoka(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _featureCard(
                          iconData: Icons.pause_circle_rounded,
                          title: 'Tạm Dừng (Pause)',
                          color: const Color(0xFF6C5CE7),
                          items: [
                            'Khi đang chơi, bấm nút ⏸ ở góc trái trên để tạm dừng',
                            'Game sẽ đóng băng hoàn toàn, nền mờ đi',
                            'Có 3 lựa chọn: Tiếp tục • Chơi lại • Về lobby',
                          ],
                        ),
                        _featureCard(
                          iconData: Icons.bar_chart_rounded,
                          title: 'Thống Kê (Statistics)',
                          color: const Color(0xFF00B894),
                          items: [
                            'Bấm nút STATS ở lobby để xem',
                            'Total games played',
                            'Total accumulated score',
                            'Total lines cleared',
                            'Total play time',
                            'Stats per game mode',
                            'Có thống kê riêng cho từng chế độ chơi',
                          ],
                        ),
                        _featureCard(
                          iconData: Icons.emoji_events_rounded,
                          title: 'Achievements',
                          color: const Color(0xFFFFD700),
                          items: [
                            '12 achievements to unlock',
                            'Play your first game → "First Steps"',
                            'Play 100 games → "Block Master"',
                            'Score 100/500/1000 in one game',
                            'Try all modes → "Explorer"',
                            'Clear 100/500 lines total',
                            'Play 30 min / 2 hours total',
                            'Unlocked automatically at game end!',
                            'Tự động mở khoá khi kết thúc mỗi ván!',
                          ],
                        ),
                        _featureCard(
                          iconData: Icons.share_rounded,
                          title: 'Share Score',
                          color: const Color(0xFF00CC76),
                          items: [
                            'Khi Game Over, bấm nút SHARE SCORE',
                            'Tự động sao chép điểm vào clipboard',
                            'Dán vào Zalo, Messenger, Facebook... để khoe!',
                            'Bao gồm: chế độ, điểm, kỷ lục, và badge NEW HIGH SCORE',
                          ],
                        ),
                        _featureCard(
                          iconData: Icons.policy_rounded,
                          title: 'Privacy Policy',
                          color: const Color(0xFF636E72),
                          items: [
                            'Vào Settings → cuộn xuống → Privacy Policy',
                            'Giải thích rõ dữ liệu thu thập & cách sử dụng',
                            'Game chỉ lưu: ID ẩn danh, tên hiển thị, điểm',
                            'Không bán hay chia sẻ dữ liệu cho bên thứ ba',
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Tip card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF6C5CE7).withValues(alpha: 0.15),
                                const Color(0xFFA29BFE).withValues(alpha: 0.08),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.lightbulb_rounded, size: 28, color: Color(0xFFFDCB6E)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Mẹo: Chơi nhiều chế độ khác nhau để mở khoá thành tựu "Explorer" và tăng thống kê nhanh hơn!',
                                  style: GoogleFonts.fredoka(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 13,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureCard({
    required IconData iconData,
    required String title,
    required Color color,
    required List<String> items,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            children: [
              Icon(iconData, size: 28, color: color),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.fredoka(
                    color: color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Items
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 4, left: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('•  ',
                        style: TextStyle(
                            color: color.withValues(alpha: 0.6),
                            fontSize: 14)),
                    Expanded(
                      child: Text(
                        item,
                        style: GoogleFonts.fredoka(
                          color: Colors.white.withValues(alpha: 0.75),
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
