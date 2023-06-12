import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/atech/models/patient_metrics.dart';
import 'package:framework/shared_widgets/listing/flexible_listing.dart';
import 'package:framework/shared_widgets/responsive/media_queries.dart';
import 'package:framework/shared_widgets/responsive/responsive.dart';

class MetricsList extends StatelessWidget {
  final PatientMetrics metrics;
  final DeviceOption<Axis>? listAxis;
  final bool metricItemSummarized;
  const MetricsList(
      {Key? key,
      this.listAxis,
      required this.metrics,
      this.metricItemSummarized = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.width;
    List<Widget> listOfWidgets = metrics.elements
        .map((metric) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: MetricItem(
                metric: metric,
                summarized: metricItemSummarized,
              ),
            ))
        .toList();
    Widget list = metricItemSummarized && isMobile()
        ? Wrap(
            children: listOfWidgets,
          )
        : FlexibleListing(
            deviceAxis: listAxis ?? DeviceOption(defaultResult: Axis.vertical),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: listOfWidgets,
          );

    return list;
  }
}

class MetricItem extends StatelessWidget {
  final Metric metric;
  final bool summarized;
  const MetricItem({
    super.key,
    required this.summarized,
    required this.metric,
  });

  @override
  Widget build(BuildContext context) {
    double size = summarized ? 48 : 58;

    if (summarized) {
      return ResponsiveWidget(
        mobile: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MetricName(
              metric: metric,
              summarized: summarized,
            ),
            MetricValue(
              textColor: metric.status.relatedColor(),
              metric: metric,
            )
          ],
        ),
        defaultWidget: MetricContainer(
          size: size,
          metricStatus: metric.status,
          child: FlexibleListing(
            deviceAxis: DeviceOption(defaultResult: Axis.vertical),
            children: [
              MetricName(
                metric: metric,
                summarized: summarized,
              ),
              MetricValue(metric: metric),
            ],
          ),
        ),
      );
    }

    return Row(
      children: [
        MetricContainer(
          size: size,
          metricStatus: metric.status,
          child: MetricValue(metric: metric),
        ),
        MetricName(
          metric: metric,
          summarized: summarized,
        ),
      ],
    );
  }
}

class MetricContainer extends StatelessWidget {
  final Widget child;
  final double size;
  final MetricStatus metricStatus;
  const MetricContainer(
      {Key? key,
      required this.child,
      required this.size,
      required this.metricStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: metricStatus.relatedColor(), width: 4),
          shape: BoxShape.circle),
      child: child,
    );
  }
}

class MetricValue extends StatelessWidget {
  const MetricValue({super.key, required this.metric, this.textColor});

  final Metric metric;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      metric.toString(),
      style: TextStyle(fontSize: 10, color: textColor),
    );
  }
}

class MetricName extends StatelessWidget {
  final bool summarized;
  const MetricName({
    super.key,
    this.summarized = false,
    required this.metric,
  });

  final Metric metric;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: summarized
          ? EdgeInsets.only(bottom: 8.0, top: 4)
          : EdgeInsets.only(left: 8),
      child: Text(
        summarized ? metric.abbreviation : metric.name,
        style: TextStyle(fontSize: summarized ? 8 : 12),
      ),
    );
  }
}
