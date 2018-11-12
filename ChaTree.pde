import processing.core.*;

// initializes variables for graph

// for size of window
int WIDTH = 1500;
int HEIGHT = 800;

// to hold nodes, edges, and colors
ArrayList nodes;
ArrayList edges;
ArrayList colors;

// to allow only one node be selected per click
boolean global_clicked;

// to allow only one node be moved per mouse press
boolean global_locked;

// to tell if shift or control is pressed in a global environment
// mainly for modifying edges and nodes
boolean shift_pressed;
boolean ctrl_pressed;

// to hold the place of the active node in order
// to ensure accuracy of edge formation
Node last_clicked;

// keeps track of last clicked nodes
Node_Stack node_stack;

// keeps track of where the screen is
float x_translate;
float y_translate;

// declares font
PFont f;

// declares node text
String subject_text;
String content_text;
String sender_text;

// declares node image
PImage profile_image;


// run at the beginning of the program
void setup() {

  // initializes gui size and frame rate
  // size(WIDTH, HEIGHT);
  size(1500, 800);
  frameRate(60);

  // initializes variables as above
  nodes = new ArrayList();
  edges = new ArrayList();
  colors = new ArrayList();

  // adds possible colors of nodes to an array
  colors.add( color(#CA5FE0) );
  colors.add( color(#FF9829) );
  colors.add( color(#FF3131) );
  colors.add( color(#62C1FF) );

  // initializes variables as above
  global_clicked = false;
  global_locked = false;
  shift_pressed = false;
  ctrl_pressed = false;
  node_stack = new Node_Stack();
  x_translate = 0.0;
  y_translate = 0.0;

  // call for smoother animation
  smooth();
  
  // sets up font
  f = createFont("Arial", 12, true);
  
  // declares node subject text
  subject_text = "This is the subject";
  
  // declares node content text
  content_text = "a b c d e f g h i j k l m";
  
  // declares sender text
  sender_text = "Heath";
  
  // declares image
  profile_image = loadImage("Lovett Crest Processing.png");
  
  
}


// always looped through
void draw() {

  // WIDTH = displayWidth;
  // HEIGHT = displayHeight;
  // size(displayWidth, displayHeight);
  // gives background color
  background(#CBFFFB);
    
  Node last_clicked = (Node) node_stack.get_first();

  // iterates through all stored edges and displays them
  // edges are first so that nodes overlay ends of edges
  for (int edge_index = edges.size ()-1; edge_index > -1; edge_index--) {
    Edge e = (Edge) edges.get(edge_index);
    e.display();
  }

  // creates new edge anchored at last clicked node and fllows mouse
  // position around
  if (shift_pressed) {
    //Node last_clicked = (Node) node_stack.get_first();
    Edge e = new Edge(last_clicked.xpos, last_clicked.ypos, mouseX, mouseY, color(#57D358, 200), 2);
    e.display();
  }

  // iterates through all stored nodes and displays them 
  // goes backwards so that the clicking order further down is the same
  // as the showing order, i.e., if two nodes are stacked on top of 
  // one another, and you click in the same radius space, only the top one
  // will be activated and moved
  for (int node_index = nodes.size ()-1; node_index > -1; node_index--) {
    Node n = (Node) nodes.get(node_index);
    n.display();

    // if the node has been clicked and is active, run highlight animation
    // otherwise, run close highlight animation
    
    if (last_clicked == n) {;//n.is_clicked && last_clicked == n) {
      n.intro_clicked_highlight();
      n.rotate_highlight();
      //n.intro_popup();
    } else {
      n.exit_clicked_highlight();
      //n.exit_popup();
    }
    
    //if (n.is_clicked && last_clicked == n) {
      //n.rotate_highlight();
    //}
    
    // if the node has the mouse over it, run solid display animation
    // otherwise, run close solid display animation
    
    if (n.mouse_over() == true) {
      n.intro_solid_highlight();
    }
    else {
      n.exit_solid_highlight();
    }
    
  }
  for (int node_index = nodes.size ()-1; node_index > -1; node_index--) {
    Node n = (Node) nodes.get(node_index);
    if (last_clicked == n) {;//n.is_clicked && last_clicked == n) {
      n.intro_popup();
    }
    else {
      n.exit_popup();
    }
  }
}

// runs if a key is pressed
void keyPressed() {

  // conditions to see if there is an active node
  // and that the key is the Shift key, if so change global shift pressed boolean
  // to true, and if control is pressed down change global control pressed boolean
  // to true
  if (node_stack.get_size() != 0) {
    if (key == CODED) {
      if (keyCode == SHIFT) {
        shift_pressed = true;
      }
      if (keyCode == CONTROL) {
        ctrl_pressed = true;
      }
    }
  }
}

// runs if a key is released
void keyReleased() {

  // conditions to see if the key that was released was the shift key or the 
  // control key, if so change global boolean to false
  if (key == CODED) {
    if (keyCode == SHIFT) {
      shift_pressed = false;
    }
    if (keyCode == CONTROL) {
      ctrl_pressed = false;
    }
  }
}

// runs if any mouse button was clicked, a.k.a. quickly pressed and released,
// different if holding
void mouseClicked() {

  // initially says that no node was clicked
  boolean node_clicked = false;

  // if there are no nodes, create one with random color and size 
  // where the mouse was clicked, and add it to the node structure
  if (nodes.size() == 0) {
    color col = (Integer) colors.get(int(random(0, 4)));
    int sizeNode = int(random(1, 4));
    nodes.add( new Node( sizeNode, mouseX, mouseY, col, 100, subject_text, content_text, sender_text, profile_image) );
  }

  // otherwise
  else {

    // iterates through all of the nodes
    //boolean clicked_on_node = false;
    for (int node_index=0; node_index<nodes.size (); node_index++) {
      Node n = (Node) nodes.get(node_index);

      // checks to see if shift was pressed and if the mouse was over a node,
      // a.k.a mouse was clicked on the node while shift was held down,
      // creates a new edge between the last clicked node and the current node
      if (shift_pressed) {
        if (n.mouse_over()) {
          Node last_clicked = (Node) node_stack.get_first();
          if (n != last_clicked) {
            edges.add( new Edge( n.xpos, n.ypos, last_clicked.xpos, last_clicked.ypos, color(#57D358, 200), 2 ) );
            //clicked_on_node = true;
          }
        }
      }

      // sees if node was clicked on
      if (n.mouse_over()) {
        
        Node last_clicked = (Node) node_stack.get_first();
        // checks to see if the shift key was pressed when the click happened,
        // if so, doesn't activate or deactivate node
        // checks to see if another node had already been selected for this click,
        // iterates in the way in which the nodes are shown, top to bottom, so bottom nodes
        // won't "override" top nodes
        if (global_clicked == false) {  
          if (shift_pressed == false) {


            // if not activated, activate it
            //if (n.is_clicked == false) {
            if (n != last_clicked) {;
              //n.is_clicked = true;
              // if node was clicked on, make it last clicked node
              //if (n.is_clicked) {
                //if (n.mouse_over()) {
                  node_stack.push(n);
                //}
              //}
            }
            // if activated, deactivate it
            else {
              //n.is_clicked = false;
              node_stack.pop(n);
            }

            // let the system know that a node has been clicked on for this click
            global_clicked = true;
          }
          // identifies that a node was clicked on
          node_clicked = true;
        }
      }

      // if control is held while clicked, deactivates all nodes
      if (ctrl_pressed) {
        n.is_clicked = false;
      }
    }
    
        

    // out of the node iterations, set global clicked to false
    global_clicked = false;

    // if a node was not clicked on and control was not pressed,
    // creates a new node at the mouse with random color and size
    if (node_clicked == false && ctrl_pressed == false) {  
      color col = (Integer) colors.get(int(random(0, 4)));
      int sizeNode = int(random(1, 4));
      
      nodes.add( new Node( sizeNode, mouseX, mouseY, col, 100, subject_text, content_text, sender_text, profile_image) );
      //n.intro_clicked_highlight();
      if (shift_pressed == true) {
        Node n = new Node(sizeNode, mouseX, mouseY, col, 100, subject_text, content_text, sender_text, profile_image);
        Node last_clicked = (Node) node_stack.get_first();
        edges.add( new Edge( n.xpos, n.ypos, last_clicked.xpos, last_clicked.ypos, color(#57D358, 200), 2 ) );
      }
    }
  }
}

// runs if mouse button is pressed and held
void mousePressed() {

  // iterates through nodes
  for (int node=0; node < nodes.size (); node++) {
    Node n = (Node) nodes.get(node);

    // if mouse is over a node at the time of the initial press
    // it "locks" the one node and doesn't allow other nodes to be locked
    // as well with setting global locked to true, "locks" means that the 
    // position will be the same as the mouse position as seen down below
    if (n.mouse_over()) { 
      if (global_locked == false) {
        n.is_locked = true; 
        global_locked = true;
      }
    }
  }
}

// runs if mouse moves while mouse button is pressed
void mouseDragged() {

  // iterates through nodes
  for (int node_index =0; node_index < nodes.size (); node_index++) {
    Node n = (Node) nodes.get(node_index);

    // sees if node is "locked"
    if (n.is_locked) {

      // if so, iterates through edges and sees if either vertex of an edge is 
      // the same as the center of the locked node, if it is, change the vertex 
      // of the edge to be the mouse position
      for (int edge_index = 0; edge_index < edges.size (); edge_index++) {
        Edge e = (Edge) edges.get(edge_index);
        if (e.x1pos == n.xpos && e.y1pos == n.ypos) {
          e.x1pos = mouseX;
          e.y1pos = mouseY;
        } else if (e.x2pos == n.xpos && e.y2pos == n.ypos) {
          e.x2pos = mouseX;
          e.y2pos = mouseY;
        }
      }

      // change the position of the node to be the mouse position
      n.xpos = mouseX; 
      n.ypos = mouseY;
      if (n.radius == 50) {
        n.popup_ypos = n.ypos - 1.4*n.radius - 20;
      } else if (n.radius == 70) {
        n.popup_ypos = n.ypos - 1.2*n.radius - 20;
      } else {
        n.popup_ypos = n.ypos - n.radius - 25;
      }
    }
  }
}

// runs when a mouse button is released after mousepressed() runs
void mouseReleased() {

  // iterates through nodes
  for (int node=0; node < nodes.size (); node++) {
    Node n = (Node) nodes.get(node);

    // "unlocks" all nodes and sets global locked variable to false
    n.is_locked = false;
    global_locked = false;
  }
}
