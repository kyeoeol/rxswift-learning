## DisposeBag이 담긴 UIViewController를 어떻게 처리할까??

### 1. BaseViewController
```swift
class BaseViewController: UIViewController {
    var disposeBag = DisposeBag()
}
```

### 2. typealias를 이용해 UIViewController 덮어쓰기
```swift
typealias UIViewController = _UIViewControllerWithDisposeBag

class _UIViewControllerWithDisposeBag: UIKit.UIViewController {
    var disposeBag = DisposeBag()
}
```
- 기존의 UIViewController는 UIKit 네임스페이스를 가진다.
- 타입 이름이 같다면 같은 모듈의 클래스가 더 높은 스코프 우선순위를 가지게 된다.
- 즉, 프로젝트에 또다른 UIViewController를 정의하면 모든 UIViewController 대한 참조가
- UIKit.UIViewController 에서 MyApp.UIViewController 바뀌게 됩니다.
- **<a href="https://www.theteams.kr/teams/866/post/73233">참고</a>**
