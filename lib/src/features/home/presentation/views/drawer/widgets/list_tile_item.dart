import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListTileItem extends StatelessWidget {
  const ListTileItem({
    super.key,
    this.onTap,
    required this.title,
    required this.subTitle,
    required this.icon,
  });
  final void Function()? onTap;
  final String title;
  final String subTitle;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(
        fit: BoxFit.cover,
        icon,
        height: 30,
        width: 30,
      ),
      title: Text(title),
      subtitle: Text(subTitle),
    );
  }
}
