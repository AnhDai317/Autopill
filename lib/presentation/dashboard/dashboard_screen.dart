import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../shared/widgets/custom_app_bar.dart';
import '../shared/widgets/custom_bottom_nav.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF137FEC);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      appBar: const CustomAppBar(title: "Lịch Uống Thuốc"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildGoalCard(primaryColor),
            _buildTimelineHeader(primaryColor),
            _buildTimelineList(primaryColor),
            _buildStatBadges(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  // Widget: Thẻ mục tiêu (Đã bỏ phần trăm so với hôm qua)
  Widget _buildGoalCard(Color primaryColor) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: primaryColor.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MỤC TIÊU HÔM NAY',
                    style: GoogleFonts.lexend(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sắp hoàn thành!',
                    style: GoogleFonts.lexend(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              CircularPercentIndicator(
                radius: 45.0,
                lineWidth: 8.0,
                percent: 0.75,
                center: Text(
                  "75%",
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: primaryColor,
                  ),
                ),
                progressColor: primaryColor,
                backgroundColor: primaryColor.withOpacity(0.2),
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Đã uống 3/4 liều',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 12),
          LinearPercentIndicator(
            lineHeight: 16.0,
            percent: 0.75,
            backgroundColor: primaryColor.withOpacity(0.2),
            progressColor: primaryColor,
            barRadius: const Radius.circular(999),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineHeader(Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Thời gian biểu',
            style: GoogleFonts.lexend(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Thứ Hai, 23 Th10',
            style: GoogleFonts.lexend(
              color: primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineList(Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildTimelineItem(
            time: "08:00",
            name: "Lisinopril",
            desc: "10mg • Huyết áp cao",
            status: "Đã uống lúc 08:05",
            isTaken: true,
            icon: Icons.check,
            color: Colors.green,
          ),
          _buildTimelineItem(
            time: "12:00",
            name: "Metformin",
            desc: "500mg • Tiểu đường",
            status: "Uống sau khi ăn",
            isTaken: false,
            isCurrent: true,
            icon: Icons.medication,
            color: primaryColor,
          ),
          _buildTimelineItem(
            time: "20:00",
            name: "Atorvastatin",
            desc: "20mg • Mỡ máu",
            status: "Chưa đến giờ",
            isTaken: false,
            icon: Icons.schedule,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildStatBadges() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      child: Row(
        children: [
          _buildStatCard(
            "Chuỗi ngày",
            "12 Ngày",
            Icons.local_fire_department,
            Colors.blue,
          ),
          const SizedBox(width: 12),
          _buildStatCard(
            "Thuốc sắp hết",
            "3 Liều",
            Icons.warning,
            Colors.orange,
          ),
        ],
      ),
    );
  }

  // Các hàm phụ trợ (Helper Widgets) giữ nguyên logic nhưng làm sạch giao diện
  Widget _buildTimelineItem({
    required String time,
    required String name,
    required String desc,
    required String status,
    bool isTaken = false,
    bool isCurrent = false,
    required IconData icon,
    required Color color,
  }) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: isCurrent ? color : color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isCurrent ? Colors.white : color,
                  size: 24,
                ),
              ),
              Expanded(
                child: VerticalDivider(thickness: 3, color: Colors.grey[200]),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isCurrent ? Colors.white : Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(24),
                border: isCurrent
                    ? Border.all(color: color, width: 2)
                    : Border.all(color: Colors.grey[100]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.lexend(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isCurrent ? color : Colors.black87,
                        ),
                      ),
                      Text(
                        time,
                        style: GoogleFonts.lexend(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    desc,
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (isCurrent)
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        "ĐÃ UỐNG",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else
                    Row(
                      children: [
                        Icon(
                          isTaken ? Icons.verified : Icons.schedule,
                          color: isTaken ? Colors.green : Colors.grey,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          status,
                          style: TextStyle(
                            color: isTaken ? Colors.green : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String val, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  val,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: color,
                  ),
                ),
                Icon(icon, color: color, size: 28),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
