// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';
import 'teams_model.dart';
import 'team_detail.dart';
import 'team_search.dart';

class TeamsScreen extends StatelessWidget {
  final String year;
  final String supabaseUrl = 'https://eksgwihmgfwwanfrxnmg.supabase.co/storage/v1/object/public/Data/teams_csv'; // Usa tu URL de Supabase

  const TeamsScreen({required this.year, Key? key}) : super(key: key);

  Future<List<Team>> loadTeamsForYear(String year) async {
    var fileUrl = '$supabaseUrl/teams $year.csv';
    var response = await http.get(Uri.parse(fileUrl));

    if (response.statusCode == 200) {
      // Decodificar la respuesta como UTF-8
      final String csvString = utf8.decode(response.bodyBytes);
      List<List<dynamic>> csvData = const CsvToListConverter(fieldDelimiter: ';').convert(csvString);

      List<Team> allTeams = [];
      for (List<dynamic> row in csvData.skip(1)) { // Asumiendo que la primera fila es el encabezado
        allTeams.add(Team(
          commonName: row[0].toString(),
          season: int.tryParse(row[1].toString()) ?? 0,
          matches_played: int.tryParse(row[2].toString()) ?? 0,
          matches_played_home: int.tryParse(row[3].toString()) ?? 0,
          matches_played_away: int.tryParse(row[4].toString()) ?? 0,
          wins: int.tryParse(row[5].toString()) ?? 0,
          wins_home: int.tryParse(row[6].toString()) ?? 0,
          wins_away: int.tryParse(row[7].toString()) ?? 0,
          draws: int.tryParse(row[8].toString()) ?? 0,
          draws_home: int.tryParse(row[9].toString()) ?? 0,
          draws_away: int.tryParse(row[10].toString()) ?? 0,
          losses: int.tryParse(row[11].toString()) ?? 0,
          losses_home: int.tryParse(row[12].toString()) ?? 0,
          losses_away: int.tryParse(row[13].toString()) ?? 0,
          league_position: int.tryParse(row[14].toString()) ?? 0,
          goals_scored: int.tryParse(row[15].toString()) ?? 0,
          goals_conceded: int.tryParse(row[16].toString()) ?? 0,
          goals_difference: int.tryParse(row[17].toString()) ?? 0,
          total_goal_count: int.tryParse(row[18].toString()) ?? 0,
          corners_total: int.tryParse(row[19].toString()) ?? 0,
          corners_total_home: int.tryParse(row[20].toString()) ?? 0,
          corners_total_away: int.tryParse(row[21].toString()) ?? 0,
          cards_total: int.tryParse(row[22].toString()) ?? 0,
          cards_total_home: int.tryParse(row[23].toString()) ?? 0,
          cards_total_away: int.tryParse(row[24].toString()) ?? 0,
          // ... otros campos según tu modelo
        ));
      }
      return allTeams;
    } else {
      // Manejar el caso de error al cargar el archivo
      throw Exception('Failed to load team data from Supabase Storage for year $year');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipos $year'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final teams = await loadTeamsForYear(year);
              showSearch(
                context: context,
                delegate: TeamSearchDelegate(teams),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Team>>(
        future: loadTeamsForYear(year),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay equipos disponibles para este año.'));
          } else {
            List<Team> teams = snapshot.data!;
            return Scrollbar( 
              isAlwaysShown: true, 
              thickness: 6.0, 
              child: ListView.builder(
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  final team = teams[index];
                  return Card(
                    child: ListTile(
                      title: Text(team.commonName),
                      subtitle: Text('Temporada: ${team.season}'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => TeamDetailsScreen(team: team),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
