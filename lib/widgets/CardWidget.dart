import 'package:flutter/widgets.dart';
import 'package:dcdg/dcdg.dart';

class CardWidget extends StatelessWidget {
  final Color? color;
  final Widget? child;
  final Function()? onTap;

  CardWidget({super.key, this.color, this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: child,
        ));
  }
}