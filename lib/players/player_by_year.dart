import 'package:flutter/material.dart';
import '../players/players_screen.dart';

class YearSelectionScreenPlayers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const years = ['2013', '2014', '2015', '2016', '2017', '2018', '2019', '2020', '2021', '2022', '2023'];
    return Scaffold(
      appBar: AppBar(title: Text('Seleccionar Año de Jugadores')),
      body: ListView.builder(
        itemCount: years.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(years[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlayersScreen(year: years[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
