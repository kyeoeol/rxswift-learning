![LastCommit](https://img.shields.io/github/last-commit/haanwave/RxSwift-Example?color=3182F6)
# RxSwift Example or Practice : )

<br>

## CombineLatest
<img src="https://user-images.githubusercontent.com/80438047/151699443-cd6834df-9ae0-4a6f-a8ff-c8ba65553c02.png" width="450">

source가 되는 Observable 중 하나에 의해 item이 방출되면 지정된 함수를 통해 각 Observable이 보낸 최신 item을 결합해 방출한다. <br>
* **Zip 연산자(operator)와의 차이점**
  * Zip은 source가 되는 Observable이 모두 item을 방출할 때 해당 item들을 모두 결합해 방출한다.
  * CombineLatest는 source가 되는 Observable이 item을 방출할 때마다 각 Observable의 최신 item을 결합해 방출한다.

```swift
/// Example
let usernameValid = usernameOutlet.rx.text.orEmpty
    .map { $0.count >= minimalUsernameLength }
    
let passwordValid = passwordOutlet.rx.text.orEmpty
    .map { $0.count >= minimalPasswordLength }

let combineValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 } /// True or False
```
