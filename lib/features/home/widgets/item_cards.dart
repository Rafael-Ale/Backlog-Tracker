import 'package:backlog/features/details/screens/detail_screen.dart';
import 'package:backlog/features/home/models/item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ItemInteractiveCard extends StatefulWidget{
  final Item item;

  const ItemInteractiveCard({
    super.key,
    required this.item,
  });

  @override
  State<ItemInteractiveCard> createState() => _ItemInteractiveCardState();
}

class _ItemInteractiveCardState extends State<ItemInteractiveCard>{
  
  bool isCompleted = false;

  @override
  void initState(){
    super.initState();
    _cargarEstado();
  
  }
   
   Future<void> _cargarEstado() async{
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      isCompleted = prefs.getBool(widget.item.title) ?? false;  
    });
  }

    Future<void> _guardarEstado(bool value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(widget.item.title, value);
  }

  @override
    Widget build(BuildContext context){
      return Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.deepPurpleAccent,
    
        child: ListTile(
          leading: CircleAvatar(radius:30, child: Icon(widget.item.icon, size: 40, color: const Color.fromARGB(255, 71, 20, 214)) ),
          title: Text(widget.item.title, style: TextStyle(color: Colors.white),),
          subtitle: Text(widget.item.subtitle, style: TextStyle(color: Colors.grey)),
          onTap: (){
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailScreen(item:widget.item)
            ));
          },

          trailing: IconButton(
            onPressed: (){
              setState((){
                isCompleted = !isCompleted;
              });
              _guardarEstado(isCompleted);
            },
            icon: Icon(
              isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isCompleted ? Colors.deepPurple : const Color.fromARGB(255, 87, 18, 120),
            ),
          ),
        ),
      );
    }
}