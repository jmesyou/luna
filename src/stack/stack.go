package stack

import(
	"errors"
)

type Stack struct{
	elements []Element
}

type Element struct{
	data interface{}
}

//Returns a stack pointer
func NewStack() *Stack{
	return &Stack{make([]Element,1)}
}

func (s *Stack) Push(obj interface{}){
	s.elements = append(s.elements, Element{obj})
}

func (s *Stack) Pop() (interface{}, error){
	returnedObj, err := s.Peek()
	if err != nil{
		return returnedObj, errors.New("Stack.Pop: Empty")
	}
	s.elements = s.elements[:len(s.elements)-1]
	return returnedObj, nil
}

func (s *Stack) Peek() (interface{}, error){
	if len(s.elements) == 0{
		return nil, errors.New("Stack.Peek: Empty")
	}else{
		return s.elements[len(s.elements)-1].data, nil
	}
}
