void mouseClicked() {
  int col = int((mouseX - padding)/cellSize);
  int row = int((mouseY - padding)/cellSize);
  cellsNext[row][col] = color(255,255,0);;
  
     
}
