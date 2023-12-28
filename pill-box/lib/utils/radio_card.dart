import 'package:flutter/material.dart';

class RadioCard extends StatelessWidget {
  const RadioCard(
      {Key? key, this.onTap, required this.active, required this.text})
      : super(key: key);
  final bool active;
  final VoidCallback? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(text,
              style: TextStyle(
                  color: (active) ? Color(0xffC4CACF) : Colors.black,
                  fontSize: (active) ? 15 : 15,
                  fontWeight: (active) ? FontWeight.bold : FontWeight.bold)),
          height: 44,
          decoration: BoxDecoration(
            // border: Border.all(
            //     color: (active)
            //         ? Theme.of(context).colorScheme.secondary
            //         : Theme.of(context).colorScheme.secondaryContainer,
            //     width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
        ));
  }
}
