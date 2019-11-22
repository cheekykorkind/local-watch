package main

import (
	"bufio"
	"fmt"
	"net/http"
	"os"
	"strconv"
	"strings"
)

type MemInfo struct {
	MemTotal, MemAvailable uint64
}

func changePersent(memStats map[string]*uint64) string {
	memTotal := float64(*memStats["MemTotal"])
	memAvailable := float64(*memStats["MemAvailable"])
	
	return strconv.FormatFloat (memAvailable / memTotal * 100, 'f', 2, 64)
}

func main() {
	file, err := os.Open("/proc/meminfo")
	if err != nil {
		fmt.Println(err)
	}
	defer file.Close()

	var memory MemInfo
	memStats := map[string]*uint64{
		"MemTotal":     &memory.MemTotal,
		"MemAvailable":      &memory.MemAvailable,
	}

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()

		i := strings.IndexRune(line, ':')

		fieldName := line[:i]
		pointer := memStats[fieldName]
		if pointer == nil {
			continue
		}
		
		strValue := strings.TrimSpace(strings.TrimRight(line[i+1:], "kB"))
		if v, err := strconv.ParseUint(strValue, 10, 64); err == nil {
			*pointer = v / 1000
		}
	}
	
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, changePersent(memStats))
	})
	http.ListenAndServe(":4000", nil)
}