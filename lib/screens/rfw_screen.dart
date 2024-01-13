import 'package:flutter/material.dart';
import 'package:rfw/rfw.dart';
import 'package:rfw_demo_app/infra/runtime.dart';

class RfwScreen extends StatefulWidget {
  const RfwScreen({super.key});

  @override
  State<RfwScreen> createState() => _RfwScreenState();
}

class _RfwScreenState extends State<RfwScreen> {
  static const _mainLibrary = '''
    import core.widgets; 
    import material;

    widget Main = Container();
  ''';

  final _data = DynamicContent();
  final _runtime = createRuntime()..updateMainLibrary(_mainLibrary);

  @override
  Widget build(BuildContext context) {
    return RemoteWidget(
      runtime: _runtime,
      data: _data,
      widget: mainWidget,
    );
  }
}
