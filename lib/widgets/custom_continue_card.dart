import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomContinueCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final Color? color;
  const CustomContinueCard({super.key, required this.iconPath, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 20,
            colorFilter: color != null ? ColorFilter.mode(color ?? Theme.of(context).colorScheme.primary, BlendMode.srcIn) : null
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
