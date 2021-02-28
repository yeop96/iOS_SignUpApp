//
//  SignUpViewController.swift
//  SignUp
//
//  Created by yeop on 2021/02/26.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
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
    
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        
        return picker
    }()
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage:UIImage =  info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    self.imageView.image = originalImage
                }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpSelectImageButton(_ sender: UIButton){
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func signUpButtonTouch(_ sender: Any) {
        if (idField.text == "" || pwField.text == ""){
            showToast(message: "공백을 채워주세요.")
            return
        }
        else if(pwField.text != pwCheckField.text){
            showToast(message: "비밀번호 확인이 다릅니다.")
            return
        }
        else if(!isValidEmail(testStr: idField.text!)){
            showToast(message: "이메일 형식이 맞지 않습니다.")
            return
        }
        else if(!isValidPassword(testStr: pwCheckField.text!)){
            showToast(message: "비밀번호는 6자리 이상입니다.")
            return
        }
        
        Auth.auth().createUser(withEmail: idField.text!, password: pwCheckField.text!
                ) { (user, error) in
                    if user !=  nil{
                        self.showToast(message: "가입성공했습니다.")
                        self.dismiss(animated: true, completion: nil)
                    }
                    else{
                        self.showToast(message: "가입실패했습니다")
                    }
                }
        
    }
    
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker){
        let date: Date = self.datePicker.date
        let dateString: String = self.dateFormatter.string(from: date)
        
        self.dateLabel.text = dateString
    }
    
    @IBAction func backButtonTouch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
    
    func isValidEmail(testStr:String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailTest.evaluate(with: testStr)
        }
    
    func isValidPassword(testStr:String) -> Bool {
           let pwRegEx = "^.{6}$"
           let pwTest = NSPredicate(format:"SELF MATCHES %@", pwRegEx)
           return pwTest.evaluate(with: testStr)
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
