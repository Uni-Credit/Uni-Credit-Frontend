import 'dart:math';

// add min-max configuration default options
regulateTextSize({
  double? minSize,
  double? maxSize,
  required double regulatorSize,
}) {
  if (maxSize != null) {
    regulatorSize = min(maxSize, regulatorSize);
  }

  if (minSize != null) {
    regulatorSize = max(regulatorSize, minSize);
  }

  return regulatorSize;
}
