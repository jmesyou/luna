package main

import ("fmt"
	"strings"
)

type s_expr struct {
	value *atom
	left  *s_expr
	right *s_expr
}

type atom struct {
	node interface{}
}

func parse(expr string) []interface{} {
	expr = strings.Replace(expr, "(", " ( ", -1)
	expr = strings.Replace(expr, ")", " ) ", -1)
	tokens := strings.Fields(expr)
	var sexp []interface{}

	for _, token := range tokens {
		if token == "(" {
			var block []interface{}
			sexp = append(sexp, block)
		} else if token == ")" {
			continue
		}
	}
	return sexp
}

func main() {
	fmt.Println(parse("( () () ( ) )"))
}


/*func (expr string) parse() [][]string {
	var sexpr

}*/