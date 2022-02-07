//
//  ViewController.swift
//  RxRadioButton
//
//  Created by haanwave on 2022/02/08.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private var disposeBag = DisposeBag()
    
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var disagreeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }
    private func bind() {
        let isAgreeOb = BehaviorSubject<Bool>(value: false)

        isAgreeOb
            .subscribe(onNext: { isAgree in
                self.isAgree(isAgree)
            })
            .disposed(by: disposeBag)
        
        agreeButton.rx.controlEvent(.touchUpInside)
            .map { true }
            .bind(to: isAgreeOb)
            .disposed(by: disposeBag)
        
        disagreeButton.rx.controlEvent(.touchUpInside)
            .map { false }
            .bind(to: isAgreeOb)
            .disposed(by: disposeBag)
    }
    
    deinit {
        disposeBag = DisposeBag()
    }
}

// MARK: - Helper
private extension ViewController {
    func initButtonStyle() {
        [agreeButton, disagreeButton].forEach {
            $0?.backgroundColor = .white
            $0?.setTitleColor(.lightGray, for: [])
            $0?.layer.borderColor = UIColor.lightGray.cgColor
            $0?.layer.borderWidth = 0.5
            $0?.layer.cornerRadius = 5.0
            $0?.layer.masksToBounds = true
        }
    }
    
    func isAgree(_ isAgree: Bool) {
        initButtonStyle()
        if isAgree {
            agreeButton.backgroundColor = .systemBlue
            agreeButton.setTitleColor(.white, for: [])
            agreeButton.layer.borderColor = UIColor.systemBlue.cgColor
        }
        else {
            disagreeButton.backgroundColor = .systemBlue
            disagreeButton.setTitleColor(.white, for: [])
            disagreeButton.layer.borderColor = UIColor.systemBlue.cgColor
        }
    }
}

// MARK: - Configure
private extension ViewController {
    func configureView() {
        initButtonStyle()
    }
}
