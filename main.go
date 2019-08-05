package main

import (
	"bytes"
	"net/http"
	"os"

	"go.uber.org/zap"
)

func main() {
	logger, _ := zap.NewProduction()
	defer logger.Sync()
	if err := run(); err != nil {
		logger.Sugar().Errorf("%v\n", err)
		logger.Sugar().Fatalf("%v\n", err)
	}
}

func run() error {
	data := `{"text":"test"}`

	req, err := http.NewRequest(
		"POST",
		os.Getenv("WEBHOOK_URL"),
		bytes.NewBuffer([]byte(data)),
	)

	if err != nil {
		return err
	}

	req.Header.Set("Content-Type", "application/json")
	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	return nil
}
