class Node {
  // class for nodes of the graph
  
  // initializes variables
  
  // radius of node
  float radius;
  
  // radius of fluctuation
  float radius_temp;
  
  // position of node
  float xpos;
  float ypos;
  
  // color and opacity of node
  color color_node;
  float alpha;
 
  // used to initialize random "breathing" point for each node
  float framecount_random;
  
  // used to identify angle at which the initial highlighted animation is
  float angle;
  
  // used to hold angles which will construct the highlighted outer boundary
  ArrayList angles;
  
  // used to grow and shrink highlight animation
  float highlight_scale_factor;
  
  // used to grow and shrink initial display animation
  float display_scale_factor;
  
  // used to grow and shrink popup animation
  float popup_scale_factor;
  
  // used to grow and shrink solid fill animation
  float solid_scale_factor;
  
  // holders for popup dimensions/2
  float popup_width;
  float popup_height;
  
  // y position of popup
  float popup_ypos;
  
  // says how fast the highlight animation rotates
  float angle_rate;
  
  // class attribute which says if it is active and highlighted
  boolean is_clicked;
  
  // class attribute which says if it is being clicked and held and 
  // going to be moved
  boolean is_locked;
  
  // text for subject
  String subject_text;
  String fitted_subject_text;
  
  // text for content
  String content_text;
  String fitted_content_text;
  
  // text for sender
  String sender_text;
  
  // image for node
  PImage profile_image;
  
  
  Node(float size, float node_xpos, float node_ypos, color node_color, float alpha_value, String Subject_Text, String Content_Text, String Sender_Text, PImage Profile_Image) {
    
    // allows for 3 sizes of nodes, corresponding with 1, 2, and 3
    if (size == 1) {
      radius = 50;
      radius_temp = 50;
    }
    else if (size == 2) {
      radius = 70;
      radius_temp = 70;
    }
    else if (size == 3) {
      radius = 90;
      radius_temp = 90;
    }
    else {
      radius = 50;
      radius_temp = 50;
    }
    
    // node positions
    xpos = node_xpos;
    ypos = node_ypos;
    
    // color and opacity of node
    color_node = node_color;
    alpha = alpha_value;
    
    // initial breathing point of node
    framecount_random = random(1,1000);
    
    // initial angle at which the highlighted animation is
    angle = 0.0;
    
    // function within a class, should be its own function
    // but I didn't know how to incorporate that in java, 
    // so here it is, it generates an array of angles for pie slices
    // of random angle thickness with alternating color scheme
    // between white and the color of the node to generate the outer 
    // boundary of the highlight animation
    
    // initializes variables
    angles = new ArrayList();
    float totalAngle = 0;
    float lastAngle = 0;
    int i = 0;
    
    // adds 0 as the first angle to the array
    angles.add(0.0);
    
    // adds angles to array until final angle is greater than 360,
    while (totalAngle < 360) {
      float angle = random(1,13);
      
      // if next angle will meet while loop condition, just put final
      // angle as 360 to complete circle, otherwise, add next angle to 
      // the array
      if (angle + totalAngle > 360) {
        angles.add(360.0);
      } 
      else {
        angles.add(angle + totalAngle);
      }
      totalAngle += angle;
      i += 1;
    }
    // not exactly why this one is necessary, but it is soooooo
    // gotta have it
    angles.add(360-totalAngle);
    
    // outside of function now,
    // initial factor for highlight animation
    highlight_scale_factor = .6;
    
    // initial factor for standard display animation
    display_scale_factor = .4;
    
    // initial factor for popup animation
    popup_scale_factor = .4;
    
    // initial factor for solid fill animation
    solid_scale_factor = .4;
    
    // initial size for half of the actual width and height dimensions
    // (used half for bezier drawings)
    popup_width = 90.0;
    popup_height = 40.0;
    
    // y-position of popup, x-position is same node
    if (radius == 50) {
      popup_ypos = ypos - 1.4*radius - 20;
    } else if (radius == 70) {
      popup_ypos = ypos - 1.2*radius - 20;
    } else {
      popup_ypos = ypos - radius - 25;
    }
    
    // initial angle of rotation rate
    angle_rate = 1;
    
    // no node is initially clicked or locked
    is_clicked = false;
    is_locked = false;

    // text for subject header
    subject_text = Subject_Text;
    fitted_subject_text = subject_text;
    
    // text for content
    content_text = Content_Text;
    fitted_content_text = content_text;
    
    // text for sender
    sender_text = Sender_Text;
    
    // image for node
    profile_image = Profile_Image;
  }
  
  // method which displays initial standard node
  void display() {
    
    // this command allows you to do transformations and all of that jazz
    // to a specific set of objects, in this case, this one particular node
    pushMatrix();
    
    // in processing, translate moves the origin and coordinate system down to the 
    // selected point, so the origin is now the center of the node, or (0,0),
    // this will lead to expected results in scaling and rotations of objects
    translate(xpos, ypos);
    
    // if display scale factor is not yet up to 1, or fullsize, keep growing
    if (display_scale_factor < 1) {
      display_scale_factor += .01;
    }
    
    // scales the node
    scale(display_scale_factor);
    
    // identifies color and opacity of node
    fill(color_node,alpha);
    
    // identifies type of declaration of ellipse, giving coordinates to 
    // identify the center of the ellipse, or node
    ellipseMode(CENTER);
    
    // removes outer black border
    noStroke();
    
    // gives "breath" to the node, and the radius of the node fluctuates 
    // in and out based on the framecount which is always increasing, and 
    // the sine function takes care of this very well
    radius_temp = radius_temp + .075 * sin( (frameCount + framecount_random) * .02 );
    
    // draws quasi-transparent bigger outer shell of node
    ellipse(0, 0, radius_temp, radius_temp);
    
    // identifies color and full opaqueness
    fill(color_node);
    
    // draws solid smaller inner shell of node
    ellipse(0, 0, radius_temp/2, radius_temp/2);
    
    // gets out of transformation matrix
    popMatrix();
  }
  
  // fills the node with solid color
  void intro_solid_highlight() {
    
    // this command allows you to do transformations and all of that jazz
    // to a specific set of objects, in this case, this one particular node
    pushMatrix();
    
    // in processing, translate moves the origin and coordinate system down to the 
    // selected point, so the origin is now the center of the node, or (0,0),
    // this will lead to expected results in scaling and rotations of objects
    translate(xpos, ypos);
    
    // if display scale factor is not yet up to 1, or fullsize, keep growing
    if (solid_scale_factor < 1 && display_scale_factor > .9) {
      solid_scale_factor += .02;
    }
    
    // scales the node
    scale(solid_scale_factor);
    
    // identifies color and opacity of node
    fill(color_node);
    
    // identifies type of declaration of ellipse, giving coordinates to 
    // identify the center of the ellipse, or node
    ellipseMode(CENTER);
    
    // removes outer black border
    noStroke();
    
    if (display_scale_factor > .9) {
      // draws solid smaller inner shell of node
      ellipse(0, 0, radius, radius);
    }
    // gets out of transformation matrix
    popMatrix();
    
  }
  
  // removes the node with solid color
  void exit_solid_highlight() {
    
    // this command allows you to do transformations and all of that jazz
    // to a specific set of objects, in this case, this one particular node
    pushMatrix();
    
    // if factor is greater than .4, shrink it AND draw it
    if (solid_scale_factor > .4 && display_scale_factor > .9) {
      solid_scale_factor -= .02;
      
      // brings coordinate system to center of animation
      translate(xpos, ypos);
      
      // scales animation
      scale(solid_scale_factor);
      
      ellipse(0, 0, radius, radius); 
    }
    // gets out of transformation matrix
    popMatrix();
    
  }
  
  // method which generates highlighted animation
  void intro_clicked_highlight() {
    
    // puts on transformation matrix
    pushMatrix();
    
    // changes angle of rotation by angle rate
    angle += angle_rate;
    
    // if scale factor is less than 1 keep growing
    if (highlight_scale_factor < 1) {
      highlight_scale_factor += .02;
    }
    
    // bring coordinate system to center of node
    translate(xpos, ypos);
    
    // scales highlight animation
    scale(highlight_scale_factor);
    
    // rotates highlight animation
    //rotate(radians(angle));
    
    // draws highlight object with given generated angles
    draw_highlight(angles);
    
    // leaves transformation matrix
    popMatrix();
  }
  
  // method which displays the exit of the highlight animation
  void exit_clicked_highlight() {
    
    // puts on transformation matrix
    pushMatrix();
    
    // if factor is greater than .4, shrink it AND draw it
    if (highlight_scale_factor > .6) {
      highlight_scale_factor -= .01;
      
      // brings coordinate system to center of animation
      translate(xpos, ypos);
      
      // scales animation
      scale(highlight_scale_factor);
      
      // rotates animation
     // rotate(radians(angle));
      pushMatrix();
      scale(highlight_scale_factor);
      // draws highlight object with given generated angles
      draw_highlight(angles);
      popMatrix();
    }
    
    // exits transformation matrix
    popMatrix();
  }
     
  // method which actually generates the highlighted animation object
  // which is a circle made up of a lot of tiny arcs
  void draw_highlight(ArrayList angles) {
    
    // removes outer border
    noStroke();
    
    // used to identify which color each slice should be, initially set
    // so first slice is color of node
    boolean col = true;
    
    // iterates over each angle starting on the second angle
    for (int angle_index = 1; angle_index < angles.size(); angle_index++) {
      
      // chooses color of node if true, otherwise uses white, and then
      // switches the color for the next time
      if (col) {
        fill(color_node);
        col = false;
      } 
      else {
        fill(255);
        col = true;
      }
      
      // converts angle from degrees into radians, which is how this 
      // program does trig
      float prev_angle = radians((Float) angles.get(angle_index-1));
      float curr_angle = radians((Float) angles.get(angle_index));
      
      // draws arc with given color
      arc(0, 0, 1.2*radius, 1.2*radius, prev_angle, curr_angle);
    }
    
    // draws filler circle once all arcs have been drawn
    fill(color_node);
    ellipse(0, 0, 1.1*radius, 1.1*radius);
  }
  
  // method to rotate node
  void rotate_highlight() {
    
    // puts on transformation matrix
    pushMatrix();
    
    // changes angle of rotation by angle rate
    angle += angle_rate;
    
    // if scale factor is less than 1 keep growing
    if (highlight_scale_factor < 1) {
      highlight_scale_factor += .005;
    }
    
    // bring coordinate system to center of node
    translate(xpos, ypos);
    
    // scales highlight animation
    scale(highlight_scale_factor);
    
    // rotates highlight animation
    rotate(radians(angle));
    
    // draws highlight object with given generated angles
    draw_highlight(angles);
    
    // leaves transformation matrix
    popMatrix();
  }
    
    
  
  // method which returns true or false if the mouse is over
  // a node at a given time, use radius/1.5 because the program is 
  // finickey
  boolean mouse_over() {
    if (dist(mouseX, mouseY, xpos, ypos) < radius/1.5) {
      return true;
    }
    else {
      return false;
    }
  }
  
  void intro_popup() {
    pushMatrix();
     
    // if scale factor is less than 1.2 keep growing
    if (popup_scale_factor < 1) {
      popup_scale_factor += .03;
    }
    
    // bring coordinate system to center of node
    translate(xpos, popup_ypos);
    
    // scales highlight animation
    scale(popup_scale_factor);
    
    // draws highlight object with given generated angles
    draw_popup();
    
    // leaves transformation matrix
    popMatrix();
  }
  
  void exit_popup() {
     // puts on transformation matrix
    pushMatrix();
    
    // if factor is greater than .2, shrink it AND draw it
    if (popup_scale_factor > .4) {
      popup_scale_factor -= .016;
      
      // brings coordinate system to center of animation
      translate(xpos, popup_ypos);
      
      // scales animation
      scale(popup_scale_factor);
      
      // draws highlight object with given generated angles
      draw_popup();
    }
    
    // exits transformation matrix
    popMatrix();
  }
    
  void draw_popup() {
    // xr and yr and radius to inset (x/y)-coordinate corners for bezier controls,
    // may be negative to "outset"
    float xr = 0;
    float yr = 0;
    fill(255);
    noStroke();
    beginShape();
    // top center
    vertex(0, -popup_height);
    // top right
    bezierVertex(popup_width-xr, -popup_height, popup_width, -popup_height+yr, popup_width, 0);
    // bottom right
    bezierVertex(popup_width, popup_height-yr, popup_width-xr, popup_height, 0, popup_height);
    // bottom left
    bezierVertex(-popup_width+xr, popup_height, -popup_width, popup_height-yr, -popup_width, 0);
    // top left
    bezierVertex(-popup_width, -popup_height+yr, -popup_width+xr, -popup_height, 0, -popup_height);
    endShape();

    beginShape();
    vertex(-10, popup_height-2);
    vertex(10, popup_height-2);
    vertex(0, popup_height + 20/1.414);
    endShape();
    
    // create dividing lines between pictures and text
    stroke(176, 196, 222);
    strokeWeight(1);
    line(-popup_width*1/3, -popup_height + 10, -popup_width*1/3, popup_height - 10);
    line(-popup_width*1/6, 0, popup_width*5/6, 0);
    
    // fits subject text to fit with font 16
    textFont(f,16);
    float width_subject_text = textWidth(fitted_subject_text);
    if (width_subject_text > popup_width) {
      while (width_subject_text > popup_width) {
        subject_text = subject_text.substring(0, subject_text.length()-1);
        fitted_subject_text = subject_text + "...";
        width_subject_text = textWidth(fitted_subject_text);
      }
    }
    fill(0);
    textAlign(CENTER);
    text(fitted_subject_text, popup_width*2/6, -popup_height*1/2 + (textAscent() + textDescent())/3);
    
    textFont(f,10);
    // fits content text to fit with font 10
    float width_content_text = textWidth(fitted_content_text);
    if (width_content_text > popup_width) {
      while (width_content_text > popup_width) {
        content_text = content_text.substring(0, content_text.length()-1);
        fitted_content_text = content_text + "...";
        width_content_text = textWidth(fitted_content_text);
      }
    }
    fill(150);
    textAlign(CENTER);
    text(fitted_content_text, popup_width*2/6, popup_height*1/2);//(textAscent() + textDescent())/3);
    
    noStroke();
    fill(color_node);
    rectMode(CENTER);
    rect( -popup_width*2/3, 0, popup_width*8/15, popup_width*8/15);
    
    textFont(f,32);
    fill(255);
    textAlign(CENTER);
    text(sender_text.substring(0,1), -popup_width*2/3, 0 + (textAscent() + textDescent())/3);
    //imageMode(CENTER);
    //image(profile_image, -popup_width*2/3, 0, popup_width*9/15, popup_height*3/2); //popup_width*3/15*2);
  }
}
