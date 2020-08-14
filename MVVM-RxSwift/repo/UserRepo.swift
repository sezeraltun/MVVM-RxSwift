//
//  UserRepo.swift
//  MVVM-RxSwift
//
//  Created by MacBook Pro on 10.08.2020.
//  Copyright © 2020 Sezer Altun. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class UserRepo {
    func getUsers(callback:@escaping (AFResult<[UserModel]>)->Void) {
        
        
        let url=ApiClient.apiUrlRoot+"users"
        AF.request(url).responseDecodable { (response: AFDataResponse<[UserModel]>) in
            callback(response.result)
        }
        
    }
}
