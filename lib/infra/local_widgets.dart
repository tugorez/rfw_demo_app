import 'package:flutter/material.dart';
import 'package:rfw/rfw.dart';

LocalWidgetLibrary createLocalWidgets() =>
    LocalWidgetLibrary(_localWidgetLibrary);

final Map<String, LocalWidgetBuilder> _localWidgetLibrary = <String, LocalWidgetBuilder>{
  'FlutterLogo': (BuildContext context, DataSource source) {
    return FlutterLogo(size: source.v<double>(['size']));
  },
  'AnimatedAlign': (BuildContext context, DataSource source) {
    return AnimatedAlign(
      alignment: ArgumentDecoders.alignment(source, ['alignment'])!,
      duration: ArgumentDecoders.duration(source, ['duration'], context),
      child: source.child(['child']),
    );
  },
  'AnimatedDefaultTextStyle': (BuildContext context, DataSource source) {
    return AnimatedDefaultTextStyle(
      style: ArgumentDecoders.textStyle(source, ['style'])!,
      duration: ArgumentDecoders.duration(source, ['duration'], context),
      child: source.child(['child']),
    );
  },
  'AnimatedScale': (BuildContext context, DataSource source) {
    return AnimatedScale(
      scale: source.v<double>(['scale'])!,
      duration: ArgumentDecoders.duration(source, ['duration'], context),
      child: source.child(['child']),
    );
  },
  'TweenAnimationBuilder': (BuildContext context, DataSource source) {
    final double begin = source.v<double>(['begin'])!;
    final double end = source.v<double>(['end'])!;
    final int duration = source.v<int>(['duration'])!;
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: begin, end: end),
      duration: Duration(milliseconds: duration),
      builder: (BuildContext context, double value, Widget? child) {
        return source.builder(['builder'], <String, Object?>{'value': value});
      },
    );
  },
};
