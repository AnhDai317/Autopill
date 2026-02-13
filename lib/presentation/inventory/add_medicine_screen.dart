import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddMedicineStockScreen extends StatefulWidget {
  const AddMedicineStockScreen({super.key});

  @override
  State<AddMedicineStockScreen> createState() => _AddMedicineStockScreenState();
}

class _AddMedicineStockScreenState extends State<AddMedicineStockScreen> {
  final Color primaryColor = const Color(0xFF137FEC);
  int _selectedIconIndex = 0;

  final List<Map<String, dynamic>> _medicineIcons = [
    {"label": "Viên nang", "icon": Icons.medication},
    {"label": "Viên tròn", "icon": Icons.circle},
    {"label": "Viên sủi", "icon": Icons.emergency},
    {"label": "Dạng tiêm", "icon": Icons.vaccines},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Nhập Thuốc Vào Kho',
          style: GoogleFonts.lexend(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField("Tên thuốc", "Ví dụ: Lisinopril"),
                _buildTextField(
                  "Loại bệnh / Công dụng",
                  "Ví dụ: Huyết áp, Tiểu đường",
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        "Số lượng nhập",
                        "Ví dụ: 40",
                        isNumber: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField("Đơn vị", "Viên, Gói, Tuýp"),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                _buildTextField(
                  "Cảnh báo khi còn lại ít hơn",
                  "Ví dụ: 10 (Hệ thống sẽ báo Sắp hết)",
                  isNumber: true,
                ),

                const SizedBox(height: 20),

                Text(
                  "Biểu tượng hiển thị",
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: _medicineIcons.length,
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedIconIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedIconIndex = index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? primaryColor.withOpacity(0.05)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? primaryColor
                                : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _medicineIcons[index]['icon'],
                              color: isSelected ? primaryColor : Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _medicineIcons[index]['label'],
                              style: GoogleFonts.lexend(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 120),
              ],
            ),
          ),

          // Nút Lưu thông tin (Sửa lỗi undefined method tại đây)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: ElevatedButton(
                onPressed: () {
                  // Logic lưu vào kho thuốc
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "LƯU VÀO KHO",
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.lexend(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: primaryColor, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
