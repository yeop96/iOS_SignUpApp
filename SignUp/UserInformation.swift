//
//  UserInformation.swift
//  SignUp
//
//  Created by yeop on 2021/02/25.
//

import Foundation

class UserInformation{
    static let shared: UserInformation = UserInformation()
    
    var id: String?
    var pw: String?
}
