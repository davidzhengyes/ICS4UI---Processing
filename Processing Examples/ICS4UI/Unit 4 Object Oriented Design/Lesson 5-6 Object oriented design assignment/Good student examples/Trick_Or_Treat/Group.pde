class Group{
  //FIELDS
  String groupName;
  //int numMembers;
  ArrayList<TrickOrTreater> membersInGroup;
  
  //CONSTRUCTOR
  Group(String gN) {
    this.groupName = gN;
    membersInGroup = new ArrayList<TrickOrTreater>();
  }
    
  //METHODS
  void addMember(TrickOrTreater T) {
    membersInGroup.add(T);
    T.changeInGroupStatus(this);
  }
  
  void printAllMembers() {
    print("Members in", this.groupName+":");    
    for(int i = 0; i < membersInGroup.size(); i++ ){
      TrickOrTreater m = membersInGroup.get(i);
      println("-",m.name);
    }
    
    println();
  }
    
}
