//
//  ViewController.swift
//  contactsRxSwift
//
//  Created by Pierre Campos Dias on 15/11/23.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    let viewModel = UserViewModel()
    let userList = BehaviorRelay<[User]>(value: [])
    let limit = 20
    var page = 1
    var isUpdating = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchUsers(page, limit)
        configureUI()
        bindUI()
    }
    
    func configureUI() {
        tableView.rowHeight = 100
        
        // Custom Cell
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CellCustom")
    }
    
    func bindUI() {
        viewModel.usersObservable.subscribe(onNext: { users in
            self.userList.accept(users)
            if(users.count > 0) {
                self.page += 1
            }
            self.isUpdating = false
        }, onError: { error in
            self.isUpdating = false
            // TODO: show error alert
        })
        .disposed(by: disposeBag)
        userList.bind(to: tableView.rx.items(cellIdentifier: "CellCustom", cellType: UserTableViewCell.self)) { row, model, cell in
            cell.configureCell(user: model)
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe { indexPath in
            self.tableView.deselectRow(at: indexPath, animated: true)
            // TODO: Go to Detail Controllers
        }
        
        tableView.rx.willDisplayCell.subscribe(onNext: { cell, indexPath in
            let lastIndexSection = self.tableView.numberOfSections - 1
            let lastRowIndex = self.tableView.numberOfRows(inSection: lastIndexSection) - 1
            
            if(!self.isUpdating && indexPath.row >= lastRowIndex) {
//                self.isUpdating = true
                self.viewModel.fetchUsers(self.page, self.limit)
            }
            
        }).disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Contatos"
        navigationController?.navigationBar.sizeToFit()
    }
    
    
}



