import 'package:flutter/material.dart';

class MyCustomForm extends StatelessWidget {
  final TextEditingController nombreController;
  final TextEditingController plataformaController;

  const MyCustomForm({
    super.key,
    required this.nombreController,
    required this.plataformaController,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 16,
          ),
          child: TextFormField(
            controller: nombreController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Nombre del juego/libro/pelicula',
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 16,
          ),
          child: TextFormField(
            controller: plataformaController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Plataforma donde lo ves/juegas',
            ),
          ),
        ),
      ],
    );
  }
}