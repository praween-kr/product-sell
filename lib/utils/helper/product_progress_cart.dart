import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:oninto_flutter/utils/color_constant.dart';

import '../app_text.dart';

class _LineChart extends StatelessWidget {
  const _LineChart();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 15, right: 14),
          child: LineChart(
            sampleData1,
            duration: const Duration(milliseconds: 250),
          ),
        ),
        const Positioned(
          bottom: 0,
          right: 0,
          child: Icon(
            Icons.arrow_right_sharp,
            size: 34,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  LineChartData get sampleData1 => LineChartData(
      lineTouchData: lineTouchData1,
      gridData: gridData,
      titlesData: titlesData1,
      borderData: borderData,
      lineBarsData: lineBarsData1,
      minX: 0,
      maxX: 14,
      maxY: 4,
      minY: 0);

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: AppColor.grey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        show: false,
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [lineChartBarData1_1];

  /// Left Side levels of prices, currently, it's hidden
  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: false,
        interval: 1,
        reservedSize: 40,
      );
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1m';
        break;
      case 2:
        text = '2m';
        break;
      case 3:
        text = '3m';
        break;
      case 4:
        text = '5m';
        break;
      case 5:
        text = '6m';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  /// Bottom side leves of days/month/year, currenlty, it's hidden
  SideTitles get bottomTitles => SideTitles(
        showTitles: false,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('SEPT', style: style);
        break;
      case 7:
        text = const Text('OCT', style: style);
        break;
      case 12:
        text = const Text('DEC', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  ///
  FlGridData get gridData => FlGridData(
        show: true,
        getDrawingHorizontalLine: (value) {
          return const FlLine(color: Colors.transparent, strokeWidth: 0);
        },
        drawVerticalLine: true,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.grey,
            strokeWidth: 1,
          );
        },
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade400, width: 2),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: false,
        // isStepLineChart: true,
        isStrokeJoinRound: true,
        shadow: const Shadow(color: AppColor.appColor),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 1),
          colors: <Color>[Color(0xFFF5F401), Color(0xFFFF6D22)],
          tileMode: TileMode.mirror,
        ),
        barWidth: 10,
        isStrokeCapRound: true,
        aboveBarData: BarAreaData(),
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(
          show: false,
          color: Colors.white,
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color.fromARGB(201, 255, 108, 34),
              Color.fromARGB(29, 245, 245, 1)
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 1.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(9, 3),
          FlSpot(10, 2.8),
          FlSpot(12, 3.8),
        ],
      );
}

class ProductsProgressChart extends StatefulWidget {
  const ProductsProgressChart({super.key, this.header});
  final String? header;

  @override
  State<StatefulWidget> createState() => ProductsProgressChartState();
}

class ProductsProgressChartState extends State<ProductsProgressChart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 37),
              widget.header == null
                  ? const SizedBox.shrink()
                  : const Align(
                      alignment: Alignment.center,
                      child: AppText(
                        text: "Overview",
                        style: AppTextStyle.medium,
                        textSize: 15.0,
                        color: AppColor.blackColor,
                      ),
                    ),
              const SizedBox(height: 37),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 16, left: 6),
                  child: _LineChart(),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white.withOpacity(0.5),
            ),
            onPressed: () {
              setState(() {});
            },
          )
        ],
      ),
    );
  }
}
