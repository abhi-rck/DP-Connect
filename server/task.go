package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"strconv"
	"sync"
	"time"
)

type Person struct {
	Id           int          `json:"id"`
	Uid          string       `json:"uid"`
	Name         string       `json:"name"`
	Email        string       `json:"email"`
	Address      string       `json:"address"`
	PhoneNumber  string       `json:"phone"`
	UserType     string       `json:"type"`
	Desc         string       `json:"desc"`
	PendingUid   map[int]bool `json:"pendingRequests"`
	RequestedUid map[int]bool `json:"requestedRequests"`
	ConnectedUid map[int]bool `json:"connectedRequests"`
}

type PersonShow struct {
	Id          int    `json:"id"`
	Name        string `json:"name"`
	Email       string `json:"email"`
	Address     string `json:"address"`
	PhoneNumber string `json:"phone"`
	UserType    string `json:"type"`
	Desc        string `json:"desc"`
}

type User struct {
	Uid string `json:"uid"`
	Id  int    `json:"id"`
}

type UserRequest struct {
	Uid         string `json:"uid"`
	RequestedId int    `json:"requestedId"`
}

var m map[string]Person

var mu sync.Mutex
var count int

func loginUser(w http.ResponseWriter, r *http.Request) {
	var user User
	reqBody, error := ioutil.ReadAll(r.Body)
	fmt.Println(error)
	json.Unmarshal(reqBody, &user)

	v, found := m[user.Uid]
	if found {
		json.NewEncoder(w).Encode(v)
	}
}

func createUser(w http.ResponseWriter, r *http.Request) {
	var person Person
	reqBody, _ := ioutil.ReadAll(r.Body)
	json.Unmarshal(reqBody, &person)
	mu.Lock()
	count++
	person.Id = count
	person.Uid = strconv.Itoa(int(time.Now().UnixNano()))
	mu.Unlock()
	person.Id = count
	person.PendingUid = make(map[int]bool)
	person.RequestedUid = make(map[int]bool)
	person.ConnectedUid = make(map[int]bool)
	m[person.Uid] = person
	json.NewEncoder(w).Encode(person)
}

func deleteUser(w http.ResponseWriter, r *http.Request) {
	var user User
	reqBody, _ := ioutil.ReadAll(r.Body)
	json.Unmarshal(reqBody, &user)
	_, found := m[user.Uid]
	if found {
		delete(m, user.Uid)
	} else {
		fmt.Fprintf(w, "User Not found to delete")
	}
}
func updateUserData(w http.ResponseWriter, r *http.Request) {
	var person Person
	reqBody, _ := ioutil.ReadAll(r.Body)
	json.Unmarshal(reqBody, &person)
	v, found := m[person.Uid]
	if found {
		if person.Name != "" {
			v.Name = person.Name
		}
		if person.Desc != "" {
			v.Desc = person.Desc
		}
		if person.Address != "" {
			v.Address = person.Address
		}
		if person.Email != "" {
			v.Email = person.Email
		}
		if person.PhoneNumber != "" {
			v.PhoneNumber = person.PhoneNumber
		}
		if person.UserType != "" {
			v.UserType = person.UserType
		}
		m[person.Uid] = v
		fmt.Fprintf(w, "User Data upadated successfully.")
		json.NewEncoder(w).Encode(v)
	} else {
		fmt.Fprintf(w, "User Not found to update")
	}
}

func getUserDataById(w http.ResponseWriter, r *http.Request) {
	var user User
	reqBody, error := ioutil.ReadAll(r.Body)
	fmt.Println(error)
	json.Unmarshal(reqBody, &user)
	found := false
	for index := range m {
		if m[index].Id == user.Id {
			json.NewEncoder(w).Encode(m[index])
			found = true
		}
	}
	if found == false {
		fmt.Fprintf(w, "User donot exists with such userId")
	}
}

func getAllDonors(w http.ResponseWriter, r *http.Request) {
	var user User
	reqBody, error := ioutil.ReadAll(r.Body)
	fmt.Println(error)
	json.Unmarshal(reqBody, &user)
	if m[user.Uid].UserType == "patient" {
		var persons []PersonShow
		for index := range m {
			if m[index].UserType == "donor" {
				var personShow PersonShow
				personShow.Id = m[index].Id
				personShow.Name = m[index].Name
				personShow.Desc = m[index].Desc
				personShow.Email = m[index].Email
				personShow.Address = m[index].Address
				personShow.PhoneNumber = m[index].PhoneNumber
				personShow.PhoneNumber = m[index].PhoneNumber
				personShow.UserType = m[index].UserType
				persons = append(persons, personShow)
			}
		}
		json.NewEncoder(w).Encode(persons)
	} else {
		fmt.Fprintf(w, "Access Denied")
	}
}

func getAllPatients(w http.ResponseWriter, r *http.Request) {
	var user User
	reqBody, error := ioutil.ReadAll(r.Body)
	fmt.Println(error)
	json.Unmarshal(reqBody, &user)
	if m[user.Uid].UserType == "donor" {
		var persons []PersonShow
		for index := range m {
			if m[index].UserType == "patient" {
				var personShow PersonShow
				personShow.Id = m[index].Id
				personShow.Name = m[index].Name
				personShow.Desc = m[index].Desc
				personShow.Email = m[index].Email
				personShow.Address = m[index].Address
				personShow.PhoneNumber = m[index].PhoneNumber
				personShow.PhoneNumber = m[index].PhoneNumber
				personShow.UserType = m[index].UserType
				persons = append(persons, personShow)
			}
		}
		json.NewEncoder(w).Encode(persons)
	} else {
		fmt.Fprintf(w, "Access Denied")
	}
}
func sendRequests(w http.ResponseWriter, r *http.Request) {
	check := false
	var request UserRequest
	reqBody, error := ioutil.ReadAll(r.Body)
	fmt.Println(error)
	json.Unmarshal(reqBody, &request)

	for index := range m {
		if m[index].Id == request.RequestedId {
			if m[index].UserType != m[request.Uid].UserType {
				m[index].PendingUid[m[request.Uid].Id] = true
				m[request.Uid].RequestedUid[m[index].Id] = true
				fmt.Fprintf(w, "Request sent successfully")
				check = true
			} else {
				fmt.Fprintf(w, "User & the Requested user are of same type")
			}
		}
	}
	if check == false {
		fmt.Fprintf(w, "Request unsuccessfull")
	}
}
func acceptRequests(w http.ResponseWriter, r *http.Request) {
	var request UserRequest
	reqBody, error := ioutil.ReadAll(r.Body)
	fmt.Println(error)
	json.Unmarshal(reqBody, &request)
	for index := range m {
		if m[index].Id == request.RequestedId {
			m[index].ConnectedUid[m[request.Uid].Id] = true
			m[request.Uid].ConnectedUid[request.RequestedId] = true

			delete(m[index].RequestedUid, m[request.Uid].Id)
			delete(m[request.Uid].PendingUid, m[index].Id)

			fmt.Fprintf(w, "Request accepted successfully")
		}
	}
}
func cancelConnect(w http.ResponseWriter, r *http.Request) {
	var request UserRequest
	reqBody, error := ioutil.ReadAll(r.Body)
	fmt.Println(error)
	json.Unmarshal(reqBody, &request)
	for index := range m {
		if m[index].Id == request.RequestedId {

			delete(m[index].ConnectedUid, m[request.Uid].Id)
			delete(m[request.Uid].ConnectedUid, m[index].Id)

			fmt.Fprintf(w, "Connection removed Successfully")
		}
	}
}

func cancelRequests(w http.ResponseWriter, r *http.Request) {
	check := false
	var request UserRequest
	reqBody, error := ioutil.ReadAll(r.Body)
	fmt.Println(error)
	json.Unmarshal(reqBody, &request)

	for index := range m {
		if m[index].Id == request.RequestedId {
			delete(m[index].PendingUid, m[request.Uid].Id)
			delete(m[request.Uid].RequestedUid, m[index].Id)
			fmt.Fprintf(w, "Request cancelled!")
			check = true
		}
	}
	if check == false {
		fmt.Fprintf(w, "Request Cancelation unsuccessfull")
	}
}

func main() {
	count = 0
	m = make(map[string]Person)
	fmt.Println("Api")
	http.HandleFunc("/login", loginUser)
	http.HandleFunc("/createuser", createUser)
	http.HandleFunc("/deleteuser", deleteUser)
	http.HandleFunc("/upadteuserdata", updateUserData)
	http.HandleFunc("/getuser", getUserDataById)
	http.HandleFunc("/getalldonors", getAllDonors)
	http.HandleFunc("/getallpatients", getAllPatients)
	http.HandleFunc("/sendrequest", sendRequests)
	http.HandleFunc("/acceptrequest", acceptRequests)
	http.HandleFunc("/cancelconnect", cancelConnect)
	http.HandleFunc("/cancelrequest", cancelRequests)
	err := http.ListenAndServe(":9000", nil)
	if err == nil {
		log.Fatal("Listen And Server error", err)
	}
}

// {
//     "name":"Abhinav Gupta",
//     "phone":"6388404245",
//     "address":"Moh.kajamkhan kaimganj",
//     "type":"donor",
//     "email":"abhinav@gmail.com"
// }
