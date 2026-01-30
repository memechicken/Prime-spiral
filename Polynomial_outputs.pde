// Find all outputs in the range 1 to n of a polynomial function ax^2+bx+c where a > 0 and a,b,c,x are integers
ArrayList<Integer> polynomialOutputs(int[] p, int n) { // array p represents the coefficients of the polynomial
  ArrayList<Integer> outputs = new ArrayList<Integer>();
  
  // Set polynomial coefficients to a, b, c
  int a = p[0];
  int b = p[1];
  int c = p[2];
  
  float[] roots = findRoots(a, b, c); // roots of polynomial
  
  int cI = 0; // current input in polynomial
  int cO = 0; // current output from polynomial

  // Has no real roots, since a > 0, function is always positive
  if (roots.length == 0) {
    float vertexX = -b/(2.0*a); // x-coord of the polynomial's vertex 
    cI = ceil(vertexX); // starting current input
  }
  
  // Has some real roots
  else {
    // finds largest root from first index and last index of roots array (works for 1 or 2 roots)
    float largestRoot = max(roots[0], roots[roots.length-1]); 
    cI = ceil(largestRoot); // starting current input
    
    // ensure current input will not produce a zero output
    if (cI == largestRoot) {
      cI++;
    }
  }

  while (true) {
    cO = p[0]*cI*cI + p[1]*cI + p[2]; // calculate ouput
    
    // end loop when outputs exceed n
    if (cO > n)
      break;
    
    // update output
    outputs.add(cO);
    cI++;
  }
      
  return outputs;
}

// Find array of roots for a polynomial ax^2+bx+c
float[] findRoots(int a, int b, int c) { // array p represents the coefficients of the polynomial
  float disc = b*b-4*a*c; // discriminant of quadratic
  
  // Positive discriminant (return two unique roots)
  if (disc > 0) {
    // calculate roots
    float root1 = (-b + sqrt(disc))/(2*a);
    float root2 = (-b - sqrt(disc))/(2*a);
    return new float[] {root1, root2};
  }
  
  // Zero discriminant (return one unique root)
  else if (disc == 0) {
    // calculate root
    float root = -b/(2.0*a);
    return new float[] {root};
  }
  
  // Negative discriminant (return no roots)
  else {
    return new float[] {};
  }
}
