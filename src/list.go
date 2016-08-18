package main
import "fmt"

//A list implemented with slices
type List struct{
	elements []Element
}

type Element struct{
	//needed to accept any data type
	data interface{}
}

//returns a list pointer
func NewList() *List{
	return &List{make([]Element, 0)}
}

//Adds
func (l *List) Add(obj interface{}){
	l.elements = append(l.elements, Element{obj})
}

func (l *List) Empty() bool{
	return len(l.elements) == 0
}

func (l *List) Prepend(obj interface{}){
	//make a new slice and add the object to it
	newSlice := make([]Element, 0)
	newSlice = append(newSlice, Element{obj})
	//assign the elements as the newslice + elements
	l.elements = append(newSlice, l.elements...)
}

func (l *List) Head() interface{}{
	if l.Empty(){
		return nil
	}
	return l.elements[0].data
}

func (l *List) Tail() *List{
	if l.Empty(){
		return nil
	}
	if len(l.elements) == 1{
		return l
	}
	//return the list with the first element removed
	return &List{l.elements[1:]}
}

//for debugging purposes, call the outputs
//require fmt
func (l *List) debug(){
	if l.Empty(){
		fmt.Println("The list is empty!")
	}
	if head := l.Head(); head != nil{
		fmt.Println("The head is: ", head)
	}
	if tail := l.Tail(); tail != nil{
		fmt.Println("The tail is: ", tail.elements)
	}
}
/*
func main(){
	newList := NewList()
	newList.debug()
	newList.Add("zero")
	newList.debug()
	newList.Add(1.1)
	newList.debug()
	newList.Prepend(-1)
	newList.debug()
}
*/
