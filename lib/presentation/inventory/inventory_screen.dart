import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF137FEC);
    const backgroundLight = Color(0xFFF6F7F8);

    return SingleChildScrollView(
      child: Column(
        children: [
          // 1. Header Status
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              children: [
                Text(
                  'TÌNH TRẠNG KHO',
                  style: GoogleFonts.lexend(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Số lượng còn lại',
                  style: GoogleFonts.lexend(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF111418),
                  ),
                ),
                Text(
                  'Bạn có 2 loại thuốc sắp hết',
                  style: GoogleFonts.lexend(
                    color: const Color(0xFF617589),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // 2. Critical Section (Cần chú ý ngay)
          _buildSectionHeader(Icons.error, "CẦN CHÚ Ý NGAY", Colors.red),
          _buildMedicineStockCard(
            name: "Lisinopril 10mg",
            type: "Huyết áp",
            remaining: 12,
            total: 40,
            imageUrl:
                "https://lh3.googleusercontent.com/aida-public/AB6AXuC10kRfb3aN_VJ8YG1236zTGmFlnzPAfyI7ApdYre3nSPYwdFXRiNbRJiLBlDxptca0v0gN87SWioQYIWKUVXvBkgWuuliO9ZYnUgLwFZ9Wmxd-RWoAH_LxdPMhP7Ktj-qL0QP9DQ-feErx25bYafB4ED_DZzA0SIAVvXF5DIfa8GvCghk-AFaPAKAz1KEegaG9lNfdF-xQbGa_gvJwjecTmYWxcMEgXdyGev1SPHFqMeiymh1O5P9cs-xK-8y5jFZ2oSy_WuzkzvGG",
            statusLabel: "Sắp hết",
            footerText: "Mua lại mỗi 30 ngày",
            isWarning: true,
            primaryColor: primaryColor,
          ),
          _buildMedicineStockCard(
            name: "Metformin 500mg",
            type: "Tiểu đường",
            remaining: 5,
            total: 60,
            imageUrl:
                "https://lh3.googleusercontent.com/aida-public/AB6AXuBGXZb8yEOOSCInr8u-1NJDZS4fa9Sb_ziEDEQiUMZ0SavlWUGfj8SwdxEhF0XBPnjiX9BCV4gQjXcVVXhB4pOovpc0Sr8czYbVITlw2ruo7o9SiWI4RiW3-bVM9pDmcAYFlQMeMOjP1pIiBzrJHAZPCvud2SIgnZRbJ1i4WWxqBHWWQFl2cg85Bqu2Ers1bOyfVLYwQ-AcVOghPp_0SMjvUXg-MxhXmsaZwrllZu1BnWxrczRlHalDzo2UTCfhHnENSqAd3O1rPslE",
            statusLabel: "Sắp hết",
            footerText: "Trễ hạn mua 3 ngày",
            isWarning: true,
            primaryColor: primaryColor,
          ),

          // 3. Stable Section (Số lượng ổn định)
          const SizedBox(height: 16),
          _buildSectionHeader(
            Icons.check_circle,
            "SỐ LƯỢNG ỔN ĐỊNH",
            Colors.green,
          ),
          _buildMedicineStockCard(
            name: "Atorvastatin 20mg",
            type: "Mỡ máu",
            remaining: 85,
            total: 90,
            imageUrl:
                "https://lh3.googleusercontent.com/aida-public/AB6AXuDc0yj38p7joG3ozDDK-MUots8gJVRbv0RAOr718yu9VvM313fJvGpwjDRZ4V_EEM-x0o91g09sLg_KD8c57JIH3nv-m4DYx4Rs19AYm7fE8F4xM-EdfOJAA7WvvQ9f5wfkNVRgJeuFBjS0GLxj4b3lRXvAH3j8N2yqqvItsjcGnNCCnapL0Bj-B6xrgEPLMTePUQgLRiwUjFn4HZcAteKn61pv_ezKWDtSxG8sbwek4MUHx8U3V38bLmsaWL3p6-jAZ7XU4gwkVORb",
            footerText: "Đã mua lần cuối 1 tháng trước",
            isWarning: false,
            primaryColor: primaryColor,
          ),

          const SizedBox(height: 100), // Khoảng trống tránh bị Bottom Nav che
        ],
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF111418),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicineStockCard({
    required String name,
    required String type,
    required int remaining,
    required int total,
    required String imageUrl,
    String? statusLabel,
    required String footerText,
    required bool isWarning,
    required Color primaryColor,
  }) {
    double progress = remaining / total;
    Color statusColor = isWarning ? Colors.red : Colors.green;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ảnh thuốc
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.lexend(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          type,
                          style: GoogleFonts.lexend(
                            color: const Color(0xFF617589),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    if (statusLabel != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          statusLabel.toUpperCase(),
                          style: GoogleFonts.lexend(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                // Progress Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Số lượng còn lại",
                      style: GoogleFonts.lexend(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "$remaining/$total viên",
                      style: GoogleFonts.lexend(
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 16),
                // Footer & Button
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      footerText,
                      style: GoogleFonts.lexend(
                        color: const Color(0xFF617589),
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        shape: const StadiumBorder(),
                        elevation: 0,
                      ),
                      child: const Text("Mua thêm"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
