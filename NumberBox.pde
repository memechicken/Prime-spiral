// NUMBER BOX - represents each number as a shape in the spiral
class NumberBox {
  // Fields
  int num; // value of number
  int size; // size (side length) of box
  PVector pos; // center coordinates of box
  boolean isPrime; // whether number is prime
  boolean isHighlighted; // whether number is highlighted by the current polynomial
  color fillColour; // colour of filled box
  color textColour; // colour of box text label
  boolean pointingUp; // orientation of box (only for triangle shaped box)
  
  // Constructor
  NumberBox(int n, boolean iP) {
    this.num = n;
    this.size = 1;
    this.pos = new PVector(0,0);
    this.isPrime = iP;
    this.isHighlighted = false;
    
    // black box and white text for primes
    if (this.isPrime) {
      this.fillColour = 0;
      this.textColour = 255; 
    }
    
    // white box and black text for non-primes
    else {
      this.fillColour = 255;
      this.textColour = 0; 
    } 
  }
  
  // Methods 
  
  // Draw box as a square
  void squareBoxDisplay() {         
    fill(this.fillColour);
    square(this.pos.x-this.size/2, this.pos.y-this.size/2, this.size);
  }
  
  // Draw box as a triangle
  void triangleBoxDisplay() {
    float s = this.size; // triangle side length
    float h = (sqrt(3)/2)*s; // triangle height
    
    fill(this.fillColour);
    
    if (this.pointingUp) {
      triangle(this.pos.x - s/2, this.pos.y + h/3, this.pos.x + s/2, this.pos.y + h/3, this.pos.x, this.pos.y - 2*h/3);
    }
      
    else {
      triangle(this.pos.x - s/2, this.pos.y - h/3, this.pos.x + s/2, this.pos.y - h/3, this.pos.x, this.pos.y + 2*h/3);
    }
  }

  // Draw box as a hexagon
  void hexagonBoxDisplay() {
    fill(this.fillColour);
    float angle = 2*PI/6; // 60 degree angle 
    
    // create hexagon with increasing angles
    beginShape();
      for (float a = 0; a < 2*PI; a += angle) {
        float pointX = this.pos.x + cos(a)*this.size;
        float pointY = this.pos.y + sin(a)*this.size;
        vertex(pointX, pointY);
      }
    endShape(CLOSE);
  }

  // Draw box labels
  void labelDisplay() {
    fill(this.textColour);
    text(str(this.num), this.pos.x, this.pos.y);
  }
  
  // Update box position and size for square spiral
  void posSquareUpdate(PVector prevPos, int bS) { // inputs previous box position and box size
    this.size = bS; // set box size
    
    // The top left corners of the spiral are always even perfect squares, bottom right corners are always odd perfect squares
    // Each interval of boxes between two consecutive squares consists of two perpendicular sides
    // Direction of spiral growth depends on whether the corner perfect square is even or odd 
    // Change in the box's position can be determined by the first corner greater than the box
    
    int prevNum = this.num - 1; // uses previous number to determine change in position
    int sideLength = ceil(sqrt(prevNum)) - 1; 
    int minSquareAbove = int(pow(sideLength+1, 2)); // smallest perfect square >= previous number
    
    int posFromSquare = minSquareAbove - prevNum; // difference of previous number from the corner
    
    PVector posChange = new PVector(0, 0); // sets change in box position from previous position
    
    // min square is in the top left corner
    if (minSquareAbove % 2 == 0) {
      // shift left
      if (posFromSquare <= sideLength) 
        posChange.x -= this.size;
      
      // shift up
      else
        posChange.y -= this.size;
    }
    
    // min square is in the bottom right corner
    else {
      // shift right
      if (posFromSquare <= sideLength) 
        posChange.x += this.size;
      
      // shift down
      else
        posChange.y += this.size;
    }
    
    // update position
    this.pos.set(prevPos);
    this.pos.add(posChange);
  }

  // Update box position and size for triangle spiral
  void posTriangleUpdate(PVector prevPos, int bS) { // inputs previous box position and box size
    this.size = bS; // set box size
    float s = this.size; // triangle side length
    float h = (sqrt(3)/2)*s; // triangle height

    // Perfect squares lie on the corners of the triangle
    // Each square corresponds to a side or layer of the triangle
    
    int rootOfMinSquare = ceil(sqrt(this.num));
    int minSquareAbove = int(pow(rootOfMinSquare, 2)); // smallest perfect square >= number   

    int posFromSquare = minSquareAbove - this.num;  // number's difference from the perfect square      
    this.pointingUp = (posFromSquare % 2 == 1); // orientation of the box, alternates up and down in each layer
    
    PVector posChange; // how much the current position changes from the last box's position

    // box is in the top side of the triangle
    if (rootOfMinSquare % 3 == 0) {
      // box is first in side, shift up + right
      if (this.num == pow(rootOfMinSquare-1, 2)+1) {
        posChange = new PVector(-s/2, -h);
      }
      
      // shift slightly down + right
      else if (pointingUp) {
        posChange = new PVector(s/2, h/3);
      }
      
      // shift slightly up + right
      else {
        posChange = new PVector(s/2, -h/3);
      }
      
    }
    
    // box is in the right side of the triangle
    else if (rootOfMinSquare % 3 == 1) {
      // box is first in side, shift right
      if (this.num == pow(rootOfMinSquare-1, 2)+1) {
        posChange = new PVector(s, 0);
      }
      
      // shfit slightly down + left
      else if (pointingUp) {
        posChange = new PVector(-s/2, h/3);
      }
      
      // shift down
      else {
        posChange = new PVector(0, 2*h/3);
      }
      
    }
    
    // box is in the left side of the triangle
    else {
      // box is first in side, shift left + down
      if (this.num == pow(rootOfMinSquare-1, 2)+1) {
        posChange = new PVector(-s/2, h);
      }
      
      // shift up
      else if (pointingUp) {
        posChange = new PVector(0,-2*h/3);
      }
      
      // shift slightly up + left
      else {
        posChange = new PVector(-s/2, -h/3);
      }
    }
    
    // update position
    this.pos.set(prevPos);
    this.pos.add(posChange);
  }
  
  // Update box position and size for hexagon spiral
  void posHexagonUpdate(PVector prevPos, int bS) { // inputs previous box position and box size
    this.size = bS; // set box size
    float s = this.size; // hexagon side length
    float h = (sqrt(3)/2)*s; // height of an equilateral triangle in the hexagon
    
    PVector posChange; 
    int prevNum = this.num - 1; // use previous num to determine direction spiral grows in
    
    // Each hexagonal layer of the spiral finishes with a hex number 
    // The nth hex number is 3*n*(n+1)+1 -> 1,7,19,37,... (1 is the 0th hex number)
    
    // uses inequality 3*k*(k+1)+1 >= prevNum where k represents the kth hex number
    int k = ceil((-3 + sqrt(-3+12*prevNum))/6.0);
    
    int minHexAbove = 3*k*k + 3*k + 1; // smallest hex number greater than or equal to previous number
    
    int posFromHex = minHexAbove - prevNum; 
    int layerLength = 6*k; // number of boxes in each hexagonal layer
    int diff = layerLength - posFromHex; // difference between position from hex and layer length determines position change
    
    // shift right + down
    if (diff < k) 
      posChange = new PVector(3*s/2, h);
    
    // shift down
    else if (diff < 2*k) 
      posChange = new PVector(0, 2*h);
    
    // shift left + down
    else if (diff < 3*k) 
      posChange = new PVector(-3*s/2, h);
    
    // shift left + up
    else if (diff < 4*k) 
      posChange = new PVector(-3*s/2, -h);
    
    // shift up
    else if (diff < 5*k) 
      posChange = new PVector(0, -2*h);
    
    // shift right + up
    else 
      posChange = new PVector(3*s/2, -h);
    
    // update position
    this.pos.set(prevPos);
    this.pos.add(posChange);
  }
  
  // Updates highlight status and colours of the box
  void hlUpdate() {
    // change to highlighted colours
    if (this.isHighlighted) {
      if (this.isPrime) {
        this.fillColour = hlPrimeColour;
      }
      
      else {
        this.fillColour = hlNonPrimeColour;
      }
      
      this.isHighlighted = false; // removes highlight status after colours updated
    }
    
    // reset to default colours
    else {
      if (this.isPrime)
        this.fillColour = 0;
      
      else
        this.fillColour = 255;
    }
  }  
}
