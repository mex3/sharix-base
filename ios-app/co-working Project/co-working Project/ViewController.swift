//
//  ViewController.swift
//  co-working Project
//
//  Created by Владислав Диянов on 13/06/2019.
//  Copyright © 2019 iOS-Developer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func autAction(_ sender: Any) {
        testEmpty()
    }
    
    func testEmpty() {
        if loginTextField.text!.isEmpty{
            alertDisplay(text: "логин")
        } else
        if passTextField.text!.isEmpty{
            alertDisplay(text: "пароль")
        } else {
            performSegue(withIdentifier: "mainMenuSegue", sender: self)
        }
    }
    
    func alertDisplay(text: String){
        let alert = UIAlertController(title: "Ошибка", message: "Вы не ввели " + text, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
}

