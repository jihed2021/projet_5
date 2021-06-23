//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //    MARK: - Property
    var delegate: SimpleCalculationDelegate!
    var mycalculation = SimpleCalculation()
    //    MARK: - Outkets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    // View Life cycles
    override func viewDidLoad() {
        mycalculation.resetAll()
        mycalculation.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //    MARK: - Actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        mycalculation.add(number: numberText)
    }
    
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let myoperator = sender.title(for: .normal) else {
            return
        }
        mycalculation.add(operatorForCalculation: myoperator)
    }
    
    @IBAction func deleteNumber(_ sender: UIButton) {
        mycalculation.deletelastNumber()
    }
    
    @IBAction func resetCalculation(_ sender: UIButton) {
        mycalculation.resetAll()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        mycalculation.addresult()
    }
}
  //    MARK: - Extension
extension ViewController: SimpleCalculationDelegate {
    func alert(error: CalculationError) {
        let alertVC = UIAlertController(title: "‼️", message: error.errorDescription, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func didResult(operation: String) {
        textView.text = operation
    }
}
