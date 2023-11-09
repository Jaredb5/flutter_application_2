// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'teams_model.dart';

class BarChartSample extends StatelessWidget {
  final Team team;
  final String dataType; 

  BarChartSample({super.key, required this.team, required this.dataType});

  @override
  Widget build(BuildContext context) {
    // Inicialización de las variables
    List<BarChartGroupData> barGroups = [];
    double maxY;

    if (dataType == 'matches') {
      maxY = team.matches_played.toDouble();
      barGroups = [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              y: team.wins.toDouble(),
              colors: [Colors.green],
              width: 22,
              borderRadius: BorderRadius.circular(0),
            ),
          ],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              y: team.draws.toDouble(),
              colors: [Colors.amber],
              width: 22,
              borderRadius: BorderRadius.circular(0),
            ),
          ],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              y: team.losses.toDouble(),
              colors: [Colors.red],
              width: 22,
              borderRadius: BorderRadius.circular(0),
            ),
          ],
        ),
      ];
    } else if (dataType == 'goals') {
      maxY = [team.goals_scored.toDouble(), team.goals_conceded.toDouble()].reduce((a, b) => a > b ? a : b);
      barGroups = [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              y: team.goals_scored.toDouble(),
              colors: [Colors.blue],
              width: 22,
              borderRadius: BorderRadius.circular(0),
            ),
          ],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              y: team.goals_conceded.toDouble(),
              colors: [Colors.orange],
              width: 22,
              borderRadius: BorderRadius.circular(0),
            ),
          ],
        ),
      ];
    } else if (dataType == 'corners'){
      maxY = team.corners_total.toDouble();
      barGroups = [
        BarChartGroupData(
          x : 0,
          barRods: [
            BarChartRodData(
              y : team.corners_total_home.toDouble(),
              colors: [Colors.pink],
              width: 22,
              borderRadius: BorderRadius.circular(0),
            ),
          ],
        ),
        BarChartGroupData(
          x : 1,
          barRods: [
            BarChartRodData(
              y : team.corners_total_away.toDouble(),
              colors: [Colors.yellow],
              width: 22,
              borderRadius: BorderRadius.circular(0),
            ),
          ],
        ),
      ];
    } else {
      maxY = 0;
      barGroups = [];
    }  
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
        barGroups: barGroups,
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff7589a2),
              fontWeight: FontWeight.bold,
              fontSize: 14
            ),
            margin: 16,
            getTitles: (double value) {
              if (dataType == 'matches') {
                switch (value.toInt()) {
                  case 0:
                    return 'Victorias';
                  case 1:
                    return 'Empates';
                  case 2:
                    return 'Derrotas';
                  default:
                    return '';
                }
              } else if (dataType == 'goals') {
                switch (value.toInt()) {
                  case 0:
                    return 'Anotados';
                  case 1:
                    return 'Recibidos';
                  default:
                    return '';
                }
              } 
              else if(dataType == 'corners') {
                switch (value.toInt()){
                  case 0:
                    return 'Corners en casa';
                  case 1:
                    return 'Corners fuera'  ;
                  default:
                    return ''; 
                }

              }

              else  {
                return '';
              }
            },
          ),
          leftTitles: SideTitles(showTitles: false),
          topTitles: SideTitles(showTitles: false),
          rightTitles: SideTitles(showTitles: false),
        ),
        barTouchData: BarTouchData(
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}
