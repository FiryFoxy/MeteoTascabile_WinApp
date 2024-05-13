import processing.serial.*;

Serial serial;
PFont font;
boolean deviceFound = false;

void setup() {
  size(400, 200);
  
  cp5 = new ControlP5(this);
  
  textAlign(CENTER, CENTER);
  textSize(20); 
  font = createFont("Arial", 20);
  textFont(font);
  fill(200);
  loadImages();
}

void draw(){
  if(!InitSerial()){    
    background(0);
    text("Connettere MeteoTascabile ;)", width/2, height/3);
    PortList();
  }else{
     if(serial.available() > 0){
      read = "";
      background(0);
      for(int i=0;i<4;i++){
        String inspect = serial.readStringUntil('\n');
        if(inspect == null){
          i--;
          continue;
        }else{
          read += inspect;
        }
      }
      text(read, width/2, height/2);
      if(selectingFile) {
        selectOutput("Select a file to write to:", "fileSelected");
        selectingFile = false; // Reset flag
      }
      
      if(imageButton(5, 5, 50, 50, csv) && !selectingFile) {
        selectingFile = true; // Set flag to indicate file selection needed
        button = TXT;
      }
      if(imageButton(345, 5, 50, 50, txt) && !selectingFile) {
        selectingFile = true; // Set flag to indicate file selection needed
        button = CSV;
      }
      
      /*
      CSVBttn();
      TXTBttn();
      */
    }else{
      CheckSerial();
    }
  }
}
