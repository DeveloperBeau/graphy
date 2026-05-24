package handlers

import "fmt"

func Health() {
	fmt.Println("ok")
}

func User(id int) {
	fmt.Printf("user %d\n", id)
}
