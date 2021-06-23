//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Jihed Agrebaoui on 03/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest

@testable import CountOnMe
class CountOnMeTests: XCTestCase {
    var myCalc: SimpleCalculation!
    override func setUp() {
        super.setUp()
        myCalc = SimpleCalculation()
    }
    
    func testCanAddNumber_WhenExpressionHaveresult_ThenResultIsText() {
        myCalc.add(number: "10")
        XCTAssertEqual(myCalc.text,"10")
    }
    func testCanAddOperator_WhenExpressionHaveresult_ThenResultIsText() {
        myCalc.text = "10"
        myCalc.add(operatorForCalculation: "-")
        XCTAssertEqual(myCalc.text,"10 - ")
    }
    
    func testGivenNumbers10to10_Whencalculationtypeaddistion_ThenresultIs20() {
        myCalc.text = "10 + 10"
        myCalc.addresult()
        XCTAssertEqual(myCalc.result, 20.0)
    }
    func testGivenNumbers10to10_WhencalculationtypeDivision_ThenresultIs20() {
        myCalc.text = "10 ÷ 10"
        myCalc.addresult()
        XCTAssertEqual(myCalc.result, 1.0)
    }
    
    func testGivenNumbers10to0_WhencalculationtypeDivision_ThenresultIs20() {
        myCalc.text = "10 ÷ 0"
        do {
            try myCalc.addresult()
        } catch {
            XCTAssertEqual(error.localizedDescription, "impossible calcultation")
        }
    }
    
    func testGivenNumbers10to10_WhencalculationtypeSoustraction_ThenresultIs20() {
        myCalc.text = "10 - 10"
        myCalc.addresult()
        XCTAssertEqual(myCalc.result, 0)
    }
    
    func test_expression_is_Correct() {
        myCalc.text = "10 + "
        XCTAssertFalse(myCalc.expressionIsCorrect)
    }
    
    func test_expression_have_Enought_Element() {
        myCalc.text = "10 + "
        XCTAssertFalse(myCalc.expressionHaveEnoughElement)
    }
    
    func test_can_add_Operator() {
        myCalc.text = "10 + "
        XCTAssertFalse(myCalc.canAddOperator)
    }
    
    func test_expression_have_result() {
        myCalc.text = "10 + "
        XCTAssertFalse(myCalc.expressionHaveResult)
    }
    
    func testError_WhendevisionByZero_ThenresultError() throws {
        
        let expectedError = CalculationError.divisionByZero
        var error: CalculationError?
        myCalc.text = "10 ÷ "
        XCTAssertThrowsError(try myCalc.add(number: "0")) {
            throwError in error = throwError as? CalculationError
        }
        XCTAssertEqual(expectedError, error)
    }
    func testError_WhenAddTwoOperator_ThenresultError() throws {
        
        let expectedError = CalculationError.alertExpression
        var error: CalculationError!
        myCalc.text = "10 + "
        
        XCTAssertThrowsError(try? myCalc.add(operatorForCalculation: "-")) {
            throwError in error = throwError as? CalculationError
        }
        XCTAssertEqual(expectedError, error)
    }
    func test_reset_All() {
        myCalc.text = "10 + 10"
        myCalc.resetAll()
        XCTAssertEqual(myCalc.text, "")
        
    }
    func test_delet_last_Number_in_text () {
        myCalc.text = "10 + 10"
        myCalc.deletelastNumber()
        XCTAssertEqual(myCalc.text, "10 + 1")
    }
}
