import 'package:cryptoapp/services/coingecko.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class PriceChart extends StatefulWidget {
  final String coinId;

  const PriceChart({super.key, required this.coinId});

  @override
  State<PriceChart> createState() => _PriceChartState();
}

class _PriceChartState extends State<PriceChart> {
  late Future<List<PricePoint>> _futureHistory;

  @override
  void initState() {
    super.initState();
    _futureHistory = CoinGeckoService.fetchPriceHistory(widget.coinId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PricePoint>>(
      future: _futureHistory,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 250,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Text('Failed to load chart'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Text('No data available'),
          );
        }

        final history = snapshot.data!;
        final spots = history.asMap().entries.map((e) {
          return FlSpot(e.key.toDouble(), e.value.price);
        }).toList();

        final minY = history.map((e) => e.price).reduce((a, b) => a < b ? a : b);
        final maxY = history.map((e) => e.price).reduce((a, b) => a > b ? a : b);

        return Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 17, 24, 39),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price Chart (7 Days)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 250,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                    minY: minY,
                    maxY: maxY,
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.blue.withOpacity(0.3),
                        ),
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
