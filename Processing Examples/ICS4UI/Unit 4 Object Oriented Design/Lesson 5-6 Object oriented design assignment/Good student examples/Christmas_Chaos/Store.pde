class Store {
  //FIELDS
  String name;
  String department;
  Boolean closed;
  Boolean onFire;

  //CONSTRUCTOR
  Store(String n, String d) {
    this.name = n;
    this.department = d;
    this.closed = false;
    this.onFire = false;
  }

  //METHODS
  void setOnFire() {
    this.onFire = true;
    println();
    println("************************************** BREAKING NEWS **************************************");
    println("5 MINS AGO — We just received the heartbreaking news that " + this.name + " has caught on fire!");
    println("Officials confirmed that the " + this.department + " in the store did not survive the tragedy. The store");
    println("associates thought it was more important to save the 'oh-so-precious' customers' lives than");
    println("the exquisite " + this.department + ". What fools! They deserved to lose their minimum wage jobs. Anyways,");
    println("I'm supposed to tell you that everyone in the building was evacuated safely and that " + this.name);
    println("will be closed temporarily for 2 hours? A decade? I don't know how fire damage restoration");
    println("works, sorry.");
    println();
    println("AUTHOR: A highly qualified journalist who earned their Bagpiping degree online via Zoom.");
    println("*******************************************************************************************");
  }

  void closeStore() {
    this.closed = true;
    println();
    println("***************************** IMPORTANT NOTICE FROM " + this.name.toUpperCase() + " *****************************");
    println("After centuries of stealing your money, we ecstatically announce that " + this.name + " will be hot");
    println("gluing its doors shut. If you are desperate for " + this.department + ", the window facing south is the easiest");
    println("to break. It has been done before. We thank you for your understanding and hope you show");
    println("our company some love by creating some unnecessary drama.");
    println();
    println("Sincerely,");
    println("A very drunk " + this.name + " store manager who has no idea what to do with their life now.");
    println("*******************************************************************************************");
  }
}
