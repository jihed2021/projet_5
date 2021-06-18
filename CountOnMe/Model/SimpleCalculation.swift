//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by Jihed Agrebaoui on 01/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation


enum OperationType {
    case addition, substraction, multiplication, division
}
enum CalculationError: Error , LocalizedError {
    case divisionByZero
    public var errorDescription: String? {
        switch self {
        case .divisionByZero:
            return "impossible calcultation"
        }
    }
}
protocol SimpleCalculationDelegate {
    func didResult(operation: String)
    func alertOperator()
    func alertExpression()
    func didbeginOperation()
}

class SimpleCalculation {
    
    var delegate: SimpleCalculationDelegate?
    
    var operationType: OperationType!
    var text: String = " "
    {
        didSet {
            delegate?.didResult(operation: text)
        }
    }
    var result: Float!
    var elements: [String]! {
        return text.split(separator: " ").map { "\($0)" }
    }
    private var expressionIsCorrect: Bool {
        return elements?.last != "+" && elements?.last != "-" && elements?.last != "*" && elements?.last != "/"
    }
    private var expressionHaveEnoughElement: Bool {
        return elements?.count ?? 0 >= 3
    }
    private var canAddOperator: Bool {
        return elements?.last != "+" && elements?.last != "-" && elements?.last != "*" && elements?.last != "/"
    }
    private var expressionHaveResult: Bool {
        return text.firstIndex(of: "=") != nil
    }
    var expressionHaveManyOperator: Bool{
        return elements.count > 3
    }
   
    func calcultation(_ firstNumber: Float, _ secondNumber: Float,_ operand: String) throws -> Float {
     
       
        switch operand {
        case "+":
            operationType = .addition
            result = firstNumber + secondNumber
            return result
        case "-":
            operationType = .substraction
            result = firstNumber - secondNumber
            return result
        case "x":
            operationType = .multiplication
            result = firstNumber * secondNumber
            return result
        case "/":
            operationType = .division
            if secondNumber != 0 {
                result = firstNumber / secondNumber
                return result
            } else {
                
                throw CalculationError.divisionByZero
            }
        default:
            break
          }
        
        return 0.0
        }
    func add(number: String) {
        if expressionHaveResult {
            text = ""
        }
        text.append(number)
        }
        
    func add(operatorForCalculation: String) {
        if expressionHaveResult {
            guard let lastElement = elements.last else { return }
            text = lastElement
        }
        if canAddOperator {
            text.append(" \(operatorForCalculation) ")
        } else {
            delegate?.alertOperator()
        }
    }
    
    func addresult() {
        if expressionIsCorrect && expressionHaveEnoughElement {
            var operationsToReduce = elements!
    
            while operationsToReduce.count > 1 {
                if let index = operationsToReduce.firstIndex(where : { $0 == "x" || $0 == "/" }) {
                    let leftValue = Float(operationsToReduce[index - 1])!
                    let operand = operationsToReduce[index]
                    let rightValue = Float(operationsToReduce[index + 1])!
                    let result = try? calcultation(leftValue, rightValue, operand)
                    operationsToReduce[index] = String(result!)
                    operationsToReduce.remove(at: index + 1)
                    operationsToReduce.remove(at: index - 1)
                } else {
                let firstNumber = Float(operationsToReduce[0])
                let secondNumber = Float(operationsToReduce[2])
                let operand = operationsToReduce[1]
                let result = try? calcultation(firstNumber!, secondNumber! , operand)
                
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                operationsToReduce.insert(String(result!), at: 0)
                }
            }
            text = text + " = \(operationsToReduce.first ?? "")"
                        delegate?.didResult(operation: text)
            
        } else  {
            delegate?.alertExpression()
        }
    }
    func resetAll() {
        text.removeAll()
    }
}

