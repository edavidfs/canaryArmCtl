void moveArm1(int position){
  String command = "#M1_G_";
  command = command + angleTostring(position);
  sendCommand(command);
}

void moveArm2(int position){
  String command = "#M2_G_";
  command = command + angleTostring(position);
  sendCommand(command);
}

void moveArm3(int position){
  String command = "#M3_G_";
  command = command + angleTostring(position);
  sendCommand(command);
}

void moveArm4(int position){
  String command = "#M4_G_";
  command = command + angleTostring(position);
  sendCommand(command);
}

void moveGripper(int position){
  String command = "#M5_G_";
  command = command + angleTostring(position);
  sendCommand(command);
}

void sendCommand(String command){
  println(command);
  myPort.write(command);
  lastCommand = command;
}

String lastCommandSended(){
  return lastCommand;
}

String angleTostring(int angle){
  String outputAngle;
  if (angle<10){
    outputAngle = "00"+str(angle);
  }else if(angle <100){
    outputAngle = "0"+str(angle);
  }else{
    outputAngle = str(angle);
  }
  return outputAngle;
}
