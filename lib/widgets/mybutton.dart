import 'package:flutter/material.dart';
import 'progressindicator.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.title,
      this.loading = false,
      this.color = Colors.teal,
      required this.onTap,
      this.isAbsorbed = false});

  final String title;
  final bool loading;
  final Color color;
  final bool isAbsorbed;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: AbsorbPointer(
        absorbing: isAbsorbed,
        child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: loading
                ? const SizedBox(
                    height: 50,
                    width: 50,
                    child: Center(
                        child: MyProgressIndicator(
                      strokewidth: 2,
                      begin: Colors.white,
                      end: Colors.black,
                    )),
                  )
                : Text(title, style: const TextStyle(fontSize: 20))),
      ),
    );
  }
}

class MyIconButton extends StatelessWidget {
  const MyIconButton(
      {super.key,
      required this.ontap,
      required this.icon,
      this.color = Colors.indigo});
  final VoidCallback ontap;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: ontap,
      icon: Icon(icon, color: color),
      iconSize: 35,
    );
  }
}
