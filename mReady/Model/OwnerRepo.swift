//
//  OwnerRepo.swift
//  mReady
//
//  Created by Denis Feier on 24.04.2021.
//

import Foundation
import SwiftyJSON

class OwnerRepo {
    var login: String
    var avatar_url: String
    
    init(login: String, avatar_url: String) {
        self.login = login
        self.avatar_url = avatar_url
    }
    
    init(json: JSON) {
        self.login = json["login"].stringValue
        self.avatar_url = json["avatar_url"].stringValue
    }
}
