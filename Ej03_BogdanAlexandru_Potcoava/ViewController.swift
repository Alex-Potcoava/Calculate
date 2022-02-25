//
//  ViewController.swift
//  Ej03_BogdanAlexandru_Potcoava
//
//  Created by Alexandru Bogdan Potcoava on 5/2/22.
//

import UIKit

class ViewController: UIViewController {
    
    //Creación de los Outlet
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var result2: UILabel!
    @IBOutlet weak var barProgress: UIProgressView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultCell: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenTrue()
        
        //Solicitar los permisos para poder usar las notificaciónes
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, ErrorCode in
            if granted {
                print("Tenemos el permiso")
            }else{
                print(ErrorCode.debugDescription)
            }
        }
        
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        
        var array = [Int]()
        var count: Int = 0
        
        if let num = Int(number.text!){
            
            if(num > 0){
                self.barProgress.setProgress(0.0, animated: false)
                hiddenFalse()
                
                DispatchQueue.global().async {
                    //Recorremos todos los numeros desde el 1 hasta el numero intoducido
                    for i in (1...num){
                        //Dentro del if solo entraran los numeros que hemos recorrido que sean divisibles entre el numero introducido que su división de resto 0
                        if (num % i == 0) {
                            //Rellenamos el array con dichos numeros
                            array.append(i)
                            //Aumentamos el contador cada vez que entramos un divisor
                            count += 1
                            DispatchQueue.main.async {
                                
                                //Creamos otro array para convertir sus numeros en text y para realizar un salto de linea por cada componente del array
                                var arrayText: String = ""
                                array.forEach(){
                                    n in arrayText.append("\(n) \n")
                                }
                                
                                self.barProgress.setProgress(1 / Float(num / i), animated: true)
                                self.percent.text = "\((i*100)/num)%"
                                self.result.text = "\(count)"
                                self.result2.text = "\(arrayText)"
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.activityIndicator.isHidden = true
                        self.showNotification(text: "Calculo realizado.", text2: "El numero \(num) tiene \(count) divisores")
                    }
                }
            }else{
                result.text = "Introduce un numero mayor a 0"
            }
        }else{
            result.text = "Valor introducido no valido"
        }
    }
    
    //Creamos notifiación
    func showNotification(text: String, text2: String){
        //Crear content
        let content = UNMutableNotificationContent()
        content.title = text
        content.subtitle = text2
        content.sound = .default
        //Creamos Trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        //Creamos la request y añadir el content y el trigger
        let request = UNNotificationRequest(identifier: "Mi identificación", content: content, trigger: trigger)
        //Añado la notificación al centro de notificaciónes
        UNUserNotificationCenter.current().add(request){
            (error) in print(error.debugDescription)
        }
    }
    
    //Ocultar barras de progreso
    func hiddenTrue(){
        self.barProgress.isHidden = true
        self.activityIndicator.isHidden = true
    }
    //Hacer aparecer las barras de progreso
    func hiddenFalse(){
        self.barProgress.isHidden = false
        self.activityIndicator.isHidden = false
    }
}

