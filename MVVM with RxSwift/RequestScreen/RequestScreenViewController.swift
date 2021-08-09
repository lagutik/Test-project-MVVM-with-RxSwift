//
//  RequestScreenViewController.swift
//  MVVM with RxSwift
//
//  Created by admin on 26.07.2021.
//

import UIKit
import RxSwift
import RxCocoa

class RequestScreenViewController: UIViewController {
    private lazy var tableView = makeTableView()
    private lazy var button = makeButton()
    private lazy var indicatorView = makeIndicatorView()
    private var viewModel: RequestScreenViewModelProtocol
    private var router: RequestScreenRouter
    private var disposeBag = DisposeBag()
    
    init(viewModel: RequestScreenViewModelProtocol){
        self.viewModel = viewModel
        router = RequestScreenRouter()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        prepareUI()
        configureRx()
    }
    
    func configureRx() {
        viewModel.isLoadingEvent.drive(onNext: { [weak self] isLoading in
            self?.isShowingLoadingIndicator(isShowing: isLoading)
        }).disposed(by: disposeBag)
        
        viewModel.segueEvent.drive(onNext: { [weak self] segue in
            guard let self = self else { return }
            self.router.perform(segue, viewController: self)
        }).disposed(by: disposeBag)
        
        viewModel.reloadDataEvent.drive(onNext: {[weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        button.rx
            .tap.subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.viewModel.getInformation()
            }).disposed(by: disposeBag)
    }
}

extension RequestScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = viewModel.textForRow(indexPath: indexPath)
        return cell
    }
}

private extension RequestScreenViewController {
    func makeTableView() -> UITableView {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        return tableView
    }
    
    func makeButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Запрос", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func makeIndicatorView() -> UIActivityIndicatorView {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }
}

private extension RequestScreenViewController {
    func prepareUI() {
        view.addSubview(button)
        view.addSubview(tableView)
        view.addSubview(indicatorView)
        
        NSLayoutConstraint.activate(
            [button.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
             button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
             button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             button.heightAnchor.constraint(equalToConstant: 50)])
        
        NSLayoutConstraint.activate(
            [tableView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
             tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        NSLayoutConstraint.activate(
            [indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
}

private extension RequestScreenViewController{
    func isShowingLoadingIndicator(isShowing: Bool) {
        DispatchQueue.main.async {
            isShowing ? self.indicatorView.startAnimating() : self.indicatorView.stopAnimating()
        }
    }
}


