import 'dart:io';

// TODO: Change this to the flutter package name later on.
const String importStatement = "import 'package:androidrouting/visual_exact_button.dart';";
const String openDialog = "showDialog<void>";
const String importTest = 'package:flutter_test/flutter_test.dart';

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

  final lines = file.readAsLinesSync();
  bool containsImport = lines.any((line) => line.contains(importStatement));
  bool noOpenDialog = !lines.any((line) => line.contains(openDialog));
  bool containsTest = lines.any((line) => line.contains(importTest));
  bool isVisualExact = file.path.contains('visual_exact');
  bool modified = false;

  // print('noOpenDialog: $noOpenDialog');
  // print('isVisualExact: $isVisualExact');
  // print('containsTest: $containsTest');

  if (isVisualExact || noOpenDialog || containsTest) {
    // print('Skipping ${file.path}');
    return;
  }

  print('Processing ${file.path}...');

  print('containsImport: $containsImport');

  if (!containsImport) {
    // Add the import statement at the beginning of the file
    lines.insert(0, importStatement);
    modified = true;
  }

  // Find and process each showDialog function
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains(openDialog)) {
      final parentFunctionStart = findParentFunctionStart(lines, i);
      final parentFunctionEnd = findParentFunctionEnd(lines, i);

      print('parentFunctionStartLine (i = $parentFunctionStart): ${lines[parentFunctionStart]}');
      print('parentFunctionEndLine (i = $parentFunctionEnd): ${lines[parentFunctionEnd]}');

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
    if (lines[i].contains('onPopInvoked:')) {
      final onPopStart = i;
      final onPopEnd = findParentFunctionEnd(lines, i);

      for (int j = onPopStart; j < onPopEnd; j++) {
        if (lines[j].contains('didPop == true') || lines[j].contains('if (didPop')) {
          if (!lines.sublist(j, onPopEnd).any((line) => line.contains('dialogState.closeDialog('))) {
            lines.insert(j + 1, "dialogState.closeDialog();");
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
  // Reverse search to find the line where the function begins
  int openParenthesisCount = 0;
  int closeParenthesisCount = 0;
  int braceCount = 0;

  for (int i = startIndex; i >= 0; i--) {
    String line = lines[i];

    // Count the open and close parentheses
    openParenthesisCount += RegExp(r'\(').allMatches(line).length;
    closeParenthesisCount += RegExp(r'\)').allMatches(line).length;

    // If we are at the function signature line, it should have balanced parentheses
    if (openParenthesisCount > 0 && openParenthesisCount == closeParenthesisCount) {
      // Ensure the line has a function name and an opening brace `{`
      if (RegExp(r'^[a-zA-Z0-9_]+\s*\(').hasMatch(line)) {
        braceCount += RegExp(r'\{').allMatches(line).length;
        if (braceCount == 0) {
          // We found the function start
          return i;
        }
      }
    }

    // Look if this line is part of a function body
    braceCount += RegExp(r'\{').allMatches(line).length;
    braceCount -= RegExp(r'\}').allMatches(line).length;

    // If we've passed the function body without finding a function signature, we return this line
    if (braceCount < 0) {
      return i + 1;
    }
  }

  return 0; // Default to the start of the file if no function start is found
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