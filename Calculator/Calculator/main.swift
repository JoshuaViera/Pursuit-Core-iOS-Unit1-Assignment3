//
//  main.swift
//  Calculator
//
//  Created by Joshua Viera on 10/25/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

func mathStuffFactory(opString: String) -> (Double, Double) -> Double {
    switch opString {
    case "-":
        return {x, y in x - y }
    case "*":
        return {x, y in x * y }
    case "/":
        return {x, y in x / y }
    default:
        return {x, y in x + y }
    }
}

func calculate(){
    // Checking format
    
    print("""
    ===============================================================
    >Calculator
    Enter a number(or decimal), followed by +, -, / or *.
    Example: 2 + 2
    ===============================================================

    -OR-
    ===============================================================
    >Math Guessing Game:
    Replace operator with '?' to generate random operand
    Example: 2 ? 2
    ===============================================================
    """)
    print("")
    
    
    var double1: Double
    var double2: Double
    let response = readLine()?
        .split {$0 == " "}
        .map (String.init)
    if let arrayResponse = response {
        if arrayResponse.count != 3 {
            print("Invalid format!")
            print("")
            calculate()
        }
        if let checkDub1: Double = Double(arrayResponse[0]) {
            double1 = checkDub1
        } else {
            double1 = 0.0
            print("Invalid format")
            print("")
            calculate()
        }
        let opp: String = arrayResponse[1]
        if opp != "+" && opp != "-" && opp != "/" && opp != "*" && opp != "?" {
            print("Invalid operand")
            print("")
            calculate()
        }
        if let checkDub2: Double = Double(arrayResponse[2]) {
            double2 = checkDub2
        } else {
            double2 = 0.0
            print("Invalid format")
            print("")
            calculate()
        }
        if opp == "?" {
            let oppArray = ["+","-","/","*"]
            if let randomOpp = oppArray.randomElement() {
                let mathOpp = mathStuffFactory(opString: randomOpp)
                let result = mathOpp(double1, double2)
                print("""
                    \(double1)  ? \(double2) = \(result)
                    Which operand was used?
                    + , - , / , *
                    """)
                print("")
                var correct = true
                repeat {
                    let response = readLine()
                    if response != randomOpp {
                        print("""
                            Incorrect, Please try again.
                            \(double1) ? \(double2) = \(result)
                            """)
                        print("")
                    } else {
                        print("""
                            Correct!
                            \(double1) \(randomOpp) \(double2) = \(result)
                            """)
                        print("")
                        correct = false
                    }
                } while correct
            }
            
        } else {
            let mathOpp = mathStuffFactory(opString: opp)
            let result = mathOpp(double1, double2)
            print("\(double1) \(opp) \(double2) = \(result)")
        }
    }
    continueOrNa()
}


func difficultMath() {
    print("""
    ===============================================================
    Enter your operation:
    example: reduce 1,2,3,4,5,6,7 by < 1
    ===============================================================

    """)
    print("")
    let bigList: [String] = ["<", ">", "+", "*", "/"]
    var arrayofNums = [Int]()
    var num: Int = 0
    var symbol: String = " "
    let response = readLine()?
        .split{$0 == " "}
        .map(String.init)
    
    
    if let difficultArray = response {
        if difficultArray.count != 5 {
            print("Invalid format.")
            print("")
            difficultMath()
        }
        if difficultArray[0].lowercased() != "filter" && difficultArray[0].lowercased() != "map" && difficultArray[0].lowercased() != "reduce" {
            print("""
                Please make sure you write:
                filter, map or reduce
                """)
            print("")
            difficultMath()
        }
        if !difficultArray[1].contains(",") {
            print("""
                Add commas to your list of numbers please!
                example: 1,2,3,4,5,6
                """)
            print("")
            difficultMath()
        }
        if difficultArray[2].lowercased() != "by" {
            print("You forgot the word 'by' !")
            print("")
            difficultMath()
        }
        if !bigList.contains(difficultArray[3]) {
            print("Invalid operand: <,>,+,*,/")
            print("")
            difficultMath()
        } else {
            symbol = difficultArray[3]
        }
        let stringOfNums: [String] = difficultArray[1].components(separatedBy: ",")
        
        arrayofNums = stringOfNums.compactMap{Int($0)}
        
        if arrayofNums.count < 2 {
            print("""
                Enter more than 1 number seperated by ','
                example: 1,2,3,4,5,6
                """)
            print("")
            difficultMath()
        }
        if let oneInt: Int = Int(difficultArray[4]) {
            num = oneInt
        } else {
            print("Wheres the number after the operand?")
            print("")
            difficultMath()
        }
        switch difficultArray[0] {
        case "filter":
            if symbol != ">" && symbol != "<" {
                print("Greater Than Or Less Than!: > or <")
                print("")
                difficultMath()
            }
            let result = myFilter(array: arrayofNums, string: symbol, num: num)
            print("Result: \(result)")
            
        case "map":
            if symbol != "*" && symbol != "/" {
                print("Multiplication or Division!: * or /")
                print("")
                difficultMath()
            }
            let result = myMap(array: arrayofNums, string: symbol, num: num)
            print("Result: \(result)")
            print("")
        case "reduce":
            if symbol != "+" && symbol != "*" {
                print("Addition Or Multiplication!: + or *")
                print("")
                difficultMath()
            }
            let result = myReduce(array: arrayofNums, string: symbol, num: num)
            print("Result: \(result)")
            print("")
        default :
            print("Fail")
            print("")
            difficultMath()
        }
    }
    continueOrNa()
}


func myFilter(array:[Int], string: String, num: Int) -> [Int] {
    var array = [Int]()
    if string == "<" {
        for i in array {
            if i < num {
                array.append(i)
            }
        }
    } else {
        for i in array {
            if i > num {
                array.append(i)
            }
        }
    }
    return array
}


func myMap(array:[Int], string: String, num: Int) -> [Int] {
    var array = [Int]()
    if string == "*" {
        for i in array {
            array.append(i * num)
        }
    } else {
        for i in array {
            array.append(i + num)
        }
    }
    return array
}


func myReduce(array:[Int], string: String, num: Int) -> [Int] {
    var array = [Int]()
    var total: Int = 0
    if string == "+" {
        for i in array {
            total += i
        }
        total += num
    } else {
        total = 1
        for i in array {
            total *= i
        }
        total *= num
    }
    array.append(total)
    return array
}


func prompt(){
    print("""
        ===============================================================
        Please Pick Your Poison:
        1: Regular Math
        -OR-
        2: Difficult Math?
        (enter: 1 or 2)
        ===============================================================
        """)
    if let response = readLine() {
        switch response.lowercased(){
        case "1", "Regular Math".lowercased():
            calculate()
        case "2", "Difficult Math".lowercased():
            print("Difficult Math:")
            print("")
            difficultMath()
        default:
            print("Invalid reply")
            print("")
            prompt()
        }
    }
}


func continueOrNa() {
    print("""
====================================================================
Continue?
Yes
No
====================================================================
""")
    if let response = readLine() {
        switch response {
        case "Yes".lowercased():
            print("Continue!")
            print("")
            prompt()
        case "No".lowercased():
            print("Game Over!")
            print("")
            exit(0)
        default:
            print("Invalid response")
            print("")
            continueOrNa()
        }
    }
}

prompt()

