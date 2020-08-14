//
//  ResponseModel.swift
//  MVVM-RxSwift
//
//  Created by MacBook Pro on 10.08.2020.
//  Copyright © 2020 Sezer Altun. All rights reserved.
//

import UIKit

struct ResponseModel<T:Decodable>:Decodable {
    var Data=[T]()
}
