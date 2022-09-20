//NAME: Christmas Chaos
//PROGRAMMER: Sophia Xie
//TEACHER: Mr. Schattman
//LAST MODIFIED: 01/06/2021

//NOTE: I apologize for the length of this. As I was coding, I kept coming up with new features to add. Nonetheless, I hope you enjoy!

String familyName = "Processing";

void setup() {
  //CREATE NARRATOR
  Narrator narr = new Narrator();

  //CREATE SANTA
  Santa santa = new Santa("Mr. Schattman", "Code, code, code!");

  //CREATE GRINCH
  Grinch grinch = new Grinch("Sir COVID-19", false);  // true = nice, false = mean

  //CREATE FAMILY MEMBERS
  Member sarah = new Member("Sarah", "3", "billionaire", "has the powers to literally evaporate you into thin air", 
    "stepped out of her comfort zone by launching her very own startup", true);
  Member quinn = new Member("Quinn", "17", "TikTok star", "is married to iced coffee", "did not sign up for Grade 12 CS", false);
  Member kaitlyn = new Member("Kaitlyn", "25", "volleyball player", "is obsessed with poorly animated videos", 
    "successfully created a firefighter robot while helping others along the way", true);
  Member isabel = new Member("Isabel", "14", "famous K-pop dancer", "listens to Rick Astley all day, every day", 
    "set an exercising goal and stuck to it", true);
  Member sophia = new Member("Sophia", "\u03C0", "couch potato", "enjoys staring into the dark void of nothingness", 
    "slept for at least 3 hours every night", true);

  //CREATE GIFTS
  //note: gifts cannot be used more than once (if someone buys it or santa makes it, it cannot be bought or made again)
  Gift ironManPillow = new Gift("an iron man pillow", "toys");
  Gift sourCreamOnionChips = new Gift("sour cream and onion chips", "food");
  Gift uniAcceptance = new Gift("a university acceptance", "electronics");

  Gift socks = new Gift("socks", "clothes");
  Gift stickers = new Gift("stickers", "art supplies");
  Gift goldfish = new Gift("flavour-blasted goldfish", "food"); 

  Gift earrings = new Gift("dangly earrings", "jewelry");
  Gift sweater = new Gift("an oversized sweater", "clothes");
  Gift laptop = new Gift("a laptop to watch poorly animated videos", "electronics");

  Gift barbie = new Gift("a Barbie Dream House", "toys");
  Gift chocoStrawberries = new Gift("chocolate-covered strawberries", "food");
  Gift boyfriend = new Gift("a boyfriend", "food");

  Gift willToLive = new Gift("a will to live", "toys");
  Gift mathHomework = new Gift("math homework", "food");
  Gift cheese = new Gift("cheese", "food");

  //CREATE STORES
  Store bestBuy = new Store("Best Buy", "electronics");
  Store claires = new Store("Claire's", "jewelry");
  Store currys = new Store("Curry's Artists' Materials", "art supplies");
  Store foodBasics = new Store("Food Basics", "food");
  Store toysRus = new Store("Toys R Us", "toys");
  Store winners = new Store("Winners", "clothes");

  //INTRODUCTION
  narr.opening1();

  sarah.introduce();
  quinn.introduce();
  kaitlyn.introduce();
  isabel.introduce();
  sophia.introduce();

  narr.opening2();

  santa.introduce();
  grinch.introduce();

  narr.opening3();

  //SANTA CREATES NAUGHTY OR NICE LIST
  santa.createList();

  santa.checkNice(sarah);
  santa.checkNice(quinn);
  santa.checkNice(sarah);
  santa.checkNice(isabel);
  santa.checkNice(sophia);

  santa.printList();

  //START WRITING WISH LISTS
  narr.startWritingWishLists();

  sarah.addToList(ironManPillow);
  sarah.addToList(sourCreamOnionChips);
  sarah.addToList(uniAcceptance);

  quinn.addToList(socks);
  quinn.addToList(stickers);
  quinn.addToList(goldfish);

  kaitlyn.addToList(earrings);
  kaitlyn.addToList(sweater);
  kaitlyn.addToList(laptop);

  isabel.addToList(barbie);
  isabel.addToList(chocoStrawberries);
  isabel.addToList(boyfriend);

  sophia.addToList(willToLive);
  sophia.addToList(mathHomework);
  sophia.addToList(cheese);

  narr.doneWritingWishLists();

  sarah.printWishList();
  quinn.printWishList();
  kaitlyn.printWishList();
  isabel.printWishList();
  sophia.printWishList();

  //BUY GIFTS FOR EACH OTHER
  narr.startBuyingGifts();

  kaitlyn.buyGift(sarah, sourCreamOnionChips, foodBasics);
  kaitlyn.buyGift(quinn, socks, winners);

  sarah.buyGift(sophia, barbie, toysRus);
  sarah.buyGift(sophia, cheese, bestBuy);
  sarah.buyGift(sophia, cheese, winners);
  sarah.buyGift(sophia, cheese, claires);
  sarah.buyGift(sophia, cheese, foodBasics);

  quinn.buyGift(isabel, boyfriend, toysRus);
  isabel.buyGift(sophia, willToLive, toysRus);

  toysRus.closeStore();

  sophia.buyGift(quinn, stickers, currys); 
  sophia.buyGift(sarah, ironManPillow, toysRus);

  quinn.buyGift(sarah, uniAcceptance, bestBuy);

  winners.setOnFire();

  isabel.buyGift(kaitlyn, earrings, claires);
  sophia.buyGift(kaitlyn, sweater, winners);
  quinn.buyGift(kaitlyn, laptop, bestBuy);

  //SANTA'S ELVES MAKE GIFTS
  santa.breakOver();

  santa.makeGift(sarah, ironManPillow);
  santa.makeGift(quinn, goldfish);
  santa.makeGift(kaitlyn, sweater);
  santa.makeGift(sophia, mathHomework);

  //SANTA DELIVERS GIFTS
  santa.deliverGifts();

  //ENTER GRINCH
  grinch.awakens();

  grinch.stealGift(kaitlyn, earrings);
  grinch.stealGift(sophia, willToLive);
  grinch.stealGift(sophia, uniAcceptance);

  grinch.doneStealing();

  //CHRISTMAS MORNING
  narr.christmasMorning();

  sarah.openGifts();
  quinn.openGifts();
  kaitlyn.openGifts();
  isabel.openGifts();
  sophia.openGifts();  

  //CLOSING
  grinch.closing();

  exit();
}
