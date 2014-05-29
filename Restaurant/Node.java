public class Node<T>{

    private T data;
    private Node<T> next;

    public Node(){
        data = null;
        next = null;
    }

    public Node(T data){
        this.data = data;
        next = null;
    }

    public Node<T> getNext(){
        return next;
    }

    public T getData(){
        return data;
    }

    public void setData(T data){
        this.data = data;
    }

    public void setNext(Node<T> next){
        this.next = next;
    }

    public String toString(){
        String result = data.toString();
        return result;
    }

}
