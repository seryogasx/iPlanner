//
//  ViewController.swift
//  iPlanner
//
//  Created by Сергей Петров on 24.06.2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var LoginTextField: UITextField!
    @IBOutlet weak var SecureTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var EnterWithoutLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func LoginButtonPush(_ sender: Any) {
//        let mainVC = MainScreenViewController()
//        mainVC.modalPresentationStyle = .popover
//        self.present(MainScreenViewController(), animated: true, completion: nil)
//
    }
    
    @IBAction func EnterWithoutLoginButtonPush(_ sender: Any) {
//        let mainVC = MainScreenViewController()
//        mainVC.modalPresentationStyle = .fullScreen
//        self.present(mainVC, animated: true, completion: nil)
//        
    }
}

