//
//  ViewController.swift
//  MVVM-RxSwift
//
//  Created by MacBook Pro on 10.08.2020.
//  Copyright © 2020 Sezer Altun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController {

    var viewmodel:ListViewViewModel!
    let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "UserTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "UserTableViewCell")
              
        viewmodel=ListViewViewModel();
        subscribeViewModel()
        
    }


    func subscribeViewModel(){
        
        viewmodel.users.drive(onNext: { (_: [UserModel]) in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewmodel.error.drive(onNext: {(error) in
            if let str = error
            {
                print("error:",str)
            }
            }).disposed(by: disposeBag)
     
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.numberOfMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        if let userViewmodel = viewmodel.viewModelForUser(at: indexPath.row){
            cell.configure(viewModel: userViewmodel)
        }
       return cell
    }
}
