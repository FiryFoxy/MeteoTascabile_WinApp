import controlP5.*;
ControlP5 cp5; // ControlP5 object
DropdownList portDropdown; // Dropdown list for ports
Button csvButton;
Button txtButton;


boolean prevImageButtonState = false;
public PImage csv;
public PImage txt;

public void loadImages(){
  csv = loadImage("csv.png");
  txt = loadImage("txt.png");
  csv.filter(INVERT);
  txt.filter(INVERT);
}

//posizione x, posizione y, base w, altezza h, immagine image
public boolean imageButton(int x, int y, int w, int h, PImage image){
  if(mouseX>x && mouseX<x+w && mouseY>y && mouseY<y+h && mousePressed){
    tint(127, 127, 127);
    smooth();
    image(image, x, y, w, h);
    prevImageButtonState = true;
    return false;
  }else{
    tint(255, 255, 255);
    smooth();
    image(image, x, y, w, h);
    if(prevImageButtonState){
      prevImageButtonState = false;
      return true;
    }else{
      return false;
    }
  }
}
/*
boolean csvBttnSetup = true;

public void CSVBttn() {
  if (csvBttnSetup) {
    csvButton = cp5.addButton("CSVBttn")
       .setValue(1) // Set a numeric value for the button
       .setPosition(5, 5)
       .setImages(csv)
       .updateSize();
    csvBttnSetup = false;
  }
}

boolean txtBttnSetup = true;

public void TXTBttn() {
  if (txtBttnSetup) {
    txtButton = cp5.addButton("TXTBttn")
       .setValue(2) // Set a numeric value for the button
       .setPosition(width - 55, 5)
       .setImages(txt)
       .updateSize();
    txtBttnSetup = false;
  }
}

public void CSVButtonPressed(int theValue) {
  println("CSV button pressed: " + theValue);
}

public void TXTButtonPressed(int theValue) {
  println("TXT button pressed: " + theValue);
}

*/

boolean found = false;
boolean refresh = true;
boolean setupList = true;
int prevPortN = 0;
public String portName = "";
public String[] portList;

public void PortList(){
  if(portList.length>prevPortN){
    refresh=true;
  }
  if(setupList){
    portDropdown = cp5.addDropdownList("Porte_seriali")
                        .setPosition(width/2-100, height/3+30)
                        .setSize(200, 80)
                        .setItemHeight(20)
                        .setBarHeight(20)
                        .setColorBackground(color(120))
                        .setColorActive(color(0))
                        .setColorForeground(color(200))
                        .close();
    setupList = false;
  }
  if(!found && refresh){
    portDropdown.show();
    if(portList.length > 0) {// Create dropdown list for ports
      portDropdown.clear();
      for (String port : portList) {
        portDropdown.addItem(port, port);
      }
    }
    refresh = false;
  }
  prevPortN = portList.length;
}

public void Porte_seriali(int theValue){
  portName = portList[(int)theValue];
  println("Selected port: "+portName);
}

//void controlEvent(ControlEvent theEvent) {
//  if(theEvent.isController()) {
//    portName = portList[(int)theEvent.getController().getValue()];
//    println("Selected port: "+portName);
//  }
//}

public boolean InitSerial(){
  if(!found){
    portList = Serial.list();
    if(portName!=""){
      serial = new Serial(this, portName, 9600);
      portDropdown.hide();
      println("Connected to serial");
      found = true;
      return true;
    }
    return false;
  }else{
    return true;
  }
}

public void CheckSerial(){
  if(found) {
    String[] portList = Serial.list();
    boolean portFound = false;
    for(String port : portList) {
      if(port.equals(portName)) {
        portFound = true;
        break;
      }
    }
    if (!portFound) {
      found = false;
      refresh = true;
      portName = "";
      //csvButton.hide();      
      //txtButton.hide();
      println("Serial port disconnected.");
    }
  }
}
