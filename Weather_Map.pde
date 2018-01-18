int [] dt = new int[3];
int [] humidityCurrent = new int[3];
int [] sunriseSeconds = new int[3];
int [] sunsetSeconds = new int[3];
String [] currentTime = new String[3];
String [] sunriseConvert = new String[3];
String [] sunrise = new String[3];
String [] time = new String[3];
String [] name = new String[3];
String [] sunset = new String[3];
String [] sunsetConvert = new String[3];
JSONObject [] sunsetData = new JSONObject[3];
JSONObject [] localTime = new JSONObject[3];
JSONObject [] currentWind = new JSONObject[3];
JSONObject [] sys = new JSONObject[3];
JSONObject [] sunriseData = new JSONObject[3];
JSONObject [] mainCurrent = new JSONObject[3];
float [] tempCurrent = new float[3];
float [] tempMin = new float[3];
float [] tempMax = new float[3];
float [] WindSpeed = new float[3];
int menuNav = 0;
import processing.sound.*;
int menu = 4;
int totalEffects = 2;
SoundFile[] effect = new SoundFile[totalEffects];
//==============================================================================================================================================================================================================================================================


void setup() {
  JSONObject json_current_Edmonton = loadJSONObject ("https://api.openweathermap.org/data/2.5/weather?id=5946768&APPID=249201bc2bdb05e89ab7c932294d4cfd&mode=JSON&units=metric");

  JSONObject json_current_Calgary = loadJSONObject ("https://api.openweathermap.org/data/2.5/weather?id=5913490&APPID=249201bc2bdb05e89ab7c932294d4cfd&mode=JSON&units=metric");

  JSONObject json_current_Donalds_Hometown = loadJSONObject ("https://api.openweathermap.org/data/2.5/weather?id=6155033&APPID=249201bc2bdb05e89ab7c932294d4cfd&mode=JSON&units=metric");

  //A good project would be to compare all these values and comment on the predictive modelling of Open Weather Map
  //Unwrap Forecast Data using validation call in Chrome and JSON Lint to make call readible

  dt[0] = json_current_Edmonton.getInt ("dt"); 
  dt[1] = json_current_Calgary.getInt ("dt");
  dt[2] = json_current_Donalds_Hometown.getInt ("dt"); //parent node, Unwraps [], or array list
  //Using dt-forecast variable in another API

  currentTime[0] = "http://www.convert-unix-time.com/api?timestamp=" + dt[0] + "&timezone=Edmonton";
  currentTime[1] = "http://www.convert-unix-time.com/api?timestamp=" + dt[1] + "&timezone=Edmonton"; 
  currentTime[2] = "http://www.convert-unix-time.com/api?timestamp=" + dt[2] + "&timezone=Edmonton";

  localTime[0] = loadJSONObject (currentTime[0]); 
  localTime[1] = loadJSONObject (currentTime[1]); 
  localTime[2] = loadJSONObject (currentTime[2]);

  time[0] = localTime[0].getString ("localDate"); 
  time[1] = localTime[1].getString ("localDate");
  time[2] = localTime[2].getString ("localDate");
  //Notice it is possible to create a method out of these lines of code
  //Using string functions and a method, localDate can be shaped to the parts needed

  //Unwrap Weather data using validation in Chrome and JSON Lint to make a call readible

  mainCurrent[0] = json_current_Edmonton.getJSONObject ("main"); 
  mainCurrent[1] = json_current_Calgary.getJSONObject ("main");
  mainCurrent[2] = json_current_Donalds_Hometown.getJSONObject ("main"); //unwraps {}, or array

  tempCurrent[0] = mainCurrent[0].getFloat ("temp");
  tempCurrent[1] = mainCurrent[1].getFloat ("temp"); 
  tempCurrent[2] = mainCurrent[2].getFloat ("temp");

  tempMin[0] = mainCurrent[0].getFloat ("temp_min");
  tempMin[1] = mainCurrent[1].getFloat ("temp_min"); 
  tempMin[2] = mainCurrent[2].getFloat ("temp_min");

  tempMax[0] = mainCurrent[0].getFloat ("temp_max"); 
  tempMax[1] = mainCurrent[1].getFloat ("temp_max"); 
  tempMax[2] = mainCurrent[2].getFloat ("temp_max");

  humidityCurrent[0] = mainCurrent[0].getInt ("humidity"); 
  humidityCurrent[1] = mainCurrent[1].getInt ("humidity");
  humidityCurrent[2] = mainCurrent[2].getInt ("humidity");

  currentWind[0] = json_current_Edmonton.getJSONObject("wind");
  currentWind[1] = json_current_Calgary.getJSONObject("wind");
  currentWind[2] = json_current_Donalds_Hometown.getJSONObject("wind");

  WindSpeed[0] = currentWind[0].getInt("speed"); 
  WindSpeed[1] = currentWind[1].getInt("speed"); 
  WindSpeed[2] = currentWind[2].getInt("speed");
  //Able to send this to the Unix Time API as above

  name[0] = json_current_Edmonton.getString ("name");
  name[1] = json_current_Calgary.getString ("name");
  name[2] = json_current_Donalds_Hometown.getString ("name"); //parent node, no unwrapping

  sys[0] = json_current_Edmonton.getJSONObject ("sys"); 
  sys[1] = json_current_Calgary.getJSONObject ("sys");
  sys[2] = json_current_Donalds_Hometown.getJSONObject ("sys"); //unwraps {}, or array

  sunriseSeconds[0] = sys[0].getInt ("sunrise"); 
  sunriseSeconds[1] = sys[1].getInt ("sunrise"); 
  sunriseSeconds[2] = sys[2].getInt ("sunrise"); //Able to send this to the Unix Time API as above

  sunriseConvert[0] = "http://www.convert-unix-time.com/api?timestamp=" + sunriseSeconds[0] + "&timezone=Edmonton"; 
  sunriseConvert[1] = "http://www.convert-unix-time.com/api?timestamp=" + sunriseSeconds[1] + "&timezone=Edmonton"; 
  sunriseConvert[2] = "http://www.convert-unix-time.com/api?timestamp=" + sunriseSeconds[2] + "&timezone=Edmonton";

  sunriseData[0] = loadJSONObject (sunriseConvert[0]); 
  sunriseData[1] = loadJSONObject (sunriseConvert[1]); 
  sunriseData[2] = loadJSONObject (sunriseConvert[2]);

  sunrise[0] = sunriseData[0].getString ("localDate"); 
  sunrise[1] = sunriseData[1].getString ("localDate");
  sunrise[2] = sunriseData[2].getString ("localDate");

  sunsetSeconds[0] = sys[0].getInt ("sunset"); 
  sunsetSeconds[1] = sys[1].getInt ("sunset");
  sunsetSeconds[2] = sys[2].getInt ("sunset");//Able to send this to the Unix Time API as above

  sunsetConvert[0] = "http://www.convert-unix-time.com/api?timestamp=" + sunsetSeconds[0] + "&timezone=Edmonton";
  sunsetConvert[1] = "http://www.convert-unix-time.com/api?timestamp=" + sunsetSeconds[1] + "&timezone=Edmonton";
  sunsetConvert[2] = "http://www.convert-unix-time.com/api?timestamp=" + sunsetSeconds[2] + "&timezone=Edmonton";

  sunsetData[0] = loadJSONObject (sunsetConvert[0]); 
  sunsetData[1] = loadJSONObject (sunsetConvert[1]);
  sunsetData[2] = loadJSONObject (sunsetConvert[2]);

  sunset[0] = sunsetData[0].getString ("localDate"); 
  sunset[1] = sunsetData[1].getString ("localDate"); 
  sunset[2] = sunsetData[2].getString ("localDate");

  //Simple println to ensure variables are loaded with correct information
  //Caution: might need to concatonate to different lines if screen is too narrow
 /* println ("The ID for Edmonton is: " + name[0]);
  println ("Local Time from Edmonton is: " + time[0]);
  println ("The sunrise of Edmonton is: " + sunrise[0]);
  println ("The sunset of Edmonton is: " + sunset[0]);
  println ("Temp from Edmonton is: " + tempCurrent[0]);
  println ("Humidity from Edmonton is: " + humidityCurrent[0]);
  println ("WindSpeed from Edmonton is: " + WindSpeed[0] + "M/s");
  println ("The ID for Calgary is: " + 5913490);
  println ("Local Time from Calgary is: " + time[1]); 
  println ("The sunrise of Calgary is: " + sunrise[1]); 
  println ("The sunset of Calgary is: " + sunset[1]); 
  println ("Temp from Calgary is: " + tempCurrent[1]);
  println ("Humidity from Calgary is: " + humidityCurrent[1]);
  println ("WindSpeed from Calgary is: " + WindSpeed[1] + "M/s");
  println ("The ID for Donalds Hometown: " + 5883102);
  println ("Local Time from Donalds Hometown is: " + time[2]);
  println ("The sunrise of Donalds Hometown is: " + sunrise[2]);
  println ("The sunset of Donalds Hometown is: " + sunset[2]);
  println ("Temp from Donalds Hometown is: " + tempCurrent[2]);
  println ("Humidity from Donalds Hometown is: " + humidityCurrent[2]);
  println ("WindSpeed from Donalds Hometown is: " + WindSpeed[2] + "M/s");
  */
  size(1200, 800);
  effect[0] = new SoundFile (this, "menuclick.wav");
  effect[1] = new SoundFile (this, "menuhit.wav");
  
}

//===========================================================================================================================================================================================================================================================

void draw() {
  println(menuNav);
  mainMenu(menuNav);//Scrolling between the 4 options
  if (menu == 0){
    EdmontonDisplay();
  }
  else if (menu == 1) {
    CalgaryDisplay();
  }
  else if (menu == 2) { 
    DonaldsHometownDisplay();
  }
  else if (menu == 3) {
    Instructions();
  }
}
void keyPressed() {
  if (keyPressed){
    if (keyCode == UP){//Moves choice up
      if (menu == 4){
        if (menuNav <= 0){
          menuNav = 4;
          effect[0].play();
        }else{
          menuNav--;
          effect[0].play();
        }
      }
    }
    
    if (keyCode == DOWN){//Moves choice down
      if (menu == 4){
        if (menuNav >= 4){
          menuNav = 0;     
          effect[0].play();
          
        }else {
          menuNav++;
          effect[0].play();
        }
      }
    }
    
    if (keyCode == ENTER){//Selects choice
      if (menu == 4){
        if (menuNav == 0) {
          menu = 3;
          effect[1].play();
        }
        if (menuNav == 1) {
          menu = 0;
          effect[1].play();
        }
        if (menuNav == 2) {
          menu = 1;
          effect[1].play();
        }
        if (menuNav == 3) {
          menu = 2;
          effect[1].play();
        }
        if (menuNav == 4) {
          exit();
        }
      }
    }
    
    if (keyCode == BACKSPACE) {//Goes back to main menu
      if (menu != 4) {
        menu = 4;
        effect[1].play();
      }
    }
  }
}

void mainMenu(int menuNav){//Formal variable
  rectMode(CORNERS);
  strokeWeight(5);
  fill(200, 75, 255);
  rect(1, 1, 1198, 798);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  fill(0);
  textSize(125);
  text("WEATHER",width/2, 200,600,200);
  textSize(25);
  text("Press Enter", width/2, 325, 600, 200);
  
  if (menuNav == 1){//hover
    textSize(65);
    fill(85, 255, 255);
  }else{
    textSize(45);
    fill(0);
  }
  text("EDMONTON",width/2, 475,600,200);
  
  if (menuNav == 2){//hover
    textSize(65);
    fill(85, 255, 255);
  }else{
    textSize(45);
    fill(0);
  }
  text("CALGARY",width/2, 550,600,200);
  
  if (menuNav == 3){//hover
    textSize(65);
    fill(85, 255, 255);
  }else{
    textSize(45);
    fill(0);
  }
  text("DONALD'S HOUSE",width/2, 625,600,200);
  
   if (menuNav == 0){//hover
    textSize(65);
    fill(85, 255, 255);
  }else{
    textSize(45);
    fill(0);
  }
  text("INSTRUCTIONS",width/2, 400,600,200);
  
  if (menuNav == 4){//hover
    textSize(65);
    fill(85, 255, 255);
  }else{
    textSize(45);
    fill(0);
  }
  text("QUIT",width/2, 700,600,200);
}

void EdmontonDisplay() {//API for Edmonton
  rectMode(CORNER);
  textAlign(CORNER,CORNER);
  strokeWeight(5);
  fill(255, 255, 85);
  rect(1, 1, 1198, 798);
  line(0, 100, 1200, 100); 
  textSize(75);
  fill(0);
  text(name[0], 25, 100);
  textSize(30);
  text("Local Time: " + time[0], 25, 150);
  text("Sunrise Time: " + sunrise[0], 25, 250);
  text("Sunset Time: " + sunset[0], 25, 350);
  text("Temperature: " + tempCurrent[0], 25, 450);
  text("humidity: " + humidityCurrent[0], 25, 550);
  text("WindSpeed: " + WindSpeed[0] + "M/s", 25, 650);
}

void CalgaryDisplay() {//API for Calgary
  rectMode(CORNER);
  textAlign(CORNER,CORNER);
  strokeWeight(5);
  fill(255,50,50);
  rect(1, 1, 1198, 798);
  line(0, 100, 1200, 100); 
  textSize(75);
  fill(0);
  text(name[1], 25, 100);
  textSize(30);
  text("Local Time: " + time[1], 25, 150);
  text("Sunrise Time: " + sunrise[1], 25, 250);
  text("Sunset Time: " + sunset[1], 25, 350);
  text("Temperature: " + tempCurrent[1], 25, 450);
  text("humidity: " + humidityCurrent[1], 25, 550);
  text("WindSpeed: " + WindSpeed[1] + "M/s", 25, 650);
}
void DonaldsHometownDisplay() {//API for St.Albert
  rectMode(CORNER);
  textAlign(CORNER,CORNER);
  strokeWeight(5);
  fill(0, 255, 110);
  rect(1, 1, 1198, 798);
  line(0, 100, 1200, 100); 
  textSize(75);
  fill(0);
  text(name[2], 25, 100);
  textSize(30);
  text("Local Time: " + time[2], 25, 150);
  text("Sunrise Time: " + sunrise[2], 25, 250);
  text("Sunset Time: " + sunset[2], 25, 350);
  text("Temperature: " + tempCurrent[2], 25, 450);
  text("humidity: " + humidityCurrent[2], 25, 550);
  text("WindSpeed: " + WindSpeed[2] + "M/s", 25, 650);
}
void Instructions() {
  rectMode(CORNER);
  textAlign(CORNER,CORNER);
  fill(150, 150, 150);
  rect(1, 1, 1198, 798);
  line(0, 100, 1200, 100); 
  fill(0);
  textSize(75);
  text("Instructions", 25, 100);
  textSize(30);
  text("Navigation: Up and Down keys", 25, 150);
  text("Confirm: Enter key", 25, 250);
  text("Back: Backspace", 25, 350);
}