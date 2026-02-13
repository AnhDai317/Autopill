import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SetupDoseScreen extends StatefulWidget {
  const SetupDoseScreen({super.key});

  @override
  State<SetupDoseScreen> createState() => _SetupDoseScreenState();
}

class _SetupDoseScreenState extends State<SetupDoseScreen> {
  final Color primaryColor = const Color(0xFF137FEC);
  TimeOfDay _selectedTime = const TimeOfDay(hour: 8, minute: 0);
  final List<String> _days = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
  final List<bool> _selectedDays = [true, true, true, true, true, true, true];

  // Giả lập danh sách thuốc lấy từ Kho
  final List<Map<String, dynamic>> _inventoryMedicines = [
    {
      "name": "Paracetamol 500mg",
      "desc": "Giảm đau (1 viên)",
      "icon": Icons.medication,
      "selected": false,
    },
    {
      "name": "Vitamin C",
      "desc": "Tăng đề kháng",
      "icon": Icons.emergency,
      "selected": false,
    },
    {
      "name": "Amlodipine 5mg",
      "desc": "Huyết áp (1/2 viên)",
      "icon": Icons.favorite,
      "selected": false,
    },
  ];

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

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
          'Thiết Lập Liều Uống',
          style: GoogleFonts.lexend(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Tên liều thuốc
            _buildSectionTitle("Tên liều thuốc"),
            _buildNameInput(),

            // 2. Chọn giờ nhắc ngay tại đây
            _buildSectionTitle("Đặt giờ nhắc"),
            _buildTimePickerCard(),

            // 3. Chọn ngày lặp lại
            _buildSectionTitle("Lặp lại vào"),
            _buildDayPicker(),

            // 4. Danh sách chọn thuốc
            _buildSectionTitle("Chọn các loại thuốc từ kho"),
            ...List.generate(
              _inventoryMedicines.length,
              (index) => _buildMedicineItem(index),
            ),
          ],
        ),
      ),
      // 5. Nút xác nhận cuối cùng
      bottomSheet: _buildBottomAction(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Text(
        title,
        style: GoogleFonts.lexend(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildNameInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        style: GoogleFonts.lexend(fontSize: 18),
        decoration: InputDecoration(
          hintText: "Ví dụ: Sau ăn sáng...",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildTimePickerCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.access_time_filled, color: primaryColor, size: 28),
              const SizedBox(width: 12),
              Text(
                _selectedTime.format(context),
                style: GoogleFonts.lexend(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: _pickTime,
            child: Text(
              "ĐỔI GIỜ",
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayPicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(7, (index) {
          bool isSelected = _selectedDays[index];
          return GestureDetector(
            onTap: () => setState(() => _selectedDays[index] = !isSelected),
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? primaryColor : Colors.grey.shade300,
                ),
              ),
              child: Center(
                child: Text(
                  _days[index],
                  style: GoogleFonts.lexend(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildMedicineItem(int index) {
    var med = _inventoryMedicines[index];
    return GestureDetector(
      onTap: () => setState(() => med['selected'] = !med['selected']),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: med['selected'] ? primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Checkbox(
              value: med['selected'],
              activeColor: primaryColor,
              onChanged: (v) => setState(() => med['selected'] = v!),
            ),
            const SizedBox(width: 8),
            Icon(med['icon'], color: primaryColor),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                med['name'],
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          "XÁC NHẬN THIẾT LẬP",
          style: GoogleFonts.lexend(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
