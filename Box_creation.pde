// BOX CREATION
// Create boxes for all integers from 1 to n
void createBoxes(int n) {   
  // only create for numbers that do not have boxes yet
  for (int i = boxes.size() + 1; i <= n; i++) { 
    boolean curIsPrime = false; // whether current box being created is prime, set to false
    
    // number is prime
    if (primeBooleans.get(i-1)) {
      curIsPrime = true; // set to true 
    }
    
    // create box in arraylist
    NumberBox curNumber = new NumberBox(i, curIsPrime);
    boxes.add(curNumber); 
  }
}

// BOX SIZE CALCULATION
// Calculate box size to fit screen for a square spiral
int squareSpiralBoxSize(int n) { // n integers
  // If the number of boxes in the spiral is an odd perfect square, a full square spiral is created
  
  int minSqrtAbove = ceil(sqrt(n)); // smallest number where its square > n
  int minOddSqrtAbove = minSqrtAbove + (minSqrtAbove + 1) % 2; // smallest odd number where its square > n
      
  return height/minOddSqrtAbove;
}

// Calculate box size (side length) for a triangle spiral 
int triangleSpiralBoxSize(int n) { // n integers
  // If the number of boxes in the spiral is a perfect square of the form (3k+1)^2, a full square spiral is created

  int minSqrtAbove = ceil(sqrt(n)); // smallest number where its square > n
  int minSqrtAbove_3kplus1 = minSqrtAbove; // smallest number of the form 3k+1 where its square > n
  
  if (minSqrtAbove % 3 == 0) {
    minSqrtAbove_3kplus1++;
  }
  
  else if (minSqrtAbove % 3 == 2) {
    minSqrtAbove_3kplus1 += 2;
  }
    
  return height/minSqrtAbove_3kplus1;
}

// Calculate box size (side length) for a hexagon spiral 
int hexagonSpiralBoxSize(int n) { // n integers
  // If the number of boxes in the spiral is a hex number (of the form 3*n*(n+1)+1), a full square spiral is created
  // kth hex number is the smallest hex number greater than or equal to n-1
  int k = ceil((-3 + sqrt(9+12*(n-1)))/6.0);
  
  // At n = hex number, the spiral height will be (2*k+1) hexagon box heights
  // Each hexagon box height is sqrt(3) times the box size
  // The screen height is divided by these factors to calculate box size
  
  return int(height/((2*k+1)*sqrt(3)));
}
