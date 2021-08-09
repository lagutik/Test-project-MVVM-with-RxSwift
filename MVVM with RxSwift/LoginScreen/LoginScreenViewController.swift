//
//  LoginScreenViewController.swift
//  MVVM with RxSwift
//
//  Created by admin on 30.07.2021.
//

import UIKit
import RxSwift
import RxCocoa

class LoginScreenViewController: UIViewController {
    private lazy var login = makeTextField(placeholder: "Логин")
    private lazy var password = makeTextField(placeholder: "Пароль")
    private lazy var buttonNext = makeButton(text: "Далее")
    private lazy var messageLabelForLogin = makeLabel()
    private lazy var messageLabelForPassword = makeLabel()
    private var viewModel: LoginScreenViewModelProtocol
    private var disposeBag = DisposeBag()
    private var router: LoginScreenRouter
    
    init(viewModel: LoginScreenViewModelProtocol){
        self.viewModel = viewModel
        router = LoginScreenRouter()
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
        
        login.delegate = self
        login.tag = 0
        password.delegate = self
        password.tag = 1
    }
    
    func configureRx() {
        login.rx.text
            .skip(2)
            .subscribe(onNext: { [weak self] text in
                guard let self = self, let text = text else { return }
                self.validation(for: .login, text: text)
            }).disposed(by: disposeBag)
        
        password.rx.text
            .skip(2)
            .subscribe(onNext: { [weak self] text in
                guard let self = self, let text = text else { return }
                self.validation(for: .password, text: text)
            }).disposed(by: disposeBag)
        
        buttonNext.rx
            .tap.subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.viewModel.validateAll()
            }).disposed(by: disposeBag)
        
        viewModel.buttonActivityEvent.drive { [weak self] (state) in
            guard let self = self else { return }
            if state {
                self.router.presentVC(viewController: self, vcToPresent: RequestScreenViewController(viewModel: RequestScreenViewModel(model: RequestScreenModel())))
            }
        }.disposed(by: disposeBag)
    }
}

private extension LoginScreenViewController {
    func makeTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
        textField.layer.borderWidth = 0.2
        return textField
    }
    
    func makeButton(text: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, for: .normal)
        return button
    }
    
    func makeLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

private extension LoginScreenViewController {
    func prepareUI() {
        view.addSubview(login)
        view.addSubview(messageLabelForLogin)
        view.addSubview(password)
        view.addSubview(messageLabelForPassword)
        view.addSubview(buttonNext)
        
        NSLayoutConstraint.activate(
            [login.widthAnchor.constraint(equalToConstant: 300),
             login.heightAnchor.constraint(equalToConstant: 35),
             login.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
             login.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        NSLayoutConstraint.activate(
            [messageLabelForLogin.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 5),
             messageLabelForLogin.widthAnchor.constraint(equalTo: login.widthAnchor),
             messageLabelForLogin.heightAnchor.constraint(equalToConstant: 30),
             messageLabelForLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        NSLayoutConstraint.activate(
            [password.widthAnchor.constraint(equalTo: login.widthAnchor),
             password.heightAnchor.constraint(equalTo: login.heightAnchor),
             password.topAnchor.constraint(equalTo: messageLabelForLogin.bottomAnchor, constant: 10),
             password.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        NSLayoutConstraint.activate(
            [messageLabelForPassword.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 5),
             messageLabelForPassword.widthAnchor.constraint(equalTo: login.widthAnchor),
             messageLabelForPassword.heightAnchor.constraint(equalTo:  messageLabelForLogin.heightAnchor),
             messageLabelForPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        NSLayoutConstraint.activate(
            [buttonNext.topAnchor.constraint(equalTo: messageLabelForPassword.bottomAnchor, constant: 50),
             buttonNext.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             buttonNext.heightAnchor.constraint(equalToConstant: 40),
             buttonNext.widthAnchor.constraint(equalToConstant: 150)])
    }
}

extension LoginScreenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newText = text.appending(string)
        
        if textField.tag == 0 {
            return(viewModel.checkValidation(text: newText, type: .login))
        } else {
            return(viewModel.checkValidation(text: newText, type: .password))
        }
    }
}

private extension LoginScreenViewController {
    func validation(for type: RowType, text: String) {
        self.viewModel.updateText(for: type, text: text)
        let informationForMessageLabel =  self.viewModel.updateMessageLabel(type: type)
        
        switch type {
        case .login:
            self.messageLabelForLogin.text = informationForMessageLabel
        case .password:
            self.messageLabelForPassword.text = informationForMessageLabel
        }
    }
}
