# Rx Radio Button
RxSwift를 활용한 동의/비동의 radio button

<image src="https://user-images.githubusercontent.com/80438047/152819782-1a2960f7-e114-4153-b102-71e101bdca80.gif" width="200">
  
## Outlets
```swift
@IBOutlet weak var agreeButton: UIButton!
@IBOutlet weak var disagreeButton: UIButton!
```
  
## Bind - isAgreeOb
```swift
let isAgreeOb = BehaviorSubject<Bool>(value: false)
  
isAgreeOb
  .subscribe(onNext: { isAgree in
      self.isAgree(isAgree)
  })
  .disposed(by: disposeBag)
```
  
## Bind - agreeButton & disagreeButton
```swift
agreeButton.rx.controlEvent(.touchUpInside)
    .map { true }
    .bind(to: isAgreeOb)
    .disposed(by: disposeBag)
        
disagreeButton.rx.controlEvent(.touchUpInside)
    .map { false }
    .bind(to: isAgreeOb)
    .disposed(by: disposeBag)
```
  
## Helper
```swift
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
```
