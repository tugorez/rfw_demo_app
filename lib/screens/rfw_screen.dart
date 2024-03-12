import 'package:flutter/material.dart';
import 'package:rfw/rfw.dart';
import 'package:rfw_demo_app/infra/runtime.dart';
import 'package:rfw_demo_app/infra/client.dart';

class RfwScreen extends StatefulWidget {
  const RfwScreen({super.key, required this.path, required this.widget});

  final String path;
  final String widget;

  @override
  State<RfwScreen> createState() => _RfwScreenState();
}

class _RfwScreenState extends State<RfwScreen> {
  static const _mainLibrary = '''
    import core.widgets;
    import material;

    widget Main = Scaffold(
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
    _changePath('/${widget.path}.rfwtxt');
  }

  @override
  Widget build(BuildContext context) =>
      _buildRemoteWidget(context, widget.widget);

  Widget _buildRemoteWidget(BuildContext context, String name) => RemoteWidget(
        runtime: _runtime,
        data: _data,
        widget: remoteWidget(name),
        onEvent: (String name, DynamicMap arguments) =>
            _onEvent(context, name, arguments),
      );

  void _onEvent(
    BuildContext context,
    String name,
    DynamicMap arguments,
  ) {
    if (name == 'navigator') {
      final List<Object?> actions = arguments['actions'] as List<Object?>;
      final NavigatorState navigator = Navigator.of(context);
      for (final Object? action in actions) {
        if (action is DynamicMap) {
          _navigate(navigator, action);
        }
      }
    }
  }

  void _navigate(NavigatorState navigator, DynamicMap action) {
    if (action['action'] == 'pop') {
      navigator.pop();
    } else if (action['action'] == 'showBottomModal') {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) =>
            _buildRemoteWidget(context, action['widget'] as String),
      );
    } else if (action['action'] == 'push') {
      final String path = action['path'] as String;
      final String widget = action['widget'] as String;

      navigator.push(MaterialPageRoute(
        builder: (_) => RfwScreen(
          path: path,
          widget: widget,
        ),
      ));
    }
  }

  Future<void> _changePath(String path) async {
    final library = await _apiClient.fetchRfw(path);
    _runtime.updateMainLibrary(library);
  }
}
