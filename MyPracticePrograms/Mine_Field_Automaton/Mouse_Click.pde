void mouseClicked() {
  int col = int((mouseX - padding)/cellSize);
  int row = int((mouseY - padding)/cellSize);
  if (blue(cells[row][col]) == 255){
    cellsNext[row][col] = color(255,255,0);
  }
  print("h");
  copyNextCellsToCells();
  
  redraw();
}
