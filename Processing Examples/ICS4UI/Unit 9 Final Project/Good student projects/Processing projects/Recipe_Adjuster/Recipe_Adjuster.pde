// Program Name: Recipe Adjuster
// Programmer: Skylar Ji
// Purpose: This program allows you to choose a recipe from the list provided and scale and portion the ingredients 
// based on the customizable serving slider. The program also allows you to sort the ingridents in an increasing/decreasing
// order (i.e. by amount, excluding the ingredients that don't use cups, tsps or tbsps as their measurement such as eggs).
// If the portion sizes are super small, the measurements will be rounded to 1/8 tsp or 1/8 of an ingredient that doesn't
// use standard measurements of cups, tsps, and tbsps.


// HOW THE RECIPE ADJUSTER WORKS
// - reads the ingredients and their measurements from a recipe file
// - converts the ingredient measurements to improper fractions
// - scales the ingredients based on the number of preferred servings requested by the slider
// - sorts the ingredients using mergesort in an increasing or decreasing order by converting them all temporarily to teaspoons
// - converts the ingredients to any other standard measuring units if necessary (i.e. 16 tablespoons = 1 cup)
// - rounds the ingredients to the nearest 1/4 (or 1/8, see exceptions in the purpose section)
// - converts the ingredient measurements to mixed fractions for display

// gui controls
import g4p_controls.*;

// arraylists for ingredients with standard measurements, as well as "objects" --> ingredients w/out standard measurements
ArrayList<Ingredient> ingredients = new ArrayList<Ingredient>();
ArrayList<Ingredient> objects = new ArrayList<Ingredient>();

// ingredients are defaulted to be sorted in increasing order
String sorting = "incr";

// set to 1 initially but will be changed once the program starts
int origserving = 1;
int planserving = 1;

// scale that the recipe will be adjusted and the string that will display the instructions
Measurement scale = new Measurement(planserving, origserving, "scale");
String instructions;


// loads the recipe into the database (fills the arraylists and instructions string w/ values) based on their text file
void loadrecipe(Recipe r) {
  ingredients = new ArrayList<Ingredient>();
  objects = new ArrayList<Ingredient>();
  String[] recipe = loadStrings(r.filename);
  int instructioni = 0;
  
  for(int i = 0; i< recipe.length; i++) {
    
    String line = recipe[i];
    
    if (line.length() == 0) {
      instructioni = i;
      break;
    }    
    
    String[] items = line.split(" ");
    
    String word1 = items[1];
    String word2 = items[2];
    
    if (word1.equals("cup") || word1.equals("tbsp") || word1.equals("tsp")) {
      String[] fractionstr = items[0].split("/");
      Measurement measure;
      
      if (fractionstr.length == 2) {
        measure = new Measurement(int(fractionstr[0]), int(fractionstr[1]), word1); 
      }
      
      else {
        measure = new Measurement (int(fractionstr[0]), word1);
      }
      
      
      String name = "";
      for (int j = 2; j < items.length; j++) {
        name += " " + items[j];
      } 
      
      Ingredient ingred =  new Ingredient(measure, name);
      ingredients.add(ingred);     
    }
    
    else if (word2.equals("cup") || word2.equals("tbsp") || word2.equals("tsp")) {
      String[] fractionstr = items[1].split("/");
      Measurement measure = new Measurement(int(items[0]), int(fractionstr[0]), int(fractionstr[1]), word2); 
      
      String name = "";
      for (int j = 3; j < items.length; j++) {
        name += " " + items[j];
      } 
      
      Ingredient ingred =  new Ingredient(measure, name);      
      ingredients.add(ingred);    
    }
    
    else {
      String name = "";


      String[] fractionstr = items[1].split("/");
      Measurement measure;
      
      if (fractionstr.length == 2) {
        measure = new Measurement(int(items[0]), int(fractionstr[0]), int(fractionstr[1]), ""); 
      
        for (int j = 2; j < items.length; j++) {
          name += " " + items[j];
        }      
      }
      
      else {
        measure = new Measurement (int(items[0]), "");
        
        for (int j = 1; j < items.length; j++) {
          name += " " + items[j];
        }   
      }
      
      Ingredient ingred =  new Ingredient(measure, name);  
      objects.add(ingred);    
    } 
  }
  
 instructions = "";
 for(int i = instructioni+1; i< recipe.length; i++) { 
   String line = recipe[i]; 
   
   instructions += line;
   
   if (i != recipe.length - 1) {
     instructions += "\n\n";
   }
 
 }
}


// setup function
void setup() {
  createGUI();
  
  size(750,1000);
  background(245, 238, 220);
  rectMode(CENTER);
  imageMode(CENTER);
  PFont.list();


  stroke(135, 100, 69);
  fill(135, 100, 69);
  rect(550, 275, 325, 223);
  line(25, 100, 725, 100);
  
  PFont main = createFont("mainfont.otf", 64);
  textFont(main);
  textAlign(CENTER);
  textSize(64);
  loadallrecipes();
  noLoop();
}

// kickstarter function that draws the recipe to the screen
void draw() {
  drawrecipe();
}

// these are global variables so that the recipes can be accessed by any function
Recipe selected;
Recipe cupcakes, cookies, brownies;

// loads all of the available recipes in the database, defaulting the selected recipe to cupcakes when the program opens
void loadallrecipes() {
  PImage cupcakeImage = loadImage("cupcakes.jpeg"); 
  PImage cookieImage = loadImage("cookies.jpeg"); 
  PImage brownieImage = loadImage("brownies.jpeg"); 
  cupcakes = new Recipe("Vanilla Cupcakes", cupcakeImage, "cupcake_recipe.txt", 12);
  cookies = new Recipe("Chocolate Chip Cookies", cookieImage, "cookie_recipe.txt", 36);
  brownies = new Recipe("Fudgy Brownies", brownieImage, "brownie_recipe.txt", 9);
  selected = cupcakes;
  origserving = selected.origserving;
  planserving = selected.origserving;
  scale = new Measurement(planserving, origserving, "scale");
}


// body function that draws the recipe onto the main screen
void drawrecipe() {
  background(245, 238, 220);
  fill(135, 100, 69);
  rect(550, 275, 325, 223);
  line(25, 100, 725, 100);

  origserving = selected.origserving;
  scale = new Measurement(planserving, origserving, "scale");
  
  PFont main = createFont("mainfont.otf", 64);
  textFont(main);
  textAlign(CENTER);
  textSize(64);
  
  image(selected.image, 550, 275);
  
  textSize(64);
  text(selected.name, 375, 80);
  
  loadrecipe(selected);
  
  adjustingredients();
  printIngredients();


}


// prints the ingredients onto the screen
void printIngredients() {
  
  textSize(50);
  text("Ingredients", 190, 155);
  
  textAlign(LEFT);
  PFont sub;
  sub = loadFont("times.vlw");
  textFont(sub);
  
  textSize(20);
  int yvalue = 210;
  
  if (ingredients.size() != 0) {
    for (int i = 0; i < ingredients.size(); i++) {
      Ingredient ingredient = ingredients.get(i);
      String measure = ingredient.measure.display();
      text(measure + ingredient.name, 50, yvalue);
      
      yvalue += 30;
      
    }
  }
  
  
  if (objects.size() != 0) {
    for (int i = 0; i < objects.size(); i++) {
      Ingredient ingredient = objects.get(i);
      String measure = ingredient.measure.display();
      text(measure + ingredient.name, 50, yvalue);
      
      yvalue += 30;
      
    }  
  
  }
  
  PFont main = createFont("mainfont.otf", 64);
  textFont(main);
  textAlign(CENTER);
  textSize(50);
  text("Instructions", 375, 525);

 
  textAlign(LEFT);
  textFont(sub);
  textSize(18);
  
  text(instructions, 375, 800, 650, 500);

}



// main function of the program - scales and converts the ingredients based on the scale provided
void adjustingredients() {
  for (int i = 0; i < ingredients.size(); i++) {
    Ingredient ingredient = ingredients.get(i);
    ingredient.measure.display();     
    ingredient.measure = convertstage1(ingredient.measure);
  }
  
  if (ingredients.size() != 0) {
    ingredients = sortme(ingredients, 0, ingredients.size()-1, sorting);  
  }
  
  if (objects.size() != 0) {
    objects = sortme(objects, 0, objects.size()-1, sorting);  
  
  }

  for (int i = 0; i < ingredients.size(); i++) {
    Ingredient ingredient = ingredients.get(i);

    
    ingredient.measure = convertstage2(ingredient.measure);
    
  }
  
  for (int i = 0; i < objects.size(); i++) {
    Ingredient ingredient = objects.get(i);
    ingredient.measure = convertobject(ingredient.measure);
    
  } 

}


// first stage of conversion of measurements (before sorting)
Measurement convertstage1(Measurement m) {
  Measurement result;
  m = scaleme(m);
  result = m.changetotea();
  result.display();
  return result;

}


// second stage of conversion of measurements (after sorting)
Measurement convertstage2(Measurement m) {
  m = m.convert();
  m = m.roundtoquarter();
  m = m.convertwhole();
  
  
  return m;

}


// converting objects
Measurement convertobject(Measurement m) {
  m = scaleme(m);
  m = m.roundtoquarter();
  m = m.convertwhole();
  
  return m;
}


// scales the measurement according to the scale provided
Measurement scaleme(Measurement m) {
  Measurement result = m.multiply(scale);
  return result;

}


// sorts the list of ingredients using merge sort
ArrayList<Ingredient> sortme(ArrayList<Ingredient> a, int start, int end, String type) {
  ArrayList<Ingredient> miniarray = new ArrayList<Ingredient>();
  if (start == end) {  
    miniarray.add(a.get(start));
    return miniarray;
  } 
  
  else {
    int middle = (end + start)/2;  

    ArrayList<Ingredient> sortedLeftHalf  = sortme(a, start, middle, type);     
    ArrayList<Ingredient> sortedRightHalf = sortme(a, middle+1, end, type);   

    return merge(sortedLeftHalf, sortedRightHalf, type);  
  }
}

// merging step of mergesort that gets called in the recursion process
ArrayList<Ingredient> merge(ArrayList<Ingredient> a, ArrayList<Ingredient> b, String type) {
  ArrayList<Ingredient> c = new ArrayList<Ingredient>(a.size() + b.size());
  int i = 0;
  int j = 0;

  while (i < a.size() && j < b.size()) {  
    Ingredient one = a.get(i);
    Ingredient two = b.get(j);
    
    float decimal1 = one.measure.todecimal();
    float decimal2 = two.measure.todecimal();
    
    if (type == "incr") {
      if (decimal1 <= decimal2) {  
        c.add(one); 
        i++;        
      } 
      
      else {
        c.add(two);  
        j++;         
      }
    }
    
    else {
      if (decimal1 >= decimal2) {  
        c.add(one); 
        i++;        
      } 
      
      else {
        c.add(two);  
        j++;         
      }    
    
    }

  }


  if (i == a.size()) {
    for (int k = j; k < b.size(); k++) {  
      Ingredient remain2 = b.get(k);
      c.add(remain2);
    } 
  }
    
  else {
    for (int k = i; k < a.size(); k++) {
      Ingredient remain1 = a.get(k);
      c.add(remain1);
    }
  }

  return c;  
}
