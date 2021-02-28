//
//  MainViewController.swift
//  SignUp
//
//  Created by yeop on 2021/02/26.
//

import UIKit
import Firebase
import FirebaseAuth

class MainViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func loginButtonTouchUp(_ sender: Any) {
        
        if (idTextField.text == "" || pwTextField.text == ""){
            self.showToast(message: "공백을 채워주세요.")
            return
        }
        
        Auth.auth().signIn(withEmail: idTextField.text!, password: pwTextField.text!) { (user, error) in
                    if user != nil{ //login success
                    
                        UserInformation.shared.id = self.idTextField.text! + "님"
                        
                        self.idTextField.text = ""
                        
                        self.pwTextField.text = ""
                    
                        
                        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "userViewStory")
                        self.navigationController?.pushViewController(pushVC!, animated: true)
                        
                    }
                    else{ //login fail
                        self.showToast(message: "없는 회원 입니다.")
                    }
              }
        
    }
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    func showToast(message : String) {
            let width_variable:CGFloat = 10
            let toastLabel = UILabel(frame: CGRect(x: width_variable, y: self.view.frame.size.height-100, width: view.frame.size.width-2*width_variable, height: 35))
            // 뷰가 위치할 위치를 지정해준다. 여기서는 아래로부터 100만큼 떨어져있고, 너비는 양쪽에 10만큼 여백을 가지며, 높이는 35로
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
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
