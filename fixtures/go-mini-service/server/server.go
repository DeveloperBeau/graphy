package server

import "example.com/mini/handlers"

type Server struct{}

func New() *Server { return &Server{} }

func (s *Server) Serve() {
	handlers.Health()
	handlers.User(1)
}
