void setup(){
  
  //cars
  Car miniCooper = new Car("red", 5, "Mini Cooper 2021");
  Car miniVan = new Car("blue", 3, "Honda Odyssey 2017");
  Car porsche = new Car("white", 7, "Porsche Cayman 2022");

  //drivers
  Driver grace = new Driver("Grace", 3, 7);
  Driver megan = new Driver("Megan", 9, 6);
  Driver tina = new Driver("Tina", 1, 8);
  
  
  //pedestrians
  Pedestrian boss = new Pedestrian("your boss", 9);
  Pedestrian ex = new Pedestrian("your ex", 5);
  Pedestrian randomPerson = new Pedestrian("a random person", 8);
  Pedestrian friend = new Pedestrian("your best friend", 4);
  Pedestrian so = new Pedestrian("you significant other", 1);
  
  //cops
  Cop hungryCop = new Cop(3, 7);
  Cop hungryAndAlertCop = new Cop(9, 8);
  Cop alertCop = new Cop(8, 2);
  
  //INTRO
  println("        _______                                _______");
  println("       //  ||\\ \\                              //  ||\\ \\");
  println(" _____//___||_\\ \\___                    _____//___||_\\ \\___");
  println(" )  _          _    \\                   )  _          _    \\");
  println(" |_/ \\________/ \\___|                   |_/ \\________/ \\___|");
  println("___\\_/________\\_/_________________________\\_/________\\_/________________");
  println("");

  println("Welcome to the best driving simulator ever made!");
  println("In this world you are the driver.");
  println();
  println("Here you can get out your agression by running people over, disobey a bunch of traffic laws,");
  println("or be boring and just drive around.");
  println("Beware though, there are cops around that can send you to jail if they catch you.");
  println("So choose wisely who your character is, what car you drive, and who you decide to hit with your car.");
  println();
  println("-------------------------------------------------------------------------------------------------------------");
  println();
  
  
  //THINGS YOU CAN DO
  //carName.getsOwner(driverName);
  //driverName.chooseCar(carName);
  
  //pedestrianName.walksAcrossRoad(driverName, copName);
  
  //driverName.hitPedestrian(pedestrianName, copName);
  //driverName.doNotHitPedestrian(pedestrianName);

  //describing cars
  println("Here is a list of all the cars you can choose from:");
  miniCooper.describeCar();
  miniVan.describeCar();
  porsche.describeCar();
  println("\n");
  

  println("Let's begin! \n \n");
  
  megan.chooseCar(miniVan);
  
  randomPerson.walksAcrossRoad(megan);
  megan.doNotHitPedestrian(randomPerson);
  
  ex.walksAcrossRoad(megan);
  megan.hitPedestrian(ex, hungryCop);
  
  megan.hitPedestrian(friend, alertCop);
  megan.hitPedestrian(ex, hungryCop);
  
  boss.walksAcrossRoad(megan);
  megan.hitPedestrian(boss, hungryCop);
  
}
