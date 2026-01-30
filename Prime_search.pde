// Read prime data from txt files
void getPrimeData() {
  String[] primeData = loadStrings("primes.txt");
  String[] primeBooleanData = loadStrings("prime booleans.txt");
  
  // If no primes in files
  if (primeData.length == 0) {
    // set initial values: 1 = composite, 2 = prime 
    primes.add(2);
    primeBooleans.add(false);
    primeBooleans.add(true);
  }
  
  // Read primes from files
  else {
    // add primes to arraylist
    for (int line = 0; line < primeData.length; line++) {
      primes.add(int(primeData[line]));
    }
    
    // add true or false to prime booleans arraylist
    for (int line = 0; line < primeBooleanData.length; line++) {
      String curBoolean = primeBooleanData[line];
      
      if (curBoolean.equals("T")) 
        primeBooleans.add(true);
      
      else
        primeBooleans.add(false);
    }
  } 
}

// Saves arraylist of primes and prime booleans to txt file
void savePrimeData() {
  PrintWriter pwPrime = createWriter("data/primes.txt");
  PrintWriter pwPB = createWriter("data/prime booleans.txt");
  
  // Add primes and prime booleans to arrays and txt file
  for (int i = 0; i < primeBooleans.size(); i++) {
    // number is prime
    if (primeBooleans.get(i)) {
      pwPrime.println(str(i+1));
      pwPB.println("T");
    }

    // number is not a prime
    else {
      pwPB.println("F");
    }
  }  
  
  pwPrime.close();
  pwPB.close();
}

// Sieve to find all primes up to n (inclusive)
void findPrimes(int n) {
  int primeSearchSoFar = primeBooleans.size(); // prime booleans already found up to this index
  
  // Sets prime booleans past prime search index as true
  for (int i = primeSearchSoFar+1; i <= n; i++)
    primeBooleans.add(true);
  
  // Find composites for each known prime 
  for (int p: primes) {    
    findComposites(p, primeSearchSoFar, n);
  }
    
  // Finds primes in the new portion of the list and finds their composites
  if (primeSearchSoFar <= sqrt(n)) {
    for (int i = primeSearchSoFar; i <= sqrt(n); i++) { 
      if (primeBooleans.get(i)) {
        findComposites(i+1, primeSearchSoFar, n);
      }
    }
  }
  
  // Add primes to arraylist 
  for (int i = primeSearchSoFar; i < n; i++) {
    // number is a prime
    if (primeBooleans.get(i))
      primes.add(i+1);
  }  
}

// Find composites by finding multiples of a known prime p
// Search from a range from pS (primes already searched up to) to n
void findComposites(int p, int pS, int n) {
  // Range of multipliers for the prime to eliminate composites 
  int minMultiplierToCheck = max(p, ceil(float(pS)/p)); 
  int maxMultiplierToCheck = floor(float(n)/p);
    
  // Calculate composite for each multiplier
  for (int i = minMultiplierToCheck; i < maxMultiplierToCheck+1; i++) {
    int comp = p*i; 
    primeBooleans.set(comp-1, false); // set position to false in prime booleans
  }
}
