
void setup() {
  BankAccount a1 = new BankAccount("Karry Him", "314-159", 14017.59);
  //a1.printSummary();
  a1.withdraw( 300.00 ); //make sure they can't withdraw more than they have.
  //a1.printSummary();
  
  BankAccount a2 = new BankAccount("Gonathan Je", "271-818", 2400.00);
  //a2.printSummary();
  a2.deposit( 10000.00 );
  //a2.printSummary();
  
  //I'D LIKE TO BE ABLE TO DO...
  Bank TD = new Bank("Totally Dishonest Bank of Canada");
  TD.addAccount(a1);
  TD.addAccount(a2);
  TD.printAllAccounts();
   
}
