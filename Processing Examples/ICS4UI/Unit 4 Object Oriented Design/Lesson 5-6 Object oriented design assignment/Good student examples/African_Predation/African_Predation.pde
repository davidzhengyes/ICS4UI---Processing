void setup(){
  
  Predator Leo = new Predator("Leo", "Lion", 3, "male", 7, 7, 10);
  Predator Jaws = new Predator("Jaws", "Crocodile", 10, "male", 4, 2, 6);
  Predator Tigress = new Predator("Tigress", "Tiger", 6, "female", 8, 5, 9);
  Predator Lucy = new Predator("Lucy", "Leopard", 2, "female", 2, 3, 1);
  
  Prey Ellie = new Prey ("Ellie", "Elephant", 5, "female", 10, 3);
  Prey Ziggy = new Prey ("Ziggy", "Zebra", 8, "female", 4, 9);
  Prey Anna = new Prey ("Anna", "Antelope", 2, "female", 1, 4);
  Prey Elliot = new Prey ("Elliot", "Elephant", 9, "male", 7, 5);
  Prey Zach = new Prey ("Zach", "Zebra", 4, "male", 5, 7);
  Prey Andrew = new Prey ("Andrew", "Antelope", 7, "male", 6, 6);
  
  Leo.table();
  Jaws.table();
  Tigress.table();
  Lucy.table();
  Ellie.table();
  Ziggy.table();
  Anna.table();
  Elliot.table();
  Zach.table();
  Andrew.table();
  
  Leo.hunt(Anna);
  Jaws.hunt(Zach);
  Tigress.findShelter();
  Lucy.findWater();
  Ellie.breed(Elliot);
  Ziggy.findFood();
  Andrew.findShelter();

  Leo.findWater();
  Jaws.findShelter();
  Tigress.hunt(Elliot);
  Lucy.findShelter();
  Ellie.findFood();
  Ziggy.findShelter();
  Anna.findWater();
  Elliot.findShelter();
  Zach.findFood();
  Andrew.findWater();
  
  Leo.breed(Tigress);
  Jaws.breed(Lucy);
  Ellie.findShelter();
  Anna.breed(Zach);
  Ziggy.findWater();
  Elliot.findFood();
  Andrew.findFood();
  
  Leo.findShelter();
  Jaws.findWater();
  Tigress.hunt(Anna);
  Lucy.hunt(Zach);
  Ellie.breed(Andrew);
  Ziggy.breed(Elliot);
  
  Leo.hunt(Andrew);
  Jaws.findShelter();
  Tigress.findWater();
  Lucy.hunt(Elliot);
  Ellie.findFood();
  Ziggy.findWater();
  Anna.findFood();
  Zach.findWater();
  
  Leo.end();
  Jaws.end();
  Tigress.end();
  Lucy.end();
  Ellie.end();
  Ziggy.end();
  Anna.end();
  Elliot.end();
  Zach.end();
  Andrew.end();
}
