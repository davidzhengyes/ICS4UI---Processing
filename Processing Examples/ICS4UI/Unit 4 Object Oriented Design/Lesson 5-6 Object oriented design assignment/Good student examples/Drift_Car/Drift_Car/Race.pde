class Race {
    ArrayList<Car> cars;
    Track track;
    Race(Track track) {
        this.track = track;
        this.cars = new ArrayList<Car>();
    }

    void addCar(String name, float xStart, float yStart, float fCoeff, float speed, color col) {
        Car car;
        car = new Car(name, xStart, yStart, fCoeff, speed, this.track, col);
        cars.add(car);
    }

    void updateCars(int f) {
        for(int i = 0; i < cars.size(); i++) {
            this.cars.get(i).updateCar(f);
        }
    }

    void drawRace() {
        this.track.drawTrack();

        for(int i = 0; i < cars.size(); i++) {
            cars.get(i).drawCar();
        }
        
        for(int i = 0; i < cars.size(); i++) {
            if(cars.get(i).finished) {
                textSize(40);
                fill(cars.get(i).col);
                text(cars.get(i).name + " finished in " + str(cars.get(i).finishFrame) + " frames", 0, 400 + i*600.0/cars.size());
            }
        }
    }
}
