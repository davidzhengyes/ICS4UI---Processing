void mouseClicked() {
  int col = int((mouseX - padding)/cellSize);
  int row = int((mouseY - padding)/cellSize);
  try{
    if (blue(cells[row][col]) == 255){
      cellsNext[row][col] = color(255,255,0);
      copyNextCellsToCells();
      redraw();
    }
  }
  catch (Exception e){
  }
  
  
}