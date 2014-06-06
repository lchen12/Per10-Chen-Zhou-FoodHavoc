import java.util.*;

public class MyStack<T> {

  private class Node<T> {
    private T data;
    private Node<T> next;
    public Node() {
      data = null;
      next = null;
    }
    public Node(T data) {
      this.data = data;
      next = null;
    }
    public Node<T> getNext() {
      return next;
    }
    public T getData() {
      return data;
    }
    public void setNext(Node<T> next) {
      this.next = next;
    }
    public String toString() {
      String result = data.toString();
      return result;
    }
  }

  private Node<T> top;

  public MyStack() {
    top = null;
  }

  public boolean empty() {
    return top == null;
  }

  public T peek() {
    if (empty()) {
      throw new EmptyStackException();
    } else {
      return top.getData();
    }
  }

  public T push(T data) {
    Node<T> insert = new Node<T>(data);
    insert.setNext(top);
    top = insert;
    return data;
  }

  public T pop() {
    //////////////////////////////
    T removed = peek();
    //////////////////////////////
    top = top.getNext();
    return removed;
  }

  public int search(Object o) {
    Node<T> temp = top;
    int count = 1;
    while (temp != null) {
      if (temp.getData().equals(o)) {
        return count;
      } else {
        count++;
        temp = temp.getNext();
      }
    }
    return -1;
  }

  //////////////////////////////////////////////////////

  public String toString() {
    String result = "[";
    Node<T> temp = top;
    while (temp != null) {
      result+=""+temp+",";
      temp = temp.getNext();
    }
    return result+"]";
  }
}

