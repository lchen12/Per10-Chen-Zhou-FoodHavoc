import java.util.*;

public class MyLinkedList<T> implements Iterable<T>{

    private Node<T> head, tail;
    private int length;

    public MyLinkedList(){
        head = new Node<T>();
        length = 0;
	tail = head;
    }

    public Iterator<T> iterator(){
	return new MyLLIterator<T>(head);
    }

    public int size(){
        return length;
    }

    private Node<T> getNode(int position){
        if (position < -1){
            throw new IndexOutOfBoundsException("Linked List NEGATIVE index out of bounds");
        }else if (position >= length){
            throw new IndexOutOfBoundsException("Linked List index greater than length");
        }
        Node<T> temp = head;
        for (int i = -1; i < position; i++){
            temp = temp.getNext();
        }
        return temp;
    }

    public void add(T s){	
        Node<T> insert = new Node<T>(s);
	tail.setNext(insert);
	tail = tail.getNext();
	length++;
    }

    public void add(T s, int position){
	if (position == length){
	    add(s);
	}else{
	    Node<T> insert = new Node<T>(s);
	    Node<T> temp = getNode(position - 1);
	    insert.setNext(temp.getNext());
	    temp.setNext(insert);
	    length++;
	}
    }

    public T get(int position){
        return getNode(position).getData();
    }

    public void set(int position, T newT){
        getNode(position).setData(newT);
    }

    public void remove(int position){
        Node<T> temp = getNode(position - 1);
        temp.setNext(temp.getNext().getNext());
        length--;
	if (position==length){
	    tail = temp;
	}
    }

    public int find(T s){
        Node<T> temp = head.getNext();
        for (int i = 0; i < length; i++){
            if (temp.getData().equals(s)){
                return i;
            }
            temp = temp.getNext();
        }
        return -1;
    }

    public String toString(){
        String result = "[";
	for (int i = 0; i < length; i++){
            if (i==0){
                result+=" "+getNode(i).getData()+" ";
            }else{
                result+= ", "+getNode(i).getData()+" ";
            }
        }
        return result + "]";
    }
}

