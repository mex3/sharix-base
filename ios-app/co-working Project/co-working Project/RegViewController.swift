//
//  RegViewController.swift
//  co-working Project
//
//  Created by Владислав Диянов on 13/06/2019.
//  Copyright © 2019 iOS-Developer. All rights reserved.
//

import UIKit

class RegViewController: UIViewController {
    
    
    @IBOutlet weak var famTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var thirdNameTextField:UITextField!
    @IBOutlet var passTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func RegAction(_ sender: Any) { // функция для кнопки регистрации(
        testEmpty() // привязка функции
    }
    
    func testEmpty() { // функция для проверки пустых полей
        if famTextField.text!.isEmpty { // если в textField фамилии нету текста
            alertDisplay(text: "фамилию")
        }
        if nameTextField.text!.isEmpty{
            alertDisplay(text: "имя")
        }
        if thirdNameTextField.text!.isEmpty{
            alertDisplay(text: "отчество")
        }
        if passTextField.text!.isEmpty{
            alertDisplay(text: "пароль")
        }
        if emailTextField.text!.isEmpty{
            alertDisplay(text: "email или номер")
        }
        if numberTextField.text!.isEmpty{
            alertDisplay(text: "email или номер")
        }
    }
    
    func alertDisplay(text: String) { // функция для окна ошибки
        
        let alert = UIAlertController(title: "Ошибка", message: "Вы не ввели " + text, preferredStyle: .alert) // переменная alert окно ошибки
        let closeAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil) // кнопка ошибки
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil) // для отображения alert
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
