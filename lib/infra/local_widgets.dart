import 'package:rfw/rfw.dart';

LocalWidgetLibrary createLocalWidgets() =>
    LocalWidgetLibrary(_localWidgetLibrary);

// Add your local widgets here.
final Map<String, LocalWidgetBuilder> _localWidgetLibrary =
    <String, LocalWidgetBuilder>{};
