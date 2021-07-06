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
    var mockDelegate: MockCalcultationDelegate {
        return myCalc.calcultationDelegate as! MockCalcultationDelegate
    }
    override func setUp() {
        super.setUp()
        myCalc = SimpleCalculation()
        myCalc.calcultationDelegate = MockCalcultationDelegate()
    }
    
    func testCanAddNumber_WhenExpressionHaveresult_ThenResultIsText() {
        myCalc.add(number: "10")
        
        XCTAssertEqual(mockDelegate.expectedCalculation ,myCalc.text)
    }
    
    func testGivenNumbers10to10_WhencalculationtypeSoustraction_ThenresultIs20() {
        myCalc.text = "10 - 10"
        myCalc.addResult()
        XCTAssertEqual(myCalc.result, 0)
    }
    
    func testCanAddOperator_WhenExpressionHaveresult_ThenResultIsText() {
        myCalc.text = "10 - "
        myCalc.add(operatorForCalculation: "+")
        XCTAssertEqual(mockDelegate.errorCalculation.localizedDescription, "an operator is already set !")
    }
    
    func testGivenNumbers10to10_Whencalculationtypeaddistion_ThenresultIs20() {
        myCalc.text = "10"
        myCalc.add(operatorForCalculation: "+")
        myCalc.add(number: "10")
        myCalc.addResult()
        XCTAssertEqual(mockDelegate.expectedCalculation, "20")
    }
    func testGivenNumbers10to10_WhencalculationtypeDivision_ThenresultIs20() {
        myCalc.text = "10 ÷ 10"
        myCalc.addResult()
        XCTAssertEqual(mockDelegate.expectedCalculation, "1")
    }
    
    func testGivenNumbers10to0_WhencalculationtypeDivision_ThenresultIs20() {
        myCalc.text = "10 ÷ 0"
        myCalc.addResult()
        XCTAssertEqual(mockDelegate.errorCalculation.errorDescription, "impossible calcultation")
    }
    func testGivenNumbers_Whencalculation_ThenresultwithPriorityMultiplication() {
        myCalc.text = "1 + 2 x 3 + 4 x 2"
        myCalc.addResult()
        XCTAssertEqual(mockDelegate.expectedCalculation, "15")
    }
    func testGivenNumbers_Whencalculation_ThenresultwithPriorityDivision() {
        myCalc.text = "1 + 4 ÷ 2 + 4 ÷ 2"
        myCalc.addResult()
        XCTAssertEqual(mockDelegate.expectedCalculation, "5")
        
    }
    
    func testGivenNumbersMixedPriorOperandStartingWithDivision_Whencalculation_ThenresultwithPriority() {
        myCalc.text = "1 ÷ 4 × 4"
        myCalc.addResult()
        XCTAssertEqual(mockDelegate.expectedCalculation, "1")
    }
    
    func testGivenNumbersMixedPriorOperandStartingWithMultiplication_Whencalculation_ThenresultwithPriority() {
        myCalc.text = "1 × 4 ÷ 4"
        myCalc.addResult()
        XCTAssertEqual(mockDelegate.expectedCalculation, "1")
    }
    
    func test_expression_is_Correct() {
        myCalc.text = "10 + "
        XCTAssertFalse(myCalc.expressionIsCorrect)
    }
    
    func test_expression_have_Enought_Element() throws {
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
