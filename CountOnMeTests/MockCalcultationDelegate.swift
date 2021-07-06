//
//  CalcultationDelegate.swift
//  CountOnMeTests
//
//  Created by Jihed Agrebaoui on 05/07/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation
@testable import CountOnMe
class CalcultationDelegate: SimpleCalculationDelegate {
    
    var expectedCalculation: String = "0"
    var errorCalculation: CalculationError = .alertExpression
    
    func alert(error: CalculationError) {
        errorCalculation = error
    }
    func didResult(operation: String) {
        expectedCalculation = operation
    }
    
}
