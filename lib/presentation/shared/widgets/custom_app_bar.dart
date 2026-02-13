import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onCalendarTap;

  const CustomAppBar({super.key, required this.title, this.onCalendarTap});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF137FEC);

    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.9),
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            "https://lh3.googleusercontent.com/aida-public/AB6AXuB0j58H_AtnRW9dhai0R-iVpT4oJBuHc5Fu82rybCjDWXHvNLi-9RNmE8BMZETQWVPrsj8of8bVFWqoxpm0fHGIrW0SLUjX-UQni04I4VgIOkGI0lhaWl9xZSjg3JadMYRn3WHAhO4tmlKPRxH6YacK7iFsX0mcR4nynnsTFSKDkrTvMo8TzzjUrD7_nSWTG_b76YALNpX7RGFr_7v0KncamROvhM3Dxa9MZeMUYLjKh_YAMGPS3OJ2SZj9Frnc_NbS39R91b3XNbvy",
          ),
          radius: 20,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.lexend(
          color: const Color(0xFF111418),
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      centerTitle: true,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.calendar_month, color: primaryColor),
            onPressed: onCalendarTap,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
