// Message when inputted numCount is not positive
void numCountNotPositiveMessage() {
  textSize(80);
  fill(0);
  text("Must input a positive number of integers in the spiral", 25, 50, 550, 500);
}

// Message when inputted numCount is too high to display spiral
void numCountExceededMessage(String shape) {
  textSize(70);
  fill(0);
  text("Number of integers in the " + shape + " spiral requested is too high", 25, 50, 550, 500);
}
