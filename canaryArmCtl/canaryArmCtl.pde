import processing.serial.*;
import controlP5.*;

ControlP5 MyController;

int gripperSlider;
int arm1Knob;
int arm2Slider;
int arm3Slider;
int arm4Slider;
String dataInput;
String lastCommand;
String textValue = "";
Textarea myTextarea;
Textlabel myTextlabelA;
Textfield myTextField;
Boolean play;
int time;
int lasTime;
int timeBetweenCommandListValue = 5000;

boolean isGripperOpen = false;

String openGripper = "#M4_G_000";
String closeGripper = "#M5_G_180";

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port

void setup(){
  PFont font = createFont("arial",20);
  size(600,500);
  println(Serial.list());
  String portName = Serial.list()[7]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  myPort.clear();
  myPort.bufferUntil('\n'); 
  play = false;
  
  MyController = new ControlP5(this);
  MyController.addSlider("gripperSlider")
     .setPosition(50,50)
     .setRange(0,180)
     .setWidth(250)
     .setSliderMode(Slider.FLEXIBLE)
     ;
  //MyController = new ControlP5(this);
  MyController.addSlider("arm2Slider")
     .setPosition(50,100)
     .setRange(0,90)
     .setWidth(250)
     .setSliderMode(Slider.FLEXIBLE)
     ;
     
  //MyController = new ControlP5(this);
  MyController.addSlider("arm3Slider")
     .setPosition(50,150)
     .setRange(0,90)
     .setWidth(250)
     .setSliderMode(Slider.FLEXIBLE)
     ;
  
  //MyController = new ControlP5(this);
  MyController.addSlider("arm4Slider")
     .setPosition(50,200)
     .setRange(0,90)
     .setWidth(250)
     .setSliderMode(Slider.FLEXIBLE)
     ;
  //MyController = new ControlP5(this);
  MyController.addKnob("arm1Knob")
    .setRange(0,180)
    .setValue(90)
    .setPosition(150,250)
    .setRadius(50)
    .setDragDirection(Knob.VERTICAL)
    ;
    
  //MyController = new ControlP5(this);
  myTextarea = MyController.addTextarea("List")
    .setPosition(400,50)
    .setSize(150,250)
    .setFont(createFont("arial",12))
    .setLineHeight(14)
    .setColor(color(128))
    .setColorBackground(color(255,100))
    .setColorForeground(color(255,100));
    ;
    
   MyController.addButton("playCommandList")
     .setCaptionLabel("Play") 
     .setValue(0)
     .setPosition(400,325)
     .setSize(75,30)
     ;
   MyController.addButton("stopCommandList")
     .setCaptionLabel("Stop") 
     .setValue(0)
     .setPosition(485,325)
     .setSize(75,30)
     ;
   myTextField = MyController.addTextfield("TimeBetweenCommandList")
     .setPosition(400,365)
     .setSize(155,30)
     .setFont(font)
     .setFocus(false)
     .setColor(color(255,0,0))
     ;
   MyController.addButton("addCommand")
     .setCaptionLabel("Add Command") 
     .setValue(0)
     .setPosition(400,415)
     .setSize(160,30)
     ;
   MyController.addButton("clearCommand")
     .setCaptionLabel("Clear Command") 
     .setValue(0)
     .setPosition(400,455)
     .setSize(160,30)
     ;

  
}

void draw(){

  time = millis()-lasTime;
  if (play == true && time>timeBetweenCommandListValue){
    print("Time: ");
    println(time);
    playCommandList(0);
    lasTime = millis();
  }
}

void mouseReleased(){
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isController()) {
    //print("control event from : "+theEvent.controller().name());
    //println(", value : "+theEvent.controller().value());
    
    // clicking on Gripper Slider      
    if(theEvent.controller().name()=="gripperSlider") {
     moveGripper(gripperSlider);    
    }
    
    // clicking on Angle Knob      
    if(theEvent.controller().name()=="arm1Knob") {
     moveArm1(arm1Knob);    
    } 
    
    // clicking on Arm2 Slider      
    if(theEvent.controller().name()=="arm2Slider") {
     moveArm2(arm2Slider);    
    }
    
    // clicking on Arm3 Slider      
    if(theEvent.controller().name()=="arm3Slider") {
     moveArm3(arm3Slider);    
    } 
    
    // clicking on Arm4 Slider      
    if(theEvent.controller().name()=="arm4Slider") {
     moveArm4(arm4Slider);    
    } 
  }
}

public void addCommand(int theValue) {
  String lastCommandList;
  print("Adding comand: ");
  println(lastCommandSended());
  lastCommandList = myTextarea.getStringValue();
  myTextarea.setText(lastCommandList + lastCommandSended() + "\n");

}
public void playCommandList(int theValue) {
   //print("Play comand: ");
   sendCommand(myTextarea.getText());
   play = true;
}

public void stopCommandList(int theValue) {
   print("Stop comand: ");
   play =  false;
}

public void clearCommand(int theValue) {
   print("Clear comand");
   myTextarea.setText("");
}

void serialEvent(Serial myPort){
  dataInput = myPort.readString();
  println(dataInput);
}

public void TimeBetweenCommandList(String theText) {
  // automatically receives results from controller input
  println("a textfield event for controller 'input' : "+theText);
  timeBetweenCommandListValue = int(theText);
}


