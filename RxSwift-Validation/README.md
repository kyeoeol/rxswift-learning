# Simple Validation

<img src="https://user-images.githubusercontent.com/80438047/151698255-734d48b8-3a9b-4a1f-977b-f211255cb8ef.png" width="300">

<br>

## Observable - usernameValid & passwordValid
username과 password의 글자수 체크
```swift
let usernameValid = usernameInputField.rx.text.orEmpty
    .map { $0.count >= self.minimalUsernameLength }
    .share(replay: 1)

let passwordValid = passwordInputField.rx.text.orEmpty
    .map { $0.count >= self.minimalPasswordLength }
    .share(replay: 1)
```

## Observable - authValidation
usernameValid와 passwordValid를 합친 Observable <br>
이 Observable로 Sign In 버튼 상태를 다룬다.
```swift
let authValidation = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
    .share(replay: 1)
```

## Observable - tap
```swift
signInButton.rx.tap
  .subscribe(onNext: {
      self.showAlert()
  })
  .disposed(by: disposeBag)
```

## Bind
```swift
/// username을 완전히 입력될 때 passwordInputField를 enable or disable 처리
usernameValid
    .bind(to: passwordInputField.rx.isEnabled)
    .disposed(by: disposeBag)

/// usernameValid 상태에 따라 usernameValidLabel을 표시 or 숨김 처리
usernameValid
    .bind(to: usernameValidLabel.rx.isHidden)
    .disposed(by: disposeBag)

/// passwordValid 상태에 따라 passwordValidLabel을 표시 or 숨김 처리
passwordValid
    .bind(to: passwordValidLabel.rx.isHidden)
    .disposed(by: disposeBag)

/// authValidation 상태에 따라 signInButton을 enable or disable 처리
authValidation
    .bind(to: signInButton.rx.isEnabled)
    .disposed(by: disposeBag)
```

## Helper
```swift
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
```

## Configure Views
```swift
usernameValidLabel.text = "5자 이상의 username만 사용 가능합니다."
passwordValidLabel.text = "8자 이상의 password만 사용 가능합니다."

signInButton.setTitleColor(.white, for: .normal)
signInButton.setTitleColor(.lightGray, for: .disabled)
```
