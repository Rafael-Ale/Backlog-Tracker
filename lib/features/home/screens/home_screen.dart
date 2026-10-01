import 'package:backlog/features/home/widgets/dropdown_menu.dart';
import 'package:backlog/features/home/widgets/item_cards.dart';
import 'package:backlog/features/home/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:backlog/features/home/models/item.dart';

//Punto de entrada de la App. Flutter llama a runApp() para "montar" el widget raíz (MyApp) en la pantalla
void main() {
  runApp(const MyApp());
}

//Widget raíz de la aplicación. Es un StatelessWidget porque no necesita cambiar su propio estado, solo configura el MaterialApp.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Backlog Tracker', // nombre interno de la App (aparece en el multitarea de Android)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 97, 41, 193),
        ),
      ),
      home: const MyHomePage(), //Primera pantalla que se muestra
    );
  }
}

//Pantalla principal. Es un StatefulWidget porque su contenido (la lista de actividades) puede cambiar con el tiempo
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String categoriaSeleccionada = 'Peliculas';

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController plataformaController = TextEditingController();

  @override
  void dispose() {
    nombreController.dispose();
    plataformaController.dispose();
    super.dispose();
  }

  List<Item> itemList = [
    Item(
      //Juegos
      title: "Dark Souls",
      subtitle: "Steam",
      completado: false,
      icon: Icons.sports_esports,
    ),
    Item(
      //library books
      title: "El fin de la eternidad",
      subtitle: "Físico",
      completado: false,
      icon: Icons.library_books,
    ),
    Item(
      //peliculas
      title: "El resplandor",
      subtitle: "HBO",
      completado: false,
      icon: Icons.movie_filter,
    ),
  ];

  IconData _iconoPorCategoria(String categoria) {
    if (categoria == 'Peliculas') return Icons.movie_filter;
    if (categoria == 'Videojuegos') return Icons.sports_esports;
    if (categoria == 'Libros') return Icons.library_books;
    return Icons.help_outline;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 97, 41, 193),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 97, 41, 193),
        foregroundColor: Colors.white,
        title: const Center(child: Text("Mis pendientes")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  final currentItem = itemList[index];
                  return Dismissible(
                    background: Container(color: Colors.deepPurple),
                    key: ObjectKey(currentItem),
                    onDismissed: (DismissDirection direction) {
                      final itemBorrado = itemList[index];
                      setState(() {
                        itemList.removeAt(index);
                      });
                      ScaffoldMessenger.of(context)
                          .clearSnackBars(); 
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('"${itemBorrado.title}" eliminado'),
                          duration: const Duration(seconds: 3),
                          action: SnackBarAction(
                            label: 'Deshacer',
                            onPressed: () {
                              setState(() {
                                itemList.insert(index, itemBorrado);
                              });
                            },
                          ),
                        ),
                      );
                    },
                    child: ItemInteractiveCard(item: currentItem),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 16),
                FloatingActionButton.extended(
                  onPressed: () {
                    nombreController.clear();
                    plataformaController.clear();
                    categoriaSeleccionada = 'Peliculas';

                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Agregar pendiente"),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DropdownMenuExample(
                                onChanged: (String value) {
                                  categoriaSeleccionada = value;
                                },
                              ),
                              MyCustomForm(
                                nombreController: nombreController,
                                plataformaController: plataformaController,
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(context, 'Cancelar'),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              final nombre = nombreController.text.trim();
                              final plataforma =
                                  plataformaController.text.trim();
                              if (nombre.isNotEmpty) {
                                setState(() {
                                  itemList.add(
                                    Item(
                                      title: nombre,
                                      subtitle: plataforma.isEmpty ? categoriaSeleccionada: plataforma,
                                      completado: false,
                                      icon: _iconoPorCategoria(
                                          categoriaSeleccionada),
                                    ),
                                  );
                                });
                                      // El snackbar se muestra en la pantalla principal, no en el diálogo
      ScaffoldMessenger.of(this.context).clearSnackBars();
      ScaffoldMessenger.of(this.context).showSnackBar(
        SnackBar(
          content: Text('"$nombre" agregado'),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Deshacer',
            onPressed: () {
              setState(() {
                itemList.removeLast();
              });
            },
          ),
        ),
      );
                              }
                              Navigator.pop(context, 'OK');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  label: const Text('Agregar'),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}