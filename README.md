![LastCommit](https://img.shields.io/github/last-commit/haanwave/rxswift-learning?color=3182F6) <br>
![header](https://capsule-render.vercel.app/api?type=waving&color=gradient&height=200&text=Let's%20learn%20RxSwift%20!&fontSize=45&fontColor=ffffff)

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

<br>

## Share
Observable은 Subscribe될 때마다 새로운 Observable을 생성한다. 만약 API 요청에 대한 결과를 Subscribe하는 작업을 여러 가지 하게 된다면, 작업의 개수만큼 Observable이 생성될 것이다. (작업의 개수만큼 API를 호출하게 될 것이다.)

이때, **Share**을 사용한다면 새로운 Observable 시퀀스가 생성되지 않고, 하나의 시퀀스에서 방출되는 아이템을 공유해 사용할 수 있다.

### replay
share(replay:)에서 replay에 입력하는 파라미터는 버퍼의 크기를 의미한다.
다른 시퀀스에서 share()된 Observable을 구독했을 때, 입력된 버퍼의 크기만큼 새로운 시퀀스에 전달한다. <br>
***
cf. <br>
https://jusung.github.io/shareReplay/
