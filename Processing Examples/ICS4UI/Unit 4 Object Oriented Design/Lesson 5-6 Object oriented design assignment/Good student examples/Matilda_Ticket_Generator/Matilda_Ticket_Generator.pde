
//AUDITORIUM PARAMETERS - Change to suit whatever venue you're in
String[] possibleRowLetters = { "A","B","C","D","E","F","G","H","J","K","L","M","N","Z" };  //THERE IS NO ROW "I". "Z" REFERS TO THE ROW OF PLASTIC CHAIRS AT THE BACK
String[] sectionNames = { "Left", "Centre", "Right" };
int[] sectionNumRows = {14, 13, 14};     //NUMBER OF ROWS IN EACH SECTION
int[] sectionSeatsPerRow = {7, 13, 7};   //NUMBER OF SEATS PER ROW IN EACH SECTION
int[] sectionSeatsInLastRow = {0, 0, 0}; //{2, 6, 3}; //NUMBER OF PLASTIC CHAIRS IN THE LAST ROW OF EACH SECTION

//PERFORMANCE PARAMETERS - Change to suit whatever showtimes you want
String[] performanceDays = { "FRIDAY, NOVEMBER 29th", "SATURDAY, NOVEMBER 30th"};
String[] times = { "7:00 p.m.", "1:00 p.m."};
String[] timesDoorsOpen = { "6:30 p.m.", "12:30 p.m."};
color[] ticketColours = { color(240,240,255),  color(255,255,240) };

//TICKET PRINTING PARAMETERS - Change to suit any size style you want
int sheetWidth = 1650, sheetHeight = 1275;                      //THE SIZE OF AN 8 1/2 x 11 INCH SHEET OF PAPER
int numTicketsPerRow = 2, numTicketsPerColumn = 5;              //10 TICKETS PER SHEET (IN 5 ROWS OF 2)
int totalSeats, numTicketsPerSheet, ticketWidth, ticketHeight;  //WILL BE CALCULATED INSIDE setup()
PImage ticketGraphic;                                           //THE MATILDA LOGO IMAGE
int graphicWidth, textWidth;                                    //WIDTH OF THE MATILDA IMAGE & THE TEXT PRINTED ON THE TICKETS
PFont ticketFontLarge, ticketFontSmall;

//ARRAYS
Section[] sections = new Section[ sectionNames.length ];
Performance[] performances = new Performance[ performanceDays.length ];


void setup() {
  size(1650, 1275); 
  
  int numPerformancesToPrint = performances.length;  //or 1 to just test Friday
  
  //SETS THE TICKET WIDTH & HEIGHT, AND RESIZES THE MATILDA IMAGE SO IT FITS ON A TICKET
  setTicketLayout();
  
  //CREATES SECTION OBJECTS USING THE AUDITORIUM PARAMETERS ABOVE
  for(int i = 0; i < sectionNames.length; i++)  
    sections[i] = new Section( sectionNames[i], sectionNumRows[i], sectionSeatsPerRow[i], sectionSeatsInLastRow[i]);
    
  //COMPUTES THE TOTAL NUMBER OF SEATS IN THE AUD. SHOULD BE 349.
  for(int i = 0; i < sectionNames.length; i++)  
    totalSeats += sections[i].numSeats;
  
  //CREATES PERFORMANCE OBJECTS USING THE PERFORMANCE PARAMETERS ABOVE
  for(int i = 0; i < numPerformancesToPrint ; i++) //performances.length
    performances[i] = new Performance( performanceDays[i], times[i], timesDoorsOpen[i], ticketColours[i] );
  
  //CREATES AND PRINTS TICKET SHEETS AS .jpg FILES
  for(int i = 0; i < numPerformancesToPrint; i++) {
    //pw.println("PERFORMANCE: " + performances[i].day);  //USED FOR TESTING ONLY
    performances[i].createTickets();
    performances[i].createTicketSheets();
    //pw.println();  //USED FOR TESTING ONLY
  }
  
  //pw.close(); USED FOR TESTING ONLY
  exit();
}


//SETS THE TICKET WIDTH & HEIGHT, AND RESIZES THE MATILDA IMAGE SO IT FITS ON A TICKET
void setTicketLayout() {
  numTicketsPerSheet = numTicketsPerRow * numTicketsPerColumn;
  ticketWidth = sheetWidth / numTicketsPerRow; 
  ticketHeight = sheetHeight / numTicketsPerColumn;
  
  graphicWidth = ticketHeight;            //SINCE THE IMAGE IS SQUARE AND SHOULD BE AS TALL AS THE TICKET ITSELF
  textWidth = ticketWidth - graphicWidth; //THE SPACE AVAILABLE FOR PRINTING TEXT ON THE TICKET

  ticketGraphic = loadImage( "Matilda logo.png" );
  ticketGraphic.resize( int(0.9*graphicWidth), int(0.9*graphicWidth) );
  
  ticketFontLarge = createFont("Garamond", 20);
  ticketFontSmall = createFont("Garamond", 16);
}
