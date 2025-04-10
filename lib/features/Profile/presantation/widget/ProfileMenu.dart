import 'package:coachyp/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFFF7643),
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: AppColors.s2,
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(Color(0xFFFF7643), BlendMode.srcIn),
              width: 22,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: AppColors.primary,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}