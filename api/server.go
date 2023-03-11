package api

import (
	db "github.com/agilsyofian/minibank/db/sqlc"
	"github.com/gin-gonic/gin"
)

// Server serves HTTP request for banking services
type Server struct {
	store  db.Store
	router *gin.Engine
}

// NewServer creates a new HTTP server and setup routing
func NewServer(store db.Store) (*Server, error) {
	server := &Server{store: store}
	router := gin.Default()

	router.POST("/users", server.createUser)
	router.POST("/users/login", server.loginUser)

	server.router = router
	return server, nil
}

func (server *Server) Start(address string) error {
	return server.router.Run(address)
}

func errorResponse(err error) gin.H {
	return gin.H{"error": err.Error()}
}
