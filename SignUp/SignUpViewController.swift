//
//  SignUpViewController.swift
//  SignUp
//
//  Created by yeop on 2021/02/26.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var idField: UITextField!
    
    @IBOutlet weak var pwField: UITextField!
    
    @IBOutlet weak var pwCheckField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        
        formatter.dateFormat = "yyyy/MM/dd"
        
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.datePicker.addTarget(self, action: #selector(self.didDatePickerValueChanged(_:)), for: UIControl.Event.valueChanged)
    }
    
    @IBAction func signUpButtonTouch(_ sender: Any) {
        
        
    }
    
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker){
        let date: Date = self.datePicker.date
        let dateString: String = self.dateFormatter.string(from: date)
        
        self.dateLabel.text = dateString
    }
    
    @IBAction func backButtonTouch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
