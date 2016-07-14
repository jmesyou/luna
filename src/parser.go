package main

import (
	"go/token"
	"go/ast"
	"regexp"
)

const STRING string = "'[_a-zA-Z][a-zA-Z0-9]*'"
const INT string = "[-]?[0-9]+"
const FLOAT string = INT + "[/.][0-9]+"

const noPos token.Pos = token.NoPos

var binaryOp = map[string]token.Token{
	"+": token.ADD,
	"-": token.SUB,
	"*": token.MUL,
	"/": token.QUO,
	"%": token.REM,
}

type parseError struct {
	msg string
}

func (err parseError) Error () string {
	return err.msg
}

type s_expr struct {
	value *atom
	args []*s_expr
}

type atom interface {

}


func parse (expr interface{}) (ast.Expr, error) {
	tokens, ok := expr.([]interface{})
	if ok {
		var key string
		for index, element := range tokens {
			key = element.(string)
			if val, ok := binaryOp[key]; ok {
				return ast.BinaryExpr{parse(tokens[index+1]), noPos, val, parse(tokens[index+2])}
			}
		}
	} else {
		atom, ok := expr.(string)
		if ok {
			return atomize(atom), nil
		}
	}
	return nil, parseError{"unknown token encountered"}
}

func atomize (atom string) ast.Expr {
	if match, _ := regexp.MatchString(STRING, atom); match {
		return &ast.BasicLit{noPos, token.STRING, atom}
	} else
	if match, _ := regexp.MatchString(INT, atom); match {
		return &ast.BasicLit{noPos, token.INT, atom}
	} else
	if match, _ := regexp.MatchString(FLOAT, atom); match {
		return &ast.BasicLit{noPos, token.FLOAT, atom}
	} else {
		return &ast.Ident{noPos, atom, nil}
	}
}