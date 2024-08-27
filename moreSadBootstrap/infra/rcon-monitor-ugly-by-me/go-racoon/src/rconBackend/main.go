package main

import (
	"net/http"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/gorcon/rcon"
)

type RconCommand struct {
	Command  string `json:"command"`
	Host     string `json:"host"`
	Username string `json:"username"`
	Password string `json:"password"`
}

func main() {
	r := gin.Default()
	r.Use(cors.New(cors.Config{
		AllowOrigins: []string{"*"},
		AllowMethods: []string{"PUT", "PATCH", "POST", "GET"},
		AllowHeaders: []string{"Origin", "Content-Type"},
	}))
	r.Static("/", "./website/build")
	r.POST("/rcon", func(ctx *gin.Context) {
		ctx.Header("Content-Type", "application/json")
		var command RconCommand
		err := ctx.BindJSON(&command)
		if err != nil {
			ctx.String(http.StatusInternalServerError, "failed to parse received json")
			return
		}
		conn, err := rcon.Dial(command.Host, command.Password)
		if err != nil {
			ctx.String(http.StatusInternalServerError, "failed to connect to rcon host %s", command.Host)
			return
		}
		defer conn.Close()

		response, err := conn.Execute(command.Command)
		if err != nil {
			ctx.String(http.StatusInternalServerError, "failed to execute command %s on rcon host %s", command.Command, command.Host)
		}
		ctx.String(http.StatusOK, `{"response":"%s"}`, response)

	})
	r.Run("0.0.0.0:8080")
}
