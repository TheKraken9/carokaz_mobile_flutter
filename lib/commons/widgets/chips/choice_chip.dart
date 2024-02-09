import 'package:flutter/material.dart';
import 'package:mada_jeune/commons/widgets/custom_shapes/containers/circular_container.dart';
import 'package:mada_jeune/utils/constants/color.dart';
import 'package:mada_jeune/utils/helpers/helper_functions.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = THelperFunctions.getColor(text);
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor == null ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? TColors.white : TColors.black),
        avatar: isColor == null ? TCircularContainer(width: 50, height: 50,backgroundColor: THelperFunctions.getColor(text)!) : null ,
        shape: isColor == null ? const CircleBorder() : null,
        labelPadding: isColor == null ? const EdgeInsets.all(0) : null,
        padding: isColor == null ? const EdgeInsets.all(0) : null,
        backgroundColor: isColor == null ? THelperFunctions.getColor(text) : null
      ),
    );
  }
}
