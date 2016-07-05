package main

import "fmt"

type s_expr struct {
	value *atom
	left  *s_expr
	right *s_expr
}

type atom struct {
	node interface{}
}


func f(b bool) interface{} {
	if b {
		return 1
	} else {
		return "2"
	}
}



func main() {
	a := atom{"abc"}
	fmt.Print(a.node)
}


/*func (expr string) parse() [][]string {
	var sexpr

}*/