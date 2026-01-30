// LIBRARIES
import g4p_controls.*;

// VARIABLES
// Prime variables
ArrayList<Integer> primes; // stores known primes
ArrayList<Boolean> primeBooleans; // stores booleans for each positive int that return true if prime, false if not

// Box count variables
ArrayList<NumberBox> boxes; // boxes in the spiral
int numCount; // # of boxes to be displayed
int updateLimit; // # of boxes that need to be updated and have full prime data

// Spiral variables
int boxSize; // size of each box
String spiralShape; // shape of spiral
boolean showLabels; // whether boxes are labelled with numbers

// Polynomial variables
int[] polynomial; // coefficients for polynomial function with integer inputs, polynomial outputs are highlighted in the spiral
ArrayList<Integer> curOutputs; // outputs of polynomial in the range of the spiral numbers
boolean hlPrimes, hlNonPrimes; // whether outputs that are primes or nonprimes are highlighted

// Colour variables
// used when numbers are highlighted by the polynomial
color hlPrimeColour = color(255, 55, 0); // for primes 
color hlNonPrimeColour = color(170, 200, 250); // for non primes

// Screenshot variable
boolean takeScreenshot = false; // whether to take a screenshot after draw loop

void setup() {
  // GUI settings
  createGUI();
  infoWindow.setVisible(false);
  
  // Main window settings
  size(600, 600);
  strokeWeight(0);
  textAlign(CENTER, CENTER);

  // Initialize primes
  primes = new ArrayList<Integer>();
  primeBooleans = new ArrayList<Boolean>();
  getPrimeData();
  
  // Initialize polynomial
  polynomial = new int[] {4, 0, 0}; // default coefficients of polynomial

  // Initialize boxes
  boxes = new ArrayList<NumberBox>();
  getSettings();
  numCountSettings();
  highlightSettings();
}

void draw() {
  background(255);
  
  // Set update limit
  updateLimit = min(numCount, primeBooleans.size());
  
  // No spiral displayed (numCount is not positive)
  if (numCount <= 0) {
    numCountNotPositiveMessage();
  }

  // Square spiral
  if (spiralShape.equals("square")) {
    
    // No boxes displayed (box size will be 0)
    if (numCount > 358801) {
      numCountExceededMessage("square");
    }
    
    // Display boxes
    else {
      for (int i = 0; i < updateLimit; i++)
        boxes.get(i).squareBoxDisplay();
    }
  }

  // Triangle spiral
  else if (spiralShape.equals("triangle")) {
    // No boxes displayed (box size will be 0)
    if (numCount > 357604) {
      numCountExceededMessage("triangle");
    }
    
    // Display boxes
    else {
      for (int i = 0; i < updateLimit; i++)
        boxes.get(i).triangleBoxDisplay();
    }
  }
  
  // Hexagon spiral
  else {
    // No boxes displayed (box size will be 0)
    if (numCount > 89269) {
      numCountExceededMessage("hexagon");
    }
    
    // Display boxes
    else {
      for (int i = 0; i < updateLimit; i++)
        boxes.get(i).hexagonBoxDisplay();
    }
  }

  // Display labels
  if (showLabels && numCount <= 2025) {
    for (int i = 0; i < updateLimit; i++) {
      boxes.get(i).labelDisplay();
    }
  }
  
  // Take screenshot
  if (takeScreenshot) {
    saveFrame("Screenshots/" + year() + "-" + month() + "-" + day() + "-" + hour() + "." + minute() + "." + second() + ".png");
    takeScreenshot = false;
  }
}
