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

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchUsers()
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
        viewModel.users?.subscribe(onNext: { users in
            self.userList.accept(users)
        }, onError: { error in
            // TODO: show error alert
        }).disposed(by: disposeBag)
        
        userList.bind(to: tableView.rx.items(cellIdentifier: "CellCustom", cellType: UserTableViewCell.self)) { row, model, cell in
            cell.configureCell(user: model)
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe { indexPath in
            self.tableView.deselectRow(at: indexPath, animated: true)
            // TODO: Go to Detail Controllers
        }
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Contatos"
        navigationController?.navigationBar.sizeToFit()
    }


}



