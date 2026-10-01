import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

const List<String> list = <String>['Peliculas', 'Videojuegos', 'Libros'];

class DropdownMenuExample extends StatefulWidget{
  final Function(String) onChanged;
  
  const DropdownMenuExample({
    super.key,
    required this.onChanged
    });

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _DropdownMenuExampleState extends State<DropdownMenuExample>{
  static final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
    list.map<MenuEntry>((String name) => MenuEntry(value: name, label:name)),
  );
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context){
    return DropdownMenu<String>(
      initialSelection: list.first,
      onSelected: (String? value){
        setState(() {
          dropdownValue = value!;
        });
        widget.onChanged(value!);
      },
      dropdownMenuEntries: menuEntries,
    );
  }
}

