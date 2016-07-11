package main

import (
	"go/token"
	"go/ast"
)

type s_expr struct {
	value *atom
	args []*s_expr
}

type atom interface {

}

func parse ([]interface{}) ast.Expr {
	return nil
}

func main() {
	x := ast.BasicLit{0, token.INT, "1"}
	y := ast.BasicLit{0, token.INT, "2"}
	a := ast.BinaryExpr{x, 0, token.ADD, y}
	t := token.NewFileSet()
	ast.Print(t, a)
}