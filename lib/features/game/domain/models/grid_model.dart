/// Represents the game grid.
/// Each cell value: 0 = empty, 1-8 = color index
class GridModel {
  final List<List<int>> cells;
  final int gridSize;

  const GridModel(this.cells, this.gridSize);

  /// Create an empty grid of given size
  factory GridModel.empty(int size) {
    return GridModel(List.generate(size, (_) => List.filled(size, 0)), size);
  }

  /// Create a deep copy
  GridModel copy() {
    return GridModel(
      cells.map((row) => List<int>.from(row)).toList(),
      gridSize,
    );
  }

  /// Get cell value at (row, col)
  int getCell(int row, int col) => cells[row][col];

  /// Check if cell is empty
  bool isEmpty(int row, int col) => cells[row][col] == 0;

  /// Check if position is within bounds
  bool inBounds(int row, int col) {
    return row >= 0 && row < gridSize && col >= 0 && col < gridSize;
  }

  /// Set a cell value (returns new GridModel for immutability)
  GridModel setCell(int row, int col, int value) {
    final newCells = copy().cells;
    newCells[row][col] = value;
    return GridModel(newCells, gridSize);
  }

  /// Count filled cells
  int get filledCount {
    int count = 0;
    for (final row in cells) {
      for (final cell in row) {
        if (cell != 0) count++;
      }
    }
    return count;
  }

  @override
  String toString() {
    return cells
        .map((row) => row.map((c) => c == 0 ? '.' : c.toString()).join(' '))
        .join('\n');
  }
}
