//import processing.pdf.*;
boolean record;
// pop-up of input
//import javax.swing.*; 
//String preset="Input Network Size: X";
//int op1;
//String op1s = JOptionPane.showInputDialog(frame, "Option 1", preset);

boolean popup;
int popup_w = 600, popup_h = 600;
int popup_text_size = popup_w/40;
int popup_line_width = int(popup_text_size*1.2);
// 2D Array of objects
Tile[][] grid;

// Number of columns and rows in the grid
int cols = 1;
int rows = 1;
int tile_dim = 200;
float TSV_circle_w = tile_dim/7;
float router_width = 0.6;
float TSV_width = (1-router_width)/2;
float Text_size = tile_dim/10;
//Color
color RouterColor = color(242, 244, 255);
color DisableRouterColor = color(166, 179, 255);
color BorrowingTSVColor = color(255, 179, 71);
color VirtualTSVColor = color(155, 219, 171);
color NormalTSVColor = color(89, 131, 40);
color FailedTSVColor = color(183, 0, 32);
color DisableTSVColor = color(166, 179, 255);
// Display text
PFont f;  

// Some text names
String[] PORTS = {"WEST", "NORTH",  "EAST" , "SOUTH"};
String[] TSV_TYPES = {"normal", "defect", "borrow", "virtual", "disable"};

// Random
float injectionRate = 50;
boolean enableInjection = false;
int injectedTSV = 0;
int stepRun = 0;
// Update variable
int[] NeighborWeights = new int[4];
String[] NeighborStatus = new String[4];
boolean[] NeighborRQLink = new boolean[4];

void setup() {
  size(1000,1000);
  //fullScreen();

  
  
  cols = width/tile_dim;
  rows = height/tile_dim;
  tile_dim = min (width/cols, height/rows);
  f = createFont("Arial",40,true);
  grid = new Tile[cols][rows];
  LayerCreate();

  

}

void draw() {
  //if (record) {
    // Note that #### will be replaced with the frame number. Fancy!
  //  beginRecord(PDF, "frame-####.pdf"); 
  //}
  
  background(255);

  // The counter variables i and j are also the column and row numbers and 
  // are used as arguments to the constructor for each object in the grid.  
  LayerDraw();
  if (record) {
    endRecord();
  record = false;
  }
  if (popup) {
      DrawPopup();
  }
}

// Use a keypress so thousands of files aren't created
void mousePressed() {
  //record = true;
  print("mousePressed: "+mouseX+","+mouseY+"\n");
  print("next: "+str(stepRun)+"\n");
  if (stepRun == 0){
    print("START\n");
  }else if (stepRun == 1){
    LayerRandom();
  } else {
    if (stepRun%2 == 0)  LayerUpdate();
    if (stepRun%2 == 1)  LayerCreatLink();
  }
 
        
  stepRun++;
  
}
 
//void mouseReleased(){
//  popup = false;
//}
void keyPressed() {
  if (key == 'p') {
    record = true;
    //exit();
  } else if  (key == 'i'){
    popup = !popup;
  } else if (key == 'r'){
    LayerRandom();
    LayerUpdate();
    LayerCreatLink();
    LayerUpdate();
    LayerCreatLink();
  } else if (keyCode == ENTER){
    print("next: "+str(stepRun)+"\n");
    switch(stepRun){
      case 0: 
        break;
      case 1: 
        LayerRandom();
        break;
      case 2: 
        LayerUpdate();
        break;
      case 3: 
        LayerCreatLink();
        break;
      case 4: 
        LayerUpdate();
        break;
      case 5: 
        LayerCreatLink();
        break;
      case 6: 
        LayerUpdate();
        break;
      case 7: 
        LayerCreatLink();
        break;
      default:
        print("FINISH\n");
    }
    stepRun++;
  } else if (keyCode == BACKSPACE){
    stepRun = 0;
    
    setup();
  }
}

/*
 * Draws a lines with arrows of the given angles at the ends.
 * x0 - starting x-coordinate of line
 * y0 - starting y-coordinate of line
 * x1 - ending x-coordinate of line
 * y1 - ending y-coordinate of line
 * startAngle - angle of arrow at start of line (in radians)
 * endAngle - angle of arrow at end of line (in radians)
 * solid - true for a solid arrow; false for an "open" arrow
 */
void arrowLine(float x0, float y0, float x1, float y1,
  float startAngle, float endAngle, boolean solid)
{
  line(x0, y0, x1, y1);
  if (startAngle != 0)
  {
    arrowhead(x0, y0, atan2(y1 - y0, x1 - x0), startAngle, solid);
  }
  if (endAngle != 0)
  {
    arrowhead(x1, y1, atan2(y0 - y1, x0 - x1), endAngle, solid);
  }
}

/*
 * Draws an arrow head at given location
 * x0 - arrow vertex x-coordinate
 * y0 - arrow vertex y-coordinate
 * lineAngle - angle of line leading to vertex (radians)
 * arrowAngle - angle between arrow and line (radians)
 * solid - true for a solid arrow, false for an "open" arrow
 */
void arrowhead(float x0, float y0, float lineAngle,
  float arrowAngle, boolean solid)
{
  float phi;
  float x2;
  float y2;
  float x3;
  float y3;
  final float SIZE = 8;
  
  x2 = x0 + SIZE * cos(lineAngle + arrowAngle);
  y2 = y0 + SIZE * sin(lineAngle + arrowAngle);
  x3 = x0 + SIZE * cos(lineAngle - arrowAngle);
  y3 = y0 + SIZE * sin(lineAngle - arrowAngle);
  if (solid)
  {
    triangle(x0, y0, x2, y2, x3, y3);
  }
  else
  {
    line(x0, y0, x2, y2);
    line(x0, y0, x3, y3);
  }  
}


boolean RandomDefect(){
  float r = random(0,100);
  if (r <= injectionRate){
    return true;
  }else{
    return false;
  }
    
    
}
void LayerCreate() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      grid[i][j] = new Tile(i*tile_dim,j*tile_dim,tile_dim,tile_dim);
      
      
      
    }
  }
}
void LayerRandom() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      //grid[i][j].UpdateWeight(int(random(1,10)));
      enableInjection = RandomDefect();
      if (enableInjection){
        grid[i][j].UpdateTSV(int(random(0,4)), "defect");  
      }
      
    }
  }
}
void LayerUpdate() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (i==0){
        NeighborWeights[0] = 99;
        NeighborStatus[0] = "defect";
        NeighborRQLink[0] = false;
      }else{
        NeighborWeights[0] = int(grid[i-1][j].weight);
        NeighborStatus[0] = grid[i-1][j].TSV_status[2];
        NeighborRQLink[0] = grid[i-1][j].RQLink[2];
      } 
      if (j==0) {
        NeighborWeights[1] = 99;
        NeighborStatus[1] = "defect";
        NeighborRQLink[1] = false;
      }else{
        NeighborWeights[1] = int(grid[i][j-1].weight);
        NeighborStatus[1] = grid[i][j-1].TSV_status[3];
        NeighborRQLink[1] = grid[i][j-1].RQLink[3];
      }
      if (i == cols-1) {
        NeighborWeights[2] = 99;
        NeighborStatus[2] = "defect";
        NeighborRQLink[2] = false;
      }else{
        NeighborWeights[2] = int(grid[i+1][j].weight);
        NeighborStatus[2] = grid[i+1][j].TSV_status[0];
        NeighborRQLink[2] = grid[i+1][j].RQLink[0];
      }
      if (j == rows-1) {
        NeighborWeights[3] = 99;
        NeighborStatus[3] = "defect";
        NeighborRQLink[3] = false;
      }else{
        NeighborWeights[3] = int(grid[i][j+1].weight);
        NeighborStatus[3] = grid[i][j+1].TSV_status[1];
        NeighborRQLink[3] = grid[i][j+1].RQLink[1];
      }
      
      
      grid[i][j].UpdateNeighbors(NeighborWeights,NeighborStatus,NeighborRQLink);
      
    }
  }
}

void LayerCreatLink(){
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      
       grid[i][j].CreateLink();  
      
      
    }
  }    
 
}

void LayerDraw(){
   for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Oscillate and display each object

      // display
      grid[i][j].display();
    }
  }
}

//Tile Sample;
void DrawPopup(){
  //,, ,
    fill(255,200);
    stroke(0);
    
    pushMatrix();
    
    if (mouseX+popup_w < width && mouseY+popup_h < height){  
   
      translate(mouseX,mouseY);
    } else if (mouseX+popup_w >= width && mouseY+popup_h < height) {
      translate(mouseX-popup_w,mouseY);
    } else if (mouseX+popup_w < width && mouseY+popup_h >= height) {
      translate(mouseX,mouseY-popup_h);
    } else {
      translate(mouseX-popup_w,mouseY-popup_h);
    }
    rect(0,0,popup_w,popup_h);

    fill(0);    

    if (mouseX/tile_dim < cols && mouseY/tile_dim < rows){
      grid[mouseX/tile_dim][mouseY/tile_dim].DisplayVal();
    } else {
      text("No data.",popup_w/2,popup_h/2);
    }
    popMatrix();
}

// A Tile object
class Tile {
  // A Tile object knows about its location in the grid 
  // as well as its size with the variables x,y,w,h
  float x, y;   // x,y location
  float w, h;   // width and height
  //float angle; // angle for oscillating brightness
  float weight;
  //PVector[] TSV_addr = new PVector[4];
  //PVector Router_Addr;
  String RouterStatus = "Normal";
  String[] TSV_status =  {"normal", "normal", "normal", "normal"};
  String[] TSV_link = {"NULL", "NULL", "NULL", "NULL"};
  boolean[] RQLink = {false, false, false, false};

  int[] NeighborWeights = new int[4];
  String[] NeighborStatus = new String[4];
  boolean[] NeighborRQLink = new boolean[4];

  // Tile Constructor
  Tile(float tempX, float tempY, float tempW, float tempH) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    //TSV_status = tempTSV_status;
    weight = 1+min(y/tile_dim, rows-1-y/tile_dim)+ min(x/tile_dim, cols-1-x/tile_dim); // router's weight
    //TSV_addr[0] = new PVector();
  } 

  // Oscillation means increase angle
  void UpdateTSV (int i, String x) {
    TSV_status[i] = x;
  }

  void UpdateWeight(int i) {
    weight = i;
  }

  void UpdateLink (int i, String x) {
    TSV_link[i] = x;
  }

  void SelectTSVColor(String type) {
    //switch(TSV_status[i]){
    switch(type) {
    case "defect": 
      fill(FailedTSVColor);
      break;
    case "borrow":
      fill(BorrowingTSVColor);
      break;
    case "virtual":
      fill(VirtualTSVColor);
      break;
    case "disable":
      fill(DisableTSVColor);
      break;
    case "normal":
      fill(NormalTSVColor);
      break;
    default:
      fill(NormalTSVColor);
    }
  }

  void DrawARouter() {
    stroke(255);
    fill(207);
    rect(x, y, w, h);
    if (RouterStatus == "disable") {
      fill(DisableRouterColor);
    } else {
      fill(RouterColor);
    }
    float x_offset = x+w*TSV_width;
    float y_offset = y+h*TSV_width;
    float router_w = w*router_width;
    float router_h = h*router_width;
    float r_x_ind =  x/tile_dim;
    float r_y_ind =  y/tile_dim;
    rect(x_offset, y_offset, router_w, router_h); 
    // Display the router's index
    fill(0);
    textFont(f, Text_size);
    textAlign(CENTER, CENTER);
    text("Router("+str(int(r_x_ind))+","+str(int(r_y_ind))+")\n Weight = "+str(int(weight)), x+w/2, y+h/2);
  }
  void DrawLink() {
    // Display Link
    float TSV_x, TSV_y;
    for (int i=0; i < TSV_link.length; i=i+1) {
      switch(i) {
      case 0:
        TSV_x = x+w*TSV_width/2;
        TSV_y = y+h/2;
        break;
      case 1: //x+w/2,y+h*TSV_width/2
        TSV_x = x+w/2;
        TSV_y = y+h*TSV_width/2;
        break;
      case 2: // x+w*(TSV_width*3/2+router_width),y+h/2
        TSV_x = x+w*(TSV_width*3/2+router_width);
        TSV_y = y+h/2;
        break;
      case 3: //x+w/2,
        TSV_x = x+w/2;
        TSV_y = y+h*(TSV_width*3/2+router_width);
        break;
      default:
        TSV_x = x;
        TSV_y = y;
        break;
      }
      stroke(0);
      switch(TSV_link[i]) {
      case "NORTH": 
        stroke(#E51C52);
        fill(#E51C52);
        strokeWeight(3);
        //arrowLine( x+w/2,y,x+w*TSV_width/2,y+h/2-TSV_circle_w/2, radians(30), 0, true);
        arrowLine(TSV_x, TSV_y, x+w/2, y, 0, radians(30), true);
        strokeWeight(1);
        break;
      case "EAST": 
        stroke(#E51C52);
        fill(#E51C52);
        strokeWeight(3);
        //arrowLine(x+w,y+h/2, x+w/2,y+h*TSV_width/2+TSV_circle_w/2,  radians(30), 0, true);
        arrowLine(TSV_x, TSV_y, x+w, y+h/2, 0, radians(30), true);
        strokeWeight(1);
        break;
      case "SOUTH": 
        stroke(#E51C52);
        fill(#E51C52);
        strokeWeight(3);
        //arrowLine(x+w/2,y+h, x+w*(TSV_width*3/2+router_width)-TSV_circle_w/2,y+h/2,  radians(30), 0, true);
        arrowLine(TSV_x, TSV_y, x+w/2, y+h, 0, radians(30), true);
        strokeWeight(1);
        break;
      case "WEST": 
        stroke(#E51C52);
        fill(#E51C52);
        strokeWeight(3);
        //arrowLine(x,y+h/2, x+w/2,y+h*(TSV_width*3/2+router_width)-TSV_circle_w/2,  radians(30), 0, true);
        arrowLine(TSV_x, TSV_y, x, y+h/2, 0, radians(30), true);
        strokeWeight(1);
        break;
      }
    }
    stroke(0);
    fill(255);
  }
  void DrawTSVs() {
    for (int i=0; i < TSV_status.length; i=i+1) {
      SelectTSVColor(TSV_status[i]);
      //DrawTSVs(i);
      switch(i) {
      case 0: 
        rect(x, y+h*TSV_width, (w*TSV_width), h-(2*h*TSV_width)); 
        fill(255);
        //ellipse(x+w*TSV_width/2,y+h/2,TSV_circle_w,TSV_circle_w);
        fill(0);
        pushMatrix();
        translate(x+w*TSV_width/2, y+h/2);
        rotate(PI/2.0);
        text("TSV-0", 0, 0); //        text("0",);
        popMatrix();
        //DrawLink(x+w*TSV_width/2,y+h/2);
      case 1: 
        rect(x+w*TSV_width, y, w-(2*w*TSV_width), h*TSV_width);
        fill(255);
        //ellipse(x+w/2,y+h*TSV_width/2,TSV_circle_w,TSV_circle_w);
        fill(0);
        text("TSV-1", x+w/2, y+h*TSV_width/2);
      case 2: 
        rect(x+w*(TSV_width+router_width), y+h*TSV_width, (w*TSV_width), h-(2*h*TSV_width));
        fill(255);
        //ellipse(x+w*(TSV_width*3/2+router_width),y+h/2,TSV_circle_w,TSV_circle_w);
        fill(0);
        pushMatrix();
        translate(x+w*(TSV_width*3/2+router_width), y+h/2);
        rotate(PI/2.0);
        text("TSV-2", 0, 0);
        popMatrix();
      case 3: 
        rect(x+w*TSV_width, y+h*(TSV_width+router_width), w-(2*w*TSV_width), h*TSV_width);
        fill(255);
        //ellipse(x+w/2,y+h*(TSV_width*3/2+router_width),TSV_circle_w,TSV_circle_w);
        fill(0);
        text("TSV-3", x+w/2, y+h*(TSV_width*3/2+router_width));
      }
    }
  }

  void display() {

    // Draw a box of router
    DrawARouter();

    // Draw TSVs
    DrawTSVs();
    DrawLink();
  }
  void UpdateNeighbors(int[] weights, String[] status, boolean[] rq) {
    for (int i=0; i < 4; i=i+1) {
      NeighborWeights[i] = weights[i];
      NeighborStatus[i] = status[i];
      NeighborRQLink[i] = rq[i];
    }
  }

  int FindLink() {
    // input = neighboring weights
    boolean find_min = false;
    int min_ind = 4;
    for (int idx=0; idx < NeighborWeights.length; idx=idx+1) {
      if (weight >= NeighborWeights[idx] && NeighborStatus[idx] == "normal" && RQLink[idx] == false) {
        find_min = true;
        min_ind = idx;
      }
    }
    return min_ind;
  }
  void CreateLink() {
    int min_ind;
    for (int i=0; i<TSV_status.length; i=i+1) {
      if ((TSV_status[i] == "defect" || TSV_status[i] == "borrow") &&  TSV_link[i] == "NULL") {
        min_ind = FindLink();
        if (min_ind !=4) {
          TSV_link[i] = PORTS[min_ind];
          switch(TSV_link[i]) {
          case "WEST": 
            RQLink[0] = true;
            break;
          case "NORTH": 
            RQLink[1] = true;
            break;
          case "EAST": 
            RQLink[2] = true;
            break;
          case "SOUTH": 
            RQLink[3] = true;
            break;
            //default:
          }
        } else {
          //if (TSV_status[i] == "defect") 
          //TSV_status[i] = "disable"
          RouterStatus = "disable";
          //for (int z=0; z <TSV_link.length; z=z+1){
          //  UpdateLink(z, "NULL");
          //  RQLink[i] = false;
          //}
          //weight =-1;
        }
      } else {
        if (NeighborRQLink[i]) {
          TSV_status[i] = "borrow";
          //TSV_status[i] = "virtual";
        }
      }
    }
  }
  void DisplayVal() {
    textAlign(LEFT, TOP);
    textFont(f, popup_text_size);
    int sec_w = popup_line_width*7;

    text("Position: "+str(int(x/tile_dim))+","+str(int(y/tile_dim))+"\n Weight = "+str(int(weight))+", Status = "+RouterStatus, 0, 0);
    translate(0, 2*popup_line_width);

    for (int i=0; i<TSV_status.length; i=i+1) {
      text("Status("+str(i)+"): "+TSV_status[i]+"\n", 0, i*sec_w+popup_line_width);
      text("Link("+str(i)+"): "+TSV_link[i]+"\n", 0, i*sec_w+2*popup_line_width);
      text("NeighborWeight("+str(i)+"): "+NeighborWeights[i]+"\n", 0, i*sec_w+3*popup_line_width);
      text("NeighborStatus("+str(i)+"): "+NeighborStatus[i]+"\n", 0, i*sec_w+4*popup_line_width);
      text("RQLink("+str(i)+"): "+RQLink[i]+"\n", 0, i*sec_w+5*popup_line_width);
      text("NeighborRQLink("+str(i)+"): "+NeighborRQLink[i]+"\n", 0, i*sec_w+6*popup_line_width);
    }
  }
}