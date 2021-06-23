//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by Jihed Agrebaoui on 01/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation
//    MARK: - Enumeration
enum OperationType {
    case addition, substraction, multiplication, division
}
enum CalculationError: Error , LocalizedError {
    case divisionByZero, alertExpression
    public var errorDescription: String? {
        switch self {
        case .divisionByZero:
            return "impossible calcultation"
        case .alertExpression:
            return "a operator is already set !"
        }
    }
}
//    MARK: - Protcol
protocol SimpleCalculationDelegate {
    func didResult(operation: String)
    func alert(error: CalculationError)
}

class SimpleCalculation {
    //    MARK: - property
    var delegate: SimpleCalculationDelegate?
    
    var operationType: OperationType!
    var text: String = ""
    {
        didSet {
            delegate?.didResult(operation: text)
        }
    }
    var result: Float!
    var elements: [String]! {
        return text.split(separator: " ").map { "\($0)" }
    }
     var expressionIsCorrect: Bool {
        return elements?.last != "+" && elements?.last != "-" && elements?.last != "*" && elements?.last != "÷"
    }
     var expressionHaveEnoughElement: Bool {
        return elements?.count ?? 0 >= 3
    }
     var canAddOperator: Bool {
        return elements?.last != "+" && elements?.last != "-" && elements?.last != "*" && elements?.last != "÷"
    }
     var expressionHaveResult: Bool {
        return text.firstIndex(of: "=") != nil
    }

    //    MARK: - Methods
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
        case "÷":
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
            delegate?.alert(error: .alertExpression)
        }
    }
    
    func addresult() {
        if expressionIsCorrect && expressionHaveEnoughElement {
            var operationsToReduce = elements!
            
            do {
                while operationsToReduce.count > 1 {
                    if let index = operationsToReduce.firstIndex(where : { $0 == "x" || $0 == "÷" }) {
                        let leftValue = Float(operationsToReduce[index - 1])!
                        let operand = operationsToReduce[index]
                        let rightValue = Float(operationsToReduce[index + 1])!
                        let result = try calcultation(leftValue, rightValue, operand)
                        if result.truncatingRemainder(dividingBy: 1) == 0 {
                            operationsToReduce[index] = String(Int(result))
                        } else {
                            operationsToReduce[index] = String(result)
                        }
                        
                        operationsToReduce.remove(at: index + 1)
                        operationsToReduce.remove(at: index - 1)
                    } else {
                        let firstNumber = Float(operationsToReduce[0])
                        let secondNumber = Float(operationsToReduce[2])
                        let operand = operationsToReduce[1]
                        let result = try? calcultation(firstNumber!, secondNumber!, operand)
                        if result!.truncatingRemainder(dividingBy: 1) == 0 {
                            operationsToReduce = Array(operationsToReduce.dropFirst(3))
                            operationsToReduce.insert(String(Int(result!)), at: 0)
                        } else {
                            operationsToReduce = Array(operationsToReduce.dropFirst(3))
                            operationsToReduce.insert(String(result!), at: 0)
                        }
                       
                    }
                }
            } catch  {
                guard let calculationError = error as? CalculationError else {
                    return
                }
                delegate?.alert(error: calculationError)
                deletelastNumber()
                return
            }
            text = text + " = \(operationsToReduce.first ?? "")"
            delegate?.didResult(operation: text)
            
        } else  {
            delegate?.alert(error: .alertExpression)
        }
    }
    func resetAll() {
        text.removeAll()
    }
    func deletelastNumber() {
        let lastText = text.dropLast()
        text = String(lastText)
    }
}

