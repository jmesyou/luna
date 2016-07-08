package main

import (
	"go/token"
	"go/ast"
)

var lookup func() = token.Lookup

type s_expr struct {
	value *atom
	args []*s_expr
}

type atom interface {}