import 'package:rfw/rfw.dart';
import 'package:rfw/formats.dart' show parseLibraryFile;

const FullyQualifiedWidgetName mainWidget = FullyQualifiedWidgetName(
  _mainLibraryName,
  'Main',
);

Runtime createRuntime() => Runtime()
  ..update(const LibraryName(<String>['core', 'widgets']), createCoreWidgets())
  ..update(const LibraryName(<String>['material']), createMaterialWidgets());

extension UpdateMainLibrary on Runtime {
  void updateMainLibrary(String library) {
    update(_mainLibraryName, parseLibraryFile(library));
  }
}

const LibraryName _mainLibraryName = LibraryName(<String>['main']);
