import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'player_model.dart';

class LineChartSamplePlayer extends StatelessWidget {
  final Player player;
  final String dataType; 

  LineChartSamplePlayer({required this.player, required this.dataType});

  @override
  Widget build(BuildContext context) {
    List<LineChartBarData> lineBarsData = [];
    if (dataType == 'goals') {
      lineBarsData = [
        LineChartBarData(
          spots: [
            FlSpot(0, player.goalsHome.toDouble()),
            FlSpot(1, player.goalsAway.toDouble()),
          ],
          isCurved: true,
          colors: [Colors.blue],
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
        ),
      ];
    } else if (dataType == 'assists') {
      lineBarsData = [
        LineChartBarData(
          spots: [
            FlSpot(0, player.assistsHome.toDouble()),
            FlSpot(1, player.assistsAway.toDouble()),
          ],
          isCurved: true,
          colors: [Colors.green],
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(show: true),
        ),
      ];
    } else if (dataType == 'yellowCards') {

      lineBarsData = [
        LineChartBarData(
          spots: [
            FlSpot(0, player.yellowCardsOverall.toDouble()),
            FlSpot(1, player.yellowCardsOverall.toDouble()),
          ],
          isCurved: true,
          colors: [Colors.amber],
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
        ),
      ];
    } else {
      lineBarsData = [];
    }

    return LineChart(
      LineChartData(
        lineBarsData: lineBarsData,
        titlesData: _buildTitlesData(dataType),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: true),
      ),
    );
  }

  FlTitlesData _buildTitlesData(String dataType) {
    return FlTitlesData(
      bottomTitles: SideTitles(
        showTitles: true,
        getTitles: (value) {
          if (dataType == 'goals' || dataType == 'assists') {
            switch (value.toInt()) {
              case 0:
                return 'En Casa';
              case 1:
                return 'De Visitante';
              default:
                return '';
            }
          } else if (dataType == 'yellowCards') {
            return 'Total'; 
          } else {
            return '';
          }
        },
      ),
      leftTitles: SideTitles(showTitles: true),
    );
  }
}
