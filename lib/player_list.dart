import 'package:flutter/material.dart';
import 'profile.dart';
import 'db_function.dart';

List<Profile> bestPlayers =[];
class  BestPlayerListPage extends StatefulWidget {
  const  BestPlayerListPage({super.key});

  @override
  State< BestPlayerListPage> createState() => _BestPlayerListPage();
}

class _BestPlayerListPage extends State<BestPlayerListPage> {
  bool _loaded = false; // used to show products list or progress bar

  void update(bool success, [String? message]) {
    setState(() {
      _loaded = true;
      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message ?? 'Failed to load data')),
        );
      }
    });
  }

  @override
  void initState() {
    // update data when the widget is added to the tree the first tome.
    getBestPlayer(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: !_loaded ? null : () {
              setState(() {
                _loaded = false; // show progress bar
                getBestPlayer(update); // update data asynchronously
              });
            }, icon: const Icon(Icons.refresh)),
          ],
          title: const Text('best 100 player'),
          centerTitle: true,
        ),
        // load products or progress bar
        body: _loaded ? const ShowProducts() : const Center(
            child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator())
        )
    );
  }
}

class ShowProducts extends StatelessWidget {
  const ShowProducts({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: bestPlayers.length,
        itemBuilder: (context, index) {
          return Column(children: [
            Container(
              color: index%2 == 0? Colors.blue[50]:Colors.blue[100],
              padding: EdgeInsets.all(5.0),
              width: width*0.9,
              child: Row(children: [
                SizedBox(width: width * 0.15,),
                // If the Text widget doesn't fit within the available space, it will flexibly adjust its size.
                Flexible(child:Text(bestPlayers[index].toString(), style: TextStyle(fontSize: width * 0.045))),
              ]),
            ),
            const SizedBox(height: 10.0)
          ]);
        });
  }
}