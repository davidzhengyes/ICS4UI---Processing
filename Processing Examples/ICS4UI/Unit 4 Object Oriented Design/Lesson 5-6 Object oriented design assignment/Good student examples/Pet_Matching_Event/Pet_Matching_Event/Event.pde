class Event {

  // Fields
  String name;                             // Event's name
  ArrayList<Customer> participants;        // Participants
  ArrayList<Pet> featuredPets;             // Pets featured in event

  // Constructor
  Event( String n ) {
    this.name = n;
    participants = new ArrayList<Customer>();
    featuredPets = new ArrayList<Pet>();
  }

  // Methods

  // Introducing the event
  void introduction() {
    println( "********************(V●^●V)************** Welcome to", this.name, "**************(^●w●^)********************" );
    println( "Here we have a variety of adorable animals, ready to be adopted!" );
    println();
  }

  // Adding pets to the event
  void addPet( Pet p ) {
    featuredPets.add(p);
  }

  // Introducing pets and showing their characteristics
  void introducePets() {
    println( "Here are the participating animals:" );
    for ( int i = 0; i < featuredPets.size(); i++ )
      featuredPets.get(i).portfolio();
  }

  // Invite Customers to the Event
  void inviteCustomer( Customer c ) {
    participants.add(c);
  }

  // All customers enter event
  void customersEnter() {
    for ( Customer c : participants ) {
      c.enter();
    }
    println( "■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■" );
  }

  // Summary of which pet got adopted by who, or just didn't get adopted ( ⁰ ^ ⁰ )
  void summary() {
    println();
    for ( Pet p : featuredPets ) {
      print(p.name, "is now owned by:   \t" );
      if ( p.owned == true ) println( p.owner.name );
      else println( "no one" );
    }
    println();
    println( "********************************(V●^●V)********************************************************(^●w●^)********************************" );
  }

  // End note
  void end() {
    println();
    println( "**************************************************************************************************************************************" );
    println( "That's all for now. We hope everyone will continue enjoying their time!" );  
    println( "\t\t~The Humane Society of KW" );
    println( "********************************(V●^●V)********************************************************(^●w●^)********************************" );
  }
}
