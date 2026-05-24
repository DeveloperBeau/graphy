package handlers

import (
	"fmt"

	"example.com/medium/store"
)

func OrderList(args ...any) {
	s, _ := args[0].(*store.Store)
	if s == nil {
		s = store.New()
	}
	for _, a := range args[1:] {
		if v, ok := a.(string); ok {
			s.Add(v)
		}
	}
	fmt.Println("orderList:", len(s.All()))
}
