void setup() {
  Animal kiwi = new Animal ("Kiwi", "male", "peacock");
  Animal pinky = new Animal("Pinky", "female", "llama", "angry");
  Animal karrot = new Animal("Karrot", "female", "bunny");
  Animal hiya = new Animal ("Hiya", "male", "worm", "angry");

  Visitor Louie = new Visitor("Louie", 20, true, true, 10);
  Visitor Moomoo = new Visitor("Moomoo", 50, false, false, 5);

  Zoo sunnysZoo = new Zoo("Sunny's Zoo");

  sunnysZoo.animals.add(pinky);
  sunnysZoo.animals.add(kiwi);
  sunnysZoo.animals.add(karrot);
  sunnysZoo.animals.add(hiya);


  println("Welcome to", sunnysZoo.name+". We have a wide variety of animals that are so kind and so cute!");

  sunnysZoo.describeAnimals();
  Louie.describe();

  Louie.petAnimal(kiwi);
  Louie.buyFood(sunnysZoo);
  Louie.feedAnimal(karrot);

  Moomoo.describe();
  Moomoo.buyFood(sunnysZoo);
  Moomoo.feedAnimal(pinky);
  Moomoo.feedAnimal(hiya);
  Moomoo.petAnimal(hiya);

  sunnysZoo.buyAnimal();

  sunnysZoo.describeAnimals();

  sunnysZoo.sellAnimal(kiwi);
  sunnysZoo.buyAnimal();
  sunnysZoo.describeAnimals();

  Louie.stirUpTrouble(sunnysZoo);
}
