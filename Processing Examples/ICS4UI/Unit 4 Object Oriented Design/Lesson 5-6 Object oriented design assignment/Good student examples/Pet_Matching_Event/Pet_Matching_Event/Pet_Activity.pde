class PetActivity {

  // Fields
  String name;            // Name of activity
  boolean needActivity;   // Whether the pet requires this activity
  float activityTime;     // Amount of time needed to spend on the activity with pet per day

  // Constructors
  // Activity is required
  PetActivity( String n, boolean a, float h ) {
    this.name = n;
    this.needActivity = a;
    this.activityTime = h;
  }

  // Pet does not require activity (ex. some cats don't like walks with owner)
  PetActivity( String n, boolean a ) {
    this.name = n;
    this.needActivity = a;
    this.activityTime = 0;
  }
}
