//
//  ListViewViewModel.swift
//  MVVM-RxSwift
//
//  Created by MacBook Pro on 10.08.2020.
//  Copyright © 2020 Sezer Altun. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

class ListViewViewModel{
    private let disposeBag=DisposeBag()
    private let _users = BehaviorRelay<[UserModel]>(value: [])
    private let _error = BehaviorRelay<String?>(value: nil)
    init() {
        getUsers()
    }
    var users: Driver<[UserModel]>{
        return _users.asDriver()
    }
    var error:Driver<String?>{
        _error.asDriver()
    }
    var hasError: Bool{
        return _error.value != nil
    }
    
    var numberOfMovies: Int {
        return _users.value.count
    }
    func viewModelForUser(at index: Int) -> UserViewViewModel? {
        guard index < _users.value.count else {
            return nil
        }
        return UserViewViewModel(model: _users.value[index])
    }
    func getUsers(){
        
        UserRepo().getUsers { result in
            switch result {
            case .success(let data):
                self._users.accept(data)
             case .failure(let error):
                self._error.accept(error.localizedDescription)
                print(error.localizedDescription)
            }
        }
        
    }
}

