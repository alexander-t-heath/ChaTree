class Edge {
  // class for edges of the graph

  // intializes variables  
  
  // vertex locations
  float x1pos;
  float y1pos;
  float x2pos;
  float y2pos;
  
  // color of edge
  color color_edge;
  
  // thickness of edge
  float thickness;
  
  Edge(float xpos1, float ypos1, float xpos2, float ypos2, color edge_color, int strength) {
    
    // initializes variables as above
    x1pos = xpos1;
    y1pos = ypos1;
    x2pos = xpos2;
    y2pos = ypos2;
    color_edge = edge_color;
    
    // allows thickness to change between 1, 2, and 3, and if it's anything different, sets
    // it to the smallest
    if (strength == 1) {
      thickness = 4;
    }
    else if (strength == 2) {
      thickness = 6;
    }
    else if (strength == 3) {
      thickness = 12;
    }
    else {
      thickness = 4;
    }
  }
  
  // method which displays the edge
  void display() {
    
     // sets the stroke color, alpha level and thickness of the edge, 
     // and plots it
     stroke(color_edge, 200);
     strokeWeight(thickness);
     line(x1pos, y1pos, x2pos, y2pos);
  }
}
//class Edge {
//  // class for edges of the graph

//  // intializes variables  
  
//  // vertex locations
//  float x1pos;
//  float y1pos;
//  float x2pos;
//  float y2pos;
  
//  // color of edge
//  color color_edge;  
  
//  // thickness of edge
//  float thickness;
  
//  Edge(float xpos1, float ypos1, float xpos2, float ypos2, color edge_color, int strength) {
    
//    // initializes variables as above
//    x1pos = xpos1;
//    y1pos = ypos1;
//    x2pos = xpos2;
//    y2pos = ypos2;
//    color_edge = edge_color;
    
//    // allows thickness to change between 1, 2, and 3, and if it's anything different, sets
//    // it to the smallest
//    if (strength == 1) {
//      thickness = 4;
//    }
//    else if (strength == 2) {
//      thickness = 6;
//    }
//    else if (strength == 3) {
//      thickness = 12;
//    }
//    else {
//      thickness = 4;
//    }
//  }
  
//  // method which displays the edge
//  void display() {
    
//     // sets the stroke color, alpha level and thickness of the edge, 
//     // and plots it
//     stroke(color_edge, 200);
//     strokeWeight(thickness);
//     line(x1pos, y1pos, x2pos, y2pos);
//  }
//}
