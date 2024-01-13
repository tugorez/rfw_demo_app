import 'package:flutter/material.dart';
import 'package:rfw/rfw.dart';
import 'package:rfw_demo_app/infra/runtime.dart';
import 'package:rfw_demo_app/infra/client.dart';

class RfwScreen extends StatefulWidget {
  const RfwScreen({super.key});

  @override
  State<RfwScreen> createState() => _RfwScreenState();
}

class _RfwScreenState extends State<RfwScreen> {
  static const _mainLibrary = '''
    import core.widgets; 
    import material;

    widget Main = Scaffold(
      appBar: AppBar(
        title: Text(text: 'RFW Demo App'),
      ),
      body: Center(
        child: Text(text: 'Loading...'),
      ),
    );
  ''';

  late final DynamicContent _data;
  late final Runtime _runtime;
  late final ApiClient _apiClient;

  @override
  void initState() {
    super.initState();
    _data = DynamicContent();
    _runtime = createRuntime()..updateMainLibrary(_mainLibrary);
    _apiClient = const ApiClient();
    _changeRoute('/');
  }

  @override
  Widget build(BuildContext context) {
    return RemoteWidget(
      runtime: _runtime,
      data: _data,
      widget: mainWidget,
      onEvent: _onEvent,
    );
  }

  Future<void> _onEvent(String name, DynamicMap arguments) async {
    if (name != 'changeRoute') return;
    print(arguments);
  }

  Future<void> _changeRoute(String path) async {
    final library = await _apiClient.fetchRfw(path);
    _runtime.updateMainLibrary(library);
  }
}
