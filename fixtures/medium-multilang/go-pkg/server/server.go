package server

import (
	"example.com/medium/handlers"
	"example.com/medium/store"
)

func Run() {
	s := store.New()
	handlers.Health(s)
	handlers.UserList(s)
	handlers.UserCreate(s, "ada")
}
