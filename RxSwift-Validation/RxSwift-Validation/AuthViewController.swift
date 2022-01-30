//
//  AuthViewController.swift
//  RxSwift-Validation
//
//  Created by haanwave on 2022/01/30.
//

import UIKit
import RxSwift
import RxCocoa

class AuthViewController: UIViewController {
    private var disposeBag = DisposeBag()
    
    private let minimalUsernameLength = 5
    private let minimalPasswordLength = 8
    
    @IBOutlet weak var usernameInputField: UITextField!
    @IBOutlet weak var usernameValidLabel: UILabel!
    
    @IBOutlet weak var passwordInputField: UITextField!
    @IBOutlet weak var passwordValidLabel: UILabel!
    
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureValidLabel()
        bind()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        disposeBag = DisposeBag()
    }
    
    private func bind() {
        let usernameValid = usernameInputField.rx.text.orEmpty
            .map { $0.count >= self.minimalUsernameLength }
            .share(replay: 1)
        
        let passwordValid = passwordInputField.rx.text.orEmpty
            .map { $0.count >= self.minimalPasswordLength }
            .share(replay: 1)
        
        let authValidation = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: passwordInputField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        authValidation
            .bind(to: signInButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signInButton.rx.tap
            .subscribe(onNext: {
                self.showAlert()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Helper
private extension AuthViewController {
    func showAlert() {
        let alert = UIAlertController(
            title: "Validation",
            message: "SUCCESS",
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(title: "OK", style: .default)
        )
        present(alert, animated: true)
    }
}

// MARK: - Configure
private extension AuthViewController {
    func configureValidLabel() {
        usernameValidLabel.text = "5자 이상의 username만 사용 가능합니다."
        passwordValidLabel.text = "8자 이상의 password만 사용 가능합니다."
        
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.setTitleColor(.lightGray, for: .disabled)
    }
}
