//
//  SimpleCalculationDelegate.swift
//  CountOnMe
//
//  Created by Jihed Agrebaoui on 05/07/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation
protocol SimpleCalculationDelegate {
    func didResult(operation: String)
    func alert(error: CalculationError)
}
