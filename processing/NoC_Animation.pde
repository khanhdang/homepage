// Define 
color RouterColor = color(220);
float offset_ratio = 0.25;
PFont f;  
float Text_size = 20;
int tile_size = 200;
int flit_size = 50;
int cols = 7;
int rows = 5;
Router[][] layer;
int packet_num = 60000;
//Packet[] p1;
ArrayList p1;
PVector S, D;
int completed_num = 0;
PVector p0addr;

void setup() {

  size(1400, 1000);
  //fullScreen();
  f = createFont("Arial", Text_size, true);

  layer = new Router[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      layer[i][j] = new Router(int(i*tile_size), int(j*tile_size));
    }
  }
  //p1 =  new Packet[packet_num];
  p1 =  new ArrayList();
  //S = new PVector(int(random(7)), int(random(5)));
  //D = new PVector(int(random(7)), int(random(5)));
  for (int i = 0; i<packet_num; i++) {
    S = new PVector(int(random(cols)), int(random(rows)));
    D = new PVector(int(random(cols)), int(random(rows)));
    p1.add( new Packet(S, D, i));
  }

}

void draw() {
  background(177);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      layer[i][j].DrawARouter();
    }
  }
  ConnectRouter();
  boolean finish = false;
  int r_indx = 0;
  for (int i=0; i < p1.size();i++){
    Packet p = (Packet) p1.get(i);
    if (i==r_indx) {
      p.run = true;
    }

    if ((p.current.x >= p.Source.x+1 || p.current.x <= p.Source.x-1)) {
      r_indx++;
    //} else if (p.current.y >= p.Source.y+1 || p.current.y <= p.Source.y-1) {
    //  r_indx++;
    }
  }
  for (int i = p1.size()-1; i>=0; i--){
    Packet p = (Packet) p1.get(i);
    

    if (p.run){
      p.DrawFlit();
      p.Route();
      p.UpdatePos();
      //p.ResetRoute();
      finish = p.CheckFinish();
      if (finish) {
        p1.remove(i);
        //packet_num--;
        completed_num++;
       //print("\nDONE: "+str(completed_num));
       //if (completed_num == packet_num) print("\nDONE ALL !!!!!!!!!!");
  
      }
    }
  }
  
  //p1[1].dbg();
}

void ConnectRouter() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows-1; j++) {
      stroke(0);
      strokeWeight(10);
      line(layer[i][j].IO_South.x, layer[i][j].IO_South.y, layer[i][j+1].IO_North.x, layer[i][j+1].IO_North.y);
    }
  }
  for (int i = 0; i < cols-1; i++) {
    for (int j = 0; j < rows; j++) {
      stroke(0);
      strokeWeight(10);
      line(layer[i][j].IO_East.x, layer[i][j].IO_East.y, layer[i+1][j].IO_West.x, layer[i+1][j].IO_West.y);
    }
  }
}
// A Packet object
class Packet {
  // A Tile object knows about its location in the grid 
  // as well as its size with the variables x,y,w,h
  int index;
  boolean run;
  PVector Pos;
  PVector current;   // x,y location
  PVector Source, Destination;
  PVector Acce;
  int Speed = 4;
  float zsize = random(0.5,1);
  color rand_color;
  Packet(PVector S, PVector D, int i){
    index = i;
    Source = new PVector(S.x, S.y);
    Destination = new PVector(D.x, D.y);
    Acce = new PVector(0,0);
    current = new PVector(Source.x,Source.x);
    Pos = new PVector(Source.x*tile_size, Source.y*tile_size);
    rand_color = color(int(random(150,255)),int(random(150,255)),int(random(150,255)));
  }
  void Route() {
    current.x = ceil(Pos.x/tile_size);
    current.y = ceil(Pos.y/tile_size);
    if (current.x < Destination.x) {
      Acce.x = Speed;
      Acce.y = 0;
    } else if(current.x > Destination.x) {
      Acce.x = -Speed;
      Acce.y = 0;
    } else if(current.y < Destination.y) {
      Acce.x = 0;
      Acce.y = Speed;
    } else if(current.y > Destination.y) {
      Acce.x = 0;
      Acce.y = -Speed;
    } else {
      Acce.x = 0;
      Acce.y = 0;
      
    }
  }
  void UpdatePos(){
    if (Pos.x >= 0 && Pos.x <= width && Pos.y>=0 && Pos.y<=height){
    Pos.x = Pos.x+Acce.x;
    Pos.y = Pos.y+Acce.y;
    }
  }
  void ResetRoute(){
    if (ceil(Pos.x/tile_size) == Destination.x && ceil(Pos.y/tile_size) == Destination.y){
    Pos.x = Source.x*tile_size;
    Pos.y = Source.y*tile_size;
    }
  }
  boolean CheckFinish(){
    if (ceil(Pos.x/tile_size) == Destination.x && ceil(Pos.y/tile_size) == Destination.y){
      return true;
    } else {
      return false;
    }
    
  }
  void DrawFlit(){
    pushMatrix();

    translate(Pos.x+tile_size/2-flit_size/2, Pos.y+tile_size/2-flit_size/2);
    stroke(0);
    strokeWeight(1);
    fill(rand_color);
    rect(0,0,flit_size,flit_size);
    
    fill(0);
    textFont(f, Text_size);
    textAlign(CENTER, CENTER);
    text(str(index),flit_size/2, flit_size/2);
    
    popMatrix();

  }
  void dbg(){
    print("Source: "+str(Source.x)+ "--"+str(Source.y)+"\n");
    print("Acce: "+str(Acce.x)+ "--"+str(Acce.y)+"\n");
  }
}
// A Router object
class Router {
  // A Tile object knows about its location in the grid 
  // as well as its size with the variables x,y,w,h
  int x, y;   // x,y location
  PVector offset, router_size;
  PVector IO_North, IO_West, IO_South, IO_East, IO_Up, IO_Down;
  Router(int tempX, int tempY) {
    x = tempX;
    y = tempY;
    offset = new PVector((x+tile_size*offset_ratio), (y+tile_size*offset_ratio));
    router_size = new PVector((tile_size*(1-2*offset_ratio)), (tile_size*(1-2*offset_ratio)));
    IO_West = new PVector((x+tile_size*offset_ratio), (y+tile_size/2));
    IO_North = new PVector((x+tile_size/2), (y+tile_size*offset_ratio));
    IO_East = new PVector((x+tile_size-tile_size*offset_ratio), (y+tile_size/2));
    IO_South = new PVector((x+tile_size/2), (y+tile_size-tile_size*offset_ratio));
  } 

  void DrawARouter() {
    // offset and sizes

    // connection points

    noStroke();
    fill(207);
    rect(x, y, tile_size, tile_size);
    
    fill(RouterColor);
    
    stroke(0);
    strokeWeight(1);

    rect(offset.x, offset.y, router_size.x, router_size.y); 
    // Display the router's index
    fill(0);
    textFont(f, Text_size);
    textAlign(CENTER, CENTER);
    text("R("+str(int(x/tile_size))+","+str(int(y/tile_size))+")", x+tile_size/2, y+tile_size/2);
    strokeWeight(1);
   


  }
}