ArrayList stack;

class Node_Stack {
  // don't quite need this yet/don't know if I will need it
  Node_Stack() {
    stack = new ArrayList();
  }

  void push(Node node) {
    if (stack.size() > 0) {
      Node n = (Node) stack.get(stack.size()-1);
      stack.remove(n);
      stack.add( node );
    }
    else {
      stack.add(node);
    }
  }

  void pop(Node node) {
    if (stack.size() != 0) {
      stack.remove(node);
    }
  }

  int get_size() {
    return stack.size();
  }

  Node get_first() {
    if (stack.size() > 0) {
      Node n = (Node) stack.get(stack.size()-1);
      return n;
    }
    else {
      return null;
    }
  }
}
