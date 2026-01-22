import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomRoleCard extends StatefulWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final bool isSelected;


  const CustomRoleCard({super.key, required this.iconPath, required this.title, required this.subtitle,  this.isSelected = false });

  @override
  State<CustomRoleCard> createState() => _CustomRoleCardState();
}

class _CustomRoleCardState extends State<CustomRoleCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final Color activeColor = Theme.of(context).colorScheme.primary;
    final Color inactiveColor = Theme.of(context).colorScheme.onSurface;

    return Container(
      width: screenWidth * 0.45,
      height: 160,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.isSelected ? activeColor : inactiveColor,
          width: widget.isSelected ? 2 : 1
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? activeColor.withOpacity(0.15)
                    : inactiveColor.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                width: 24,
                height: 24,
                widget.iconPath,
                colorFilter: ColorFilter.mode(
                    widget.isSelected ? activeColor : inactiveColor,
                    BlendMode.srcIn
                ),
              ),
            ),
            const SizedBox(height: 12,),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8,),
            Text(
              widget.subtitle,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface)
            )
          ],
        ),
      ),
    );
  }
}
