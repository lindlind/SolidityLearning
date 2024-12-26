// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract SimpleStorage {
    int favouriteNumber;

    struct Person {
        uint favouriteNumber;
        string name;
    }

    Person[] public people;
    mapping(string => Person) peopleByName;

    function store(int number) public {
        favouriteNumber = number;
    }

    function retrieve() public view returns (int) {
        return favouriteNumber;
    }

    function sum(int a, int b) public pure returns (int) {
        return a + b;
    }

    function storePerson(string memory name, uint number) public {
        people.push(Person(number, name));
        peopleByName[name] = Person(number, name);
    }

    function getPerson(string memory name) public view returns (Person memory) {
        return peopleByName[name];
    }
}