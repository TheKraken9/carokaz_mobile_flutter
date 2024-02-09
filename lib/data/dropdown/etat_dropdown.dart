import 'package:flutter/material.dart';

class DropDownEtat extends StatefulWidget{
  DropDownEtat({super.key, required this.onChanged});
  ValueChanged<String> onChanged = (String value) {};

  @override
  State<DropDownEtat> createState() => _DropDownEtatState();

}

class _DropDownEtatState extends State<DropDownEtat> {
  String? dropdownValue = "";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: DropdownMenu<int>(
            width: 250,
            controller: TextEditingController(text: dropdownValue ?? ""),
            enableFilter: true,
            requestFocusOnTap: true,
            leadingIcon: const Icon(Icons.search),
            label: const Text("Etat"),
            onSelected: (int? value) {
              setState(() {
                dropdownValue = value.toString();
                widget.onChanged(dropdownValue!);
              });
            },
            dropdownMenuEntries: const [
              DropdownMenuEntry<int>(
                value: 1,
                label: '1/10',),
              DropdownMenuEntry<int>(
                value: 2,
                label: '2/10',),
              DropdownMenuEntry<int>(
                value: 3,
                label: '3/10',),
              DropdownMenuEntry<int>(
                value: 4,
                label: '4/10',),
              DropdownMenuEntry<int>(
                value: 5,
                label: '5/10',),
              DropdownMenuEntry<int>(
                value: 6,
                label: '6/10',),
              DropdownMenuEntry<int>(
                value: 7,
                label: '7/10',),
              DropdownMenuEntry<int>(
                value: 8,
                label: '8/10',),
              DropdownMenuEntry<int>(
                value: 9,
                label: '9/10',),
              DropdownMenuEntry<int>(
                value: 10,
                label: '10/10',),
            ],
          ),
        ),
        Text(
          '$dropdownValue /10 *',
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}