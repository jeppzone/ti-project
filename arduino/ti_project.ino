const int transistorPin = 9;
const int transistorPin2 = 11;
int ledPin = 13;
String input;
char puck;
int val;
int valueToSend;
int valueToSend2;
const byte numChars = 5;
char receivedCharacters[numChars];
boolean newData = false;
 String string;
 void setup() {
   pinMode(transistorPin, OUTPUT);
   pinMode(transistorPin2, OUTPUT);
   Serial.begin(9600);
 }
 
 void loop() {
   //analogWrite(transistorPin, 100);
   //analogWrite(transistorPin2, 100);
   recieveInput();
   getValue();
   writeValue();
 }
 
 void recieveInput() {
   static byte index = 0;
   char endMarker = '\n';
   char rc;
   
   while(Serial.available() > 0 && newData == false){
     rc = Serial.read();
     if(rc != endMarker){
       receivedCharacters[index] = rc;
       index++;
            
       if(index >= numChars){
         index = numChars - 1;
       }
     }else{
       receivedCharacters[index] = '\0';
       index = 0;
       newData = true;
     }
   }
 }
 void getValue(){
   if(newData){
     string="";
     for(int i = 1; i < sizeof(receivedCharacters); i++){
         string += receivedCharacters[i];
     }
   }
 }
 
 void writeValue(){
   val = floor(string.toInt());
   if(newData){
     valueToSend = map(val, 1, 100, 50, 140);
     if(receivedCharacters[0] == 'a'){
       analogWrite(transistorPin, valueToSend);
     }else if(receivedCharacters[0] == 'b'){
       analogWrite(transistorPin2, valueToSend);
     }
     newData = false; 
   }
 }
