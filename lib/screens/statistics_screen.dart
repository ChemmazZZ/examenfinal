import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/session_provider.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<SessionProvider>(context);
    final weeklyData = _calculateWeeklyProductivity(sessionProvider.sessions);
    
    // calculamos el maximo para ajustar la altura del grafico dinamicamente
    double maxMinutes = 0;
    for (var minutes in weeklyData) {
      if (minutes > maxMinutes) maxMinutes = minutes;
    }
    // si no hay datos, se pone un tope de 100 para que no falle
    if (maxMinutes == 0) maxMinutes = 100;
    // le damos un poco de aire arriba (top padding en el grafico)
    maxMinutes = maxMinutes * 1.2;

    return Scaffold(
      appBar: AppBar(title: const Text("Productividad Semanal")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Minutos totales de enfoque por día",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Acumulado Lun - Dom",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),
            
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: maxMinutes,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.blueGrey,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${rod.toY.round()} min',
                          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];
                          if (value.toInt() >= 0 && value.toInt() < days.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                days[value.toInt()],
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          // mostrar solo números enteros en el eje y
                          if (value % 20 == 0) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(fontSize: 12),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: true, drawVerticalLine: false),
                  barGroups: _generateBarGroups(weeklyData),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // tarjeta de resumen
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.insights, color: Colors.blue),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Esta semana has acumulado ${_sumTotal(weeklyData)} minutos de pura concentración.",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ----- LOGICA DE NEGOCIO PARA AGRUPAR DATOS -------

  // retorna una lista de 7 enteros (minutos) donde el índice 0 es Lunes y 6 es Domingo
  List<double> _calculateWeeklyProductivity(var sessions) {
    // inicializamos contadores a 0 para los 7 días
    List<double> weekMinutes = [0, 0, 0, 0, 0, 0, 0];

    final now = DateTime.now();
    // obtenemos el inicio de la semana actual (lunes)
    // subtract (weekday - 1) nos lleva al lunes de esta semana
    final startOfWeek = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7));

    for (var session in sessions) {
      final date = DateTime.parse(session.date);

      // verificamos si la sesión es de esta semana
      if (date.isAfter(startOfWeek) && date.isBefore(endOfWeek)) {
        // date.weekday devuelve: 1=Lunes al 7=Domingo
        // restamos 1 para que sea índice 0 a 6
        int dayIndex = date.weekday - 1;
        weekMinutes[dayIndex] += session.durationMinutes.toDouble();
      }
    }
    return weekMinutes;
  }

  // genera las barras visuales
  List<BarChartGroupData> _generateBarGroups(List<double> data) {
    return List.generate(7, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data[index],
            color: data[index] > 0 ? Colors.blueAccent : Colors.grey.shade300,
            width: 16,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: data.reduce((a, b) => a > b ? a : b) * 1.2, // Fondo gris sutil
              color: Colors.grey.shade100,
            ),
          ),
        ],
      );
    });
  }

  int _sumTotal(List<double> data) {
    return data.reduce((a, b) => a + b).toInt();
  }
}