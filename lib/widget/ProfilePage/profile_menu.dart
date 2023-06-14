import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:travel_app/values/custom_text.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onPress,
        leading: Container(
          width: 30,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color(0xFF001BFF).withOpacity(0.1),
          ),
          child: Icon(icon, color: Color(0xFF001BFF)),
        ),
        title: CustomText(
            text: title,
            color: Colors.black,
            fontSize: 21,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
            height: 1.2),
        trailing: endIcon
            ? Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: Icon(LineAwesomeIcons.angle_right,
                    size: 18.0, color: Colors.grey))
            : null);
  }
}
