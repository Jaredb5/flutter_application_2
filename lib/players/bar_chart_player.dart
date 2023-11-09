import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'player_model.dart'; 

class BarChartSamplePlayer extends StatelessWidget {
  final Player player;
  final String dataType; 

  BarChartSamplePlayer({required this.player, required this.dataType});

  @override
  Widget build(BuildContext context) {
    double maxY = player.appearances_overall.toDouble(); 
    List<BarChartGroupData> barGroups = [];

    if (dataType == 'goals') {
      maxY = player.appearances_overall.toDouble();
      barGroups = [
          BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              y: player.goalsOverall.toDouble(),
              colors: [Colors.purple],
              width: 22,
              borderRadius: BorderRadius.circular(0),
            ),
          ],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              y: player.goalsHome.toDouble(),
              colors: [Colors.blue],
              width: 22,
              borderRadius: BorderRadius.circular(0),
            ),
          ],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              y: player.goalsAway.toDouble(),
              colors: [Colors.orange],
              width: 22,
              borderRadius: BorderRadius.circular(0),
            ),
          ],
        ),
      ];
    } else if (dataType == 'assists') {
      maxY = player.assistsOverall.toDouble();
      barGroups = [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              y: player.assistsHome.toDouble(),
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
              y: player.assistsAway.toDouble(),
              colors: [Colors.pink],
              width: 22,
              borderRadius: BorderRadius.circular(0),
            ),
          ],
        ),
      ];
    } else if (dataType == 'yellowCards') {
      maxY = player.yellowCardsOverall.toDouble();
      barGroups = [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              y: player.yellowCardsOverall.toDouble(),
              colors: [Colors.amber],
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
    titlesData: _buildTitlesData(dataType),
    barTouchData: BarTouchData(
      touchTooltipData: BarTouchTooltipData(
        tooltipBgColor: Colors.blueGrey,
        getTooltipItem: (BarChartGroupData group, int groupIndex, BarChartRodData rod, int rodIndex) {
          const textStyle = TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          );
          return BarTooltipItem(rod.y.toString(), textStyle);
        },
      ),
      touchCallback: (barTouchResponse) {
      },
      enabled: true,
    ),
    gridData: FlGridData(show: false),
    borderData: FlBorderData(show: false),
  ),
);
  }

  FlTitlesData _buildTitlesData(String dataType) {
    return FlTitlesData(
      bottomTitles: SideTitles(
        showTitles: true,
        getTextStyles: (context, value) => const TextStyle(
          color: Color(0xff7589a2),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        margin: 16,
        getTitles: (double value) {
          if (dataType == 'goals') {
            switch (value.toInt()) {
              case 0:
                return 'Total Goles';
              case 1:
                return 'Goles Casa';
              case 2:
                return 'Goles Visitante';  
              default:
                return '';
            }
          } else if (dataType == 'assists') {
            switch (value.toInt()) {
              case 0:
                return 'Asistencias en Casa';
              case 1:
                return 'Asistencias de Visitante';
              default:
                return '';
            }
          } else if (dataType == 'yellowCards') {
            return 'Tarjetas Amarillas';
          } else {
            return '';
          }
        },
      ),
      leftTitles: SideTitles(
        showTitles: true,
        getTextStyles: (context, value) => const TextStyle(
          color: Color(0xff7589a2),
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
        margin: 10,
        reservedSize: 28,
        getTitles: (value) {
          return '$value';
        },
      ),
      topTitles: SideTitles(showTitles: false),
      rightTitles: SideTitles(showTitles: false),
    );
  }
}
