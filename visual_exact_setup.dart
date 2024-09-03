import 'dart:io';

const String importStatement = "import 'package:androidrouting/visual_exact_button.dart';";

void main() {
  // Find all Dart files in the current directory and subdirectories
  final directory = Directory.current;
  final dartFiles = directory
      .listSync(recursive: true)
      .where((entity) => entity is File && entity.path.endsWith('.dart'));

  for (var file in dartFiles) {
    processDartFile(file as File);
  }

  print('Script execution completed.');
}

void processDartFile(File file) {
  print('Processing ${file.path}...');

  final lines = file.readAsLinesSync();
  bool containsImport = lines.any((line) => line.contains(importStatement));
  bool modified = false;

  if (!containsImport) {
    // Add the import statement at the beginning of the file
    lines.insert(0, importStatement);
    modified = true;
  }

  // Find and process each showDialog function
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains('showDialog(')) {
      final parentFunctionStart = findParentFunctionStart(lines, i);
      final parentFunctionEnd = findParentFunctionEnd(lines, i);

      if (!containsDialogOpen(lines, parentFunctionStart, parentFunctionEnd)) {
        final uniqueDialogName = generateDialogName();
        lines.insert(i, "dialogState.openDialog('$uniqueDialogName');");
        modified = true;
        i++; // Skip the newly inserted line to avoid processing it again
      }
    }
  }

  // Process onPopInvoked functions
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains('onPopInvoked(')) {
      final onPopStart = i;
      final onPopEnd = findParentFunctionEnd(lines, i);

      for (int j = onPopStart; j < onPopEnd; j++) {
        if (lines[j].contains('didPop == true')) {
          if (!lines.sublist(j, onPopEnd).any((line) => line.contains('dialog.closeDialog('))) {
            lines.insert(j + 1, "dialog.closeDialog();");
            modified = true;
            break;
          }
        }
      }
    }
  }

  if (modified) {
    file.writeAsStringSync(lines.join('\n'));
    print('Modified ${file.path}');
  }
}

int findParentFunctionStart(List<String> lines, int startIndex) {
  for (int i = startIndex; i >= 0; i--) {
    if (RegExp(r'^[a-zA-Z0-9_]+\s*\(.*\)\s*\{').hasMatch(lines[i])) {
      return i;
    }
  }
  return 0;
}

int findParentFunctionEnd(List<String> lines, int startIndex) {
  int openBraces = 0;

  for (int i = startIndex; i < lines.length; i++) {
    if (lines[i].contains('{')) openBraces++;
    if (lines[i].contains('}')) openBraces--;

    if (openBraces == 0) return i;
  }

  return lines.length - 1;
}

bool containsDialogOpen(List<String> lines, int start, int end) {
  return lines.sublist(start, end + 1).any((line) => line.contains('dialogState.openDialog('));
}

String generateDialogName() {
  return 'dialog_${DateTime.now().millisecondsSinceEpoch}';
}
