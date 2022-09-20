// This program is based on the adoption process used by the Humane Society of Kitchener Waterloo & Stratford Perth
// More details: https://kwsphumane.ca/

// Global Variable of all animals
ArrayList<Pet> allAnimals;

void setup() {

  // Declare Event
  Event adoptUs = new Event ( "AdoptUs Day" );

  // ALL Animals
  allAnimals = new ArrayList<Pet>();  

  // Pets
  Pet isis = new Pet ( "Isis", 14, "female", "cat" ); 
  Pet mint = new Pet( "Mint", 14, "female", "cat" );
  Pet toast = new Pet( "Toast", 3, "male", "cat" );
  Pet tom = new Pet( "Tom", 20, "male", "cat" );
  Pet jiji = new Pet( "JiJi", 37, "male", "cat" );
  Pet odie = new Pet( "Odie", 39, "female", "dog" );
  Pet kiwi = new Pet( "Kiwi", 21, "male", "dog" );

  // Customers
  Customer abigail = new Customer( "Abigail", "female", "cat", 10, 10, 10, 10, 10, 3, 500, 4 );
  Customer aris = new Customer( "Aris", "male", "cat", 3, 10, 8, 12, 4, 2, 3 );
  Customer hermione = new Customer ( "Hermonie", "male", "cat", 620, 2 );
  Customer nemo = new Customer ( "Nemo", "male", "dog", 600, 5 );
  Customer pingu = new Customer( "Pingu", "female", "dog", round(random(1, 20)), round(random(1, 20)), round(random(1, 20)), round(random(1, 20)), round(random(1, 20)), round(random(0, 6)), 520 ); 


  // Arranging Event
  adoptUs.introduction();

  adoptUs.addPet(mint);
  adoptUs.addPet(isis);
  adoptUs.addPet(toast);
  adoptUs.addPet(tom);
  adoptUs.addPet(odie);
  adoptUs.addPet(jiji);
  adoptUs.addPet(kiwi);
  adoptUs.introducePets();

  adoptUs.inviteCustomer(abigail);
  adoptUs.inviteCustomer(aris);
  adoptUs.inviteCustomer(hermione);
  adoptUs.inviteCustomer(nemo);
  adoptUs.inviteCustomer(pingu);
  adoptUs.customersEnter();

  // Customers participating in the event (pet shopping)
  abigail.interview();
  aris.interview();
  hermione.interview();
  pingu.interview();

  adoptUs.summary();

  // Emails to new pet owners to check progress
  println( "\nA couple weeks later..." );
  abigail.updateSurvey();
  aris.updateSurvey();
  hermione.updateSurvey();
  pingu.updateSurvey();

  // End
  adoptUs.end();
}
