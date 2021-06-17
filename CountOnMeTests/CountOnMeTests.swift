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
    func testGivenNumbers10to10_Whencalculationtypeaddistion_ThenresultIs20() {
        
        myCalc.text = "10 + 10"
        myCalc.addresult()
        
        XCTAssertEqual(myCalc.result, 20.0)
    }
    func testGivenNumbers10to10_WhencalculationtypeDivision_ThenresultIs20() {
        
        myCalc.text = "10 / 10"
        myCalc.addresult()
        
        XCTAssertEqual(myCalc.result, 1)
    }
    func testGivenNumbers10to0_WhencalculationtypeDivision_ThenresultIs20() {
        
        myCalc.text = "10 / 0"
        
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
}
