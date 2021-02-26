//
//  ViewController.swift
//  SignUp
//
//  Created by yeop on 2021/02/25.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    
    @IBOutlet weak var datePickerL: UIDatePicker! // preferred style : Automatic 이 아닌 wheels로 변경
    @IBOutlet weak var dateLabel: UILabel!
    
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        
        formatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
        
        //formatter.dateStyle = .medium
        //formatter.timeStyle = .medium
        
        return formatter
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //코드로 타겟 설정 후 액션 연결
        self.datePickerL.addTarget(self, action: #selector(self.didDatePickerValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        // 탭 제스쳐 코드로 타겟 액션 추가
        //let tabGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapView(_:)))
        //self.view.addGestureRecognizer(tabGesture)
        
        
        //print("ViewController view 가 메모리에 로드 됨")
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
    
    @IBAction func touchUpSetButton(_ sender: UIButton){
        UserInformation.shared.id = nameField.text
        UserInformation.shared.pw = ageField.text
    }
    
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker){
        let date: Date = self.datePickerL.date
        let dateString: String = self.dateFormatter.string(from: date)
        
        self.dateLabel.text = dateString
    }
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       // print("ViewController view 가 화면에 보여질 예정")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // print("ViewController view 가 화면에 보여짐")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // print("ViewController view 가 화면에 사라질 예정")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // print("ViewController view 가 화면에 사라짐")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // print("ViewController view 가 subview를 레이아웃 하려함")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // print("ViewController view 가 subview를 레이아웃 함")
    }
    
    
    


}

