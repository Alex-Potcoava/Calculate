//
//  ViewController.swift
//  Ej03_BogdanAlexandru_Potcoava
//
//  Created by Alexandru Bogdan Potcoava on 5/2/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var result2: UILabel!
    @IBOutlet weak var barProgress: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.barProgress.isHidden = true
        self.activityIndicator.isHidden = true
        
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        var array = [Int]()
        var count: Int = 0
        
        self.barProgress.setProgress(0.0, animated: false)
        self.barProgress.isHidden = false
        self.activityIndicator.isHidden = false
        
        if let num = Int(number.text!){
            DispatchQueue.global().async {
                for i in (1...num){
                    if (num % i == 0) {
                        array.append(i)
                        count += 1
                        DispatchQueue.main.async {
                            self.barProgress.setProgress(1 / Float(num / i), animated: true)
                            self.percent.text = "\((i*100)/num)%"
                            self.result.text = "\(count)"
                            self.result2.text = "\(array)"
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                }
            }
            
        }else{
            number.text = "Valor introducido no valido"
        }
    }
    
    
}

