Race race;
Track track;
int f;
void setup() {

    size(1000, 1000);
    frameRate(30);
    f = 0;

//    Car S2000 = new Car("S2000", 50, 50, 2.4, 60);
//    Car N350z = new Car("350z", 60, 50, 3.0, 70);
//    Car N240sx = new Car("240sx", 70, 50, 1.6, 70);
//    Car GTR = new Car("GTR", 80, 50, 1, 50);

    track = new Track(600, 300, 90);
    race = new Race(track);

    race.addCar("GTR", 700, 1000, 0.1, 100, color(255, 0, 0));
    race.addCar("N350z", 800, 1000, 3, 240, color(0, 255, 0));
    race.addCar("N240sx", 900, 1000, 1, 200, color(0, 0, 255));

}

void draw() {
    background(100, 200, 100);
    race.updateCars(f);
    race.drawRace();
    f++;
}
