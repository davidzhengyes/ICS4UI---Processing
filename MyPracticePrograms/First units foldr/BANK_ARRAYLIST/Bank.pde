class Bank{
  String name;
  ArrayList<Account> allAccounts;
  
  Bank(String n){
    this.name = n;
    this.allAccounts = new ArrayList<Account>();
    
  }
  
  void addAccount(Account x){
    allAccounts.add(x);
  }
  
  void printEveryonesSummary(){
    for(int i=0; i<this.allAccounts.size(); i++){
      this.allAccounts.get(i).printSummary();
    }
    
  }
  
  
  
  
  
}
