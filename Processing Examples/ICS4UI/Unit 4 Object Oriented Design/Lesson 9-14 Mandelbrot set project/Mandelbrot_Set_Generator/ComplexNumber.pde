class ComplexNumber
{
  float realPart;
  float imagPart;

  ComplexNumber(float re, float im)
  {
    this.realPart = re;
    this.imagPart = im;
  }


  float absoluteValue()
  {
    return sqrt(this.realPart * this.realPart + this.imagPart * this.imagPart);
  }


  float absoluteValueSquared()
  {
    return this.realPart * this.realPart + this.imagPart * this.imagPart;
  }


  ComplexNumber conjugate()
  {
    return new ComplexNumber(realPart, -imagPart);
  }


  ComplexNumber add(ComplexNumber c)
  {
    float newRealPart;
    float newImagPart;

    newRealPart = this.realPart + c.realPart;
    newImagPart = this.imagPart + c.imagPart;

    return new ComplexNumber(newRealPart, newImagPart);
  }


  ComplexNumber subtract(ComplexNumber c)
  {
    float newRealPart;
    float newImagPart;

    newRealPart = this.realPart - c.realPart;
    newImagPart = this.imagPart - c.imagPart;

    return new ComplexNumber(newRealPart, newImagPart);
  }


  ComplexNumber scalarMultiply(float s)
  {
    return new ComplexNumber(s * realPart, s * imagPart);
  }


  ComplexNumber multiply(ComplexNumber c)
  {
    float newRealPart;
    float newImagPart;

    newRealPart = this.realPart * c.realPart - this.imagPart * c.imagPart;
    newImagPart = this.realPart * c.imagPart + this.imagPart * c.realPart;

    return new ComplexNumber(newRealPart, newImagPart);
  }


  ComplexNumber square()
  {
    return this.multiply(this);
  }


  ComplexNumber pow(int n) {
    ComplexNumber zn = this;

    for(int i=1; i < n; i++) {
      zn = zn.multiply(this);
    }

    return zn;
  }


  ComplexNumber reciprocal()
  {
    ComplexNumber zConjugate;
    float invAbsoluteValueSquared;

    zConjugate = this.conjugate();

    invAbsoluteValueSquared = 1 / this.absoluteValueSquared();

    return zConjugate.scalarMultiply( invAbsoluteValueSquared );
  }


  ComplexNumber divide(ComplexNumber c)
  {
    ComplexNumber inverseC = c.reciprocal();
    return this.multiply(inverseC);
  }


  ComplexNumber exp_complex()
  {
    float newRealPart;
    float newImagPart;

    float ea = exp(realPart);

    newRealPart = ea * cos(imagPart);
    newImagPart = ea * sin(imagPart);

    return new ComplexNumber(newRealPart, newImagPart);
  }


  ComplexNumber sin_complex()
  {
    ComplexNumber Minus_One = new ComplexNumber(-1, 0);
    ComplexNumber i = new ComplexNumber(0, 1);
    ComplexNumber iz, minus_iz, e_iz, e_minus_iz, oneOver2i;

    iz = i.multiply(this);
    e_iz = iz.exp_complex();

    minus_iz = iz.multiply(Minus_One);
    e_minus_iz = minus_iz.exp_complex();

    oneOver2i = new ComplexNumber(0, -.5);

    return e_iz.subtract(e_minus_iz).multiply(oneOver2i);
  }


  ComplexNumber cos_complex()
  {
    ComplexNumber i = new ComplexNumber(0, 1);
    ComplexNumber Minus_One = new ComplexNumber(-1, 0);
    ComplexNumber iz, minus_iz, e_iz, e_minus_iz, oneOver2;

    iz = i.multiply(this);
    e_iz = iz.exp_complex();

    minus_iz = iz.multiply(Minus_One);
    e_minus_iz = minus_iz.exp_complex();

    oneOver2 = new ComplexNumber(.5, 0);

    return e_iz.add(e_minus_iz).multiply(oneOver2);
  }


  void display() {

    String aString="", bString="";

    if(realPart == 0 && imagPart == 0)
      println("0");

    else {
      if(realPart==0)
        aString = "";
        
      else if(realPart==round(realPart))
        aString = Long.toString(round(realPart));
        
      else
        aString = Float.toString(realPart);

      if(imagPart==0)
        bString = "";
        
      else if(imagPart == 1 || imagPart == 1.0)
        bString = " + i";
        
      else if(imagPart == -1)
        bString = " - i";
        
      else if(imagPart==round(imagPart)) {
        if(imagPart > 0)
          bString = " + " + Long.toString(round(imagPart)) + "i";

        else
          bString = " - " + Long.toString(round(-imagPart)) + "i";
      } 
      
      else
        if(imagPart > 0)
          bString = " + " + imagPart + "i";

        else
          bString = " - " +(-imagPart) + "i";

      println( aString + bString );
    }
  }
}
