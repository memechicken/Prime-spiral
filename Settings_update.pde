// BOX UPDATE FUNCTIONS
// Update boxes for numCount changes
void numCountSettings() {
  int maxPrimeRange = min(numCount, 358801); // current range of primes needed in the spiral
  
  // If necessary for spiral, find primes 
  if (primeBooleans.size() < maxPrimeRange) {
    findPrimes(maxPrimeRange);
  }

  // Update limit only for boxes displayed with known prime data
  updateLimit = min(numCount, primeBooleans.size()); 
  
  // Create new boxes to update limit
  if (boxes.size() < numCount) {
    createBoxes(updateLimit);
  }
  
  // Update for square spiral
  if (spiralShape.equals("square")) {  
    if (numCount <= 358801) {
      // initial settings
      boxSize = squareSpiralBoxSize(numCount);
      textSize(boxSize/2.0);
      boxes.get(0).pos = new PVector(300, 300);
  
      for (int i = 1; i < updateLimit; i++) {
        boxes.get(i).posSquareUpdate(boxes.get(i-1).pos, boxSize);
      }
    }
  }

  // Update for triangle spiral
  else if (spiralShape.equals("triangle")) {
    if (numCount <= 357604) {
       // initial settings
      boxSize = triangleSpiralBoxSize(numCount);
      boxes.get(0).pos = new PVector(300, 220);
      textSize(boxSize/3.0);
  
      for (int i = 1; i < updateLimit; i++) {
        boxes.get(i).posTriangleUpdate(boxes.get(i-1).pos, boxSize);
      }
    }
  }

  // Update for hexagon spiral
  else {
    if (numCount <= 89269) {
      // initial settings
      boxSize = hexagonSpiralBoxSize(numCount);
      boxes.get(0).pos = new PVector(300, 300);
      textSize(boxSize/1.5);
  
      for (int i = 1; i < updateLimit; i++) {
        boxes.get(i).posHexagonUpdate(boxes.get(i-1).pos, boxSize);
      }
    }
  }
}

// Update highlighted boxes for polynomial and highlight checkbox changes
void highlightSettings() {
  curOutputs = polynomialOutputs(polynomial, numCount); // get all polynomial outputs

  // Highlight boxes from polynomial outputs
  for (int output : curOutputs) {
    if (output < updateLimit) {
      // number is prime
      if (boxes.get(output-1).isPrime) {
        if (hlPrimes)
          boxes.get(output-1).isHighlighted = true;
      } 
      
      // number is not a prime
      else {
        if (hlNonPrimes)
          boxes.get(output-1).isHighlighted = true;
      }
    }
  }
  
  // Update boxes
  for (int i = 1; i < updateLimit; i++) {
    boxes.get(i).hlUpdate();
  }
}

// Set GUI variables when demo button clicked
void setDemoSettings(int shape, String n, String b, String c) {
  spiralShapeList.setSelected(shape);
  numCountField.setText(n);
  polynomialBField.setText(b);
  polynomialCField.setText(c);
  hlPrimesBox.setSelected(true);
  hlNonPrimesBox.setSelected(true);
  showLabelsBox.setSelected(true);
}

// Get GUI variables to display
void getSettings() {
  spiralShape = spiralShapeList.getSelectedText();
  numCount = int(numCountField.getText());
  polynomial[1] = int(polynomialBField.getText());
  polynomial[2] = int(polynomialCField.getText());
  hlPrimes = hlPrimesBox.isSelected();
  hlNonPrimes = hlNonPrimesBox.isSelected();

  if (showLabelsBox.isSelected() && numCount <= 2025)
    showLabels = true;
  
  else 
    showLabels = false;
  
  numCountSettings();
  highlightSettings();
}
