//
//  ViewController.swift
//  RxSwift Playground
//
//  Created by kyeoeol on 2022/07/05.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private var disposeBag: DisposeBag = .init()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var deleteButtom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - UI Configure
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        
        
        // MARK: - Bind
        
        let isEditing = textField.rx.isEditing
        let isEmpty = textField.rx.text.orEmpty.map { $0.count > 0 }
       
        // textField 편집모드에 따라 UI 설정
        isEditing
            .bind(to: textField.rx.setEditingUI)
            .disposed(by: disposeBag)
        
        // textField 편집모드가 끝나거나 텍스트가 없을 때 삭제버튼 show or hide
        Observable.of(isEditing, isEmpty)
            .merge()
            .map { !$0 }
            .bind(to: deleteButtom.rx.isHidden)
            .disposed(by: disposeBag)
        
        // 삭제버튼 tap event
        deleteButtom.rx.tap
            .bind {
                self.textField.rx.text.onNext(nil)
                self.deleteButtom.rx.isHidden.onNext(true)
            }
            .disposed(by: disposeBag)
    }
}


// MARK: - Extension

extension Reactive where Base: UITextField {
    var isEditing: Observable<Bool> {
        return Observable.of(
            self.base.rx.controlEvent(.editingDidBegin).map { true },
            self.base.rx.controlEvent([.editingDidEnd, .editingDidEndOnExit]).map { false }
        ).merge()
    }
    
    var setEditingUI: Binder<Bool> {
        return Binder(self.base) { textField, isEditing in
            textField.layer.borderColor = isEditing
                                          ? UIColor.red.cgColor
                                          : UIColor.gray.cgColor
        }
    }
}
