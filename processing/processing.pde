import TUIO.*;
import java.util.*;
import processing.serial.*;
import ddf.minim.*;

AudioPlayer player;
Minim minim;
String format;
Serial myPort;
Table table;
int year;
float acceptedDistance = 0.03;
float acceptedDistanceYears = 0.02;
HashMap<String, HashMap<Integer, String>> map;
HashMap<String, float []> positions;
HashMap<String, float []> yearPositions;
HashMap<String, float []> languagePositions;
HashMap<String, AudioPlayer> audioFiles;

TuioProcessing tuioClient;
Calibration calibration;
Parser parser;
PositionHandler positionHandler;

String currentFirstCountry;
String currentSecondCountry;
String currentLanguage;
int currentYear;

String firstValueToSend;
String secondValueToSend;
boolean firstValueChanged;
boolean secondValueChanged;

float cursor_size = 15;
float object_size = 60;
float table_size = 1024;
float scale_factor = 1;
PFont font;

void setup()
{
  size(1024,576);
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  noStroke();
  fill(0);
  
  minim = new Minim(this);
  audioFiles = new HashMap<String, AudioPlayer>();
  format = ".mp3";
  loop();
  frameRate(30);
  
  font = createFont("Arial", 18);
  scale_factor = height/table_size;

  tuioClient  = new TuioProcessing(this);
  calibration = new Calibration();
  
  //Get the positions of the different countries and years
  positionHandler = new PositionHandler();
  positions = positionHandler.getPositions();
  yearPositions = positionHandler.getYearPositions();
  languagePositions = positionHandler.getLanguagePositions();
  
  setCurrentLanguage("Swedish");
  firstValueChanged = false;
  secondValueChanged = false;
  
  //Parse csv file with data
  parser = new Parser();
  map = parser.parse("vatten.csv");
  println(map.toString());
  
}

void draw()
{
  background(0);
  
  textFont(font,18*scale_factor);
  float obj_size = object_size*scale_factor; 
  float cur_size = cursor_size*scale_factor; 
   
  ArrayList tuioObjectList = tuioClient.getTuioObjectList();
  for (int i=0;i<tuioObjectList.size();i++) {
     TuioObject tobj = (TuioObject)tuioObjectList.get(i);
     stroke(255);
     fill(0);
     pushMatrix();
     translate(tx(tobj),ty(tobj));
     rotate(tobj.getAngle());
     rect(-obj_size/2,-obj_size/2,obj_size,obj_size);
     popMatrix();
     fill(255);
     text(""+tobj.getX() + " : " + tobj.getY(), tx(tobj), ty(tobj));
   }   
  
  if (!calibration.calibrated) calibration.draw(); 
}

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  println("add object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
  update(tobj);
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  if(tobj.getSymbolID() == 1){
     //myPort.write("c");
     println("Sending: c");
  }
  
  if(tobj.getSymbolID() == 2){
    //myPort.write("d");
     println("Sending: d");
  }
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  update(tobj);
}

void setCurrentFirstCountry(String name){
  currentFirstCountry = name;
  firstValueChanged = true;
}

void setCurrentSecondCountry(String name){
  currentSecondCountry = name;
  secondValueChanged = true;
}

void setCurrentLanguage(String name){
  currentLanguage = name;
}

void setCurrentYear(int year){
  currentYear = year;
  firstValueChanged = true;
  secondValueChanged = true;
}

String getCurrentFirstCountry(){
  return currentFirstCountry;
}

String getCurrentSecondCountry(){
  return currentSecondCountry;
}

String getCurrentLanguage(){
  return currentLanguage;
}

int getCurrentYear(){
  return currentYear;
}

void update(TuioObject tobj){
  // Year marker changed
  if(tobj.getSymbolID() == 0){ // TODO Replace this with id for slider symbol ID
    for(String key: yearPositions.keySet()){
      float [] yearPositionArray = yearPositions.get(key);
      if(yearPositionArray != null && yearPositionArray.length > 0){
        if(Math.abs(tobj.getX() - yearPositionArray[0]) <= acceptedDistanceYears){
          setCurrentYear(parseInt(key));
          println(getCurrentYear());
          break;
        }
      }
    }
  }
  //First country marker changed
  if(tobj.getSymbolID() == 1){
    for(String key: positions.keySet()){
      float [] positionArray = positions.get(key);
      float xDistance = tobj.getX() - positionArray[0];
      float yDistance = tobj.getY() - positionArray[1];
      if(Math.sqrt(xDistance*xDistance + yDistance*yDistance) < acceptedDistance ){
      if(getCurrentFirstCountry() != key){
          setCurrentFirstCountry(key);
          if(audioFiles.get(key+getCurrentLanguage()) == null){
            player = minim.loadFile(key + getCurrentLanguage() + format, 2048);
            audioFiles.put(key+getCurrentLanguage(), player);
             println("Creating: " + key + getCurrentLanguage());
          }else{
            println("Getting: " + key + getCurrentLanguage());
            player = audioFiles.get(key + getCurrentLanguage());
          }
          player.play();
          player.rewind();
          firstValueChanged = true;
          //delay(1000);
          break;
       }
     }
    }
  }
  //Second country marker changed
  if(tobj.getSymbolID() == 2){
    for(String key: positions.keySet()){
      float [] positionArray = positions.get(key);
      float xDistance = tobj.getX() - positionArray[0];
      float yDistance = tobj.getY() - positionArray[1];
      if(Math.sqrt(xDistance*xDistance + yDistance*yDistance) < acceptedDistance ){
         if(getCurrentSecondCountry() != key){
          setCurrentSecondCountry(key);
         if(audioFiles.get(key+getCurrentLanguage()) == null){
            player = minim.loadFile(key + getCurrentLanguage() + format, 2048);
            audioFiles.put(key+getCurrentLanguage(), player);
          }else{
            player = audioFiles.get(key+getCurrentLanguage());
          }
          player.play();
          player.rewind();
          secondValueChanged = true;
          //delay(1000);
          break;
         }
      }
    }
  }
  
  if(tobj.getSymbolID() == 3){
    for(String key: languagePositions.keySet()){
      float [] position = languagePositions.get(key);
        float distance = Math.abs(tobj.getY() - position[0]);
        if(distance < 0.05){
          if(getCurrentLanguage() != key){
            setCurrentLanguage(key);
            if(audioFiles.get(key) == null){
              player = minim.loadFile(key+format, 2048);
              audioFiles.put(key+format, player);
            }else{
              player = audioFiles.get(key + format);
              println(player);
            }
            player.play();
            player.rewind();
          }
        }
     }
  }
  
  if(map != null && map.get(getCurrentFirstCountry()) != null){
    firstValueToSend = "a" + map.get(getCurrentFirstCountry()).get(getCurrentYear()) + "\n"; 
  }
  if(map != null && map.get(getCurrentSecondCountry()) != null){
    secondValueToSend = "b" + map.get(getCurrentSecondCountry()).get(getCurrentYear()) + "\n";
  }
  
  if(firstValueToSend != null && firstValueChanged){
    myPort.write(firstValueToSend);
    println("Sending first: " + firstValueToSend);
    firstValueChanged = false;
  }
  if(secondValueToSend != null && secondValueChanged){
    myPort.write(secondValueToSend);
    println("Sending second: " + secondValueToSend);
    secondValueChanged = false;
  }
  
}

// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  println("add cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  println("update cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
          +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  println("remove cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
}

// called after each message bundle
// representing the end of an image frame
void refresh(TuioTime bundleTime) { 
  redraw();
}

void addTuioBlob(TuioBlob tblb){
}

void updateTuioBlob(TuioBlob tblb){
}

void removeTuioBlob(TuioBlob tblb){
}