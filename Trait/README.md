# [RxSwift] Trait
**Trait**은 Observable을 더 안정적이고 의미있게 표현하기 위한 일종의 Syntax Sugar이다.

그 종류로는 **Single, Completable, Maybe** 가 있고 Observable을 조금 더 좁은 범위로 제한하여 제공함으로써 코드를 더 명시적으로 표현할 수 있게 한다.

일반적으로 **Trait**은 **read-only Observable**의 wrapper 형태로 구성되어 있다. Observable에 대한 접근을 제한하고 내부에 존재하는 Observable을 조정해 일부 기능에 특화된 형태로 사용자에게 제공된다.
```swift
struct Single<Element> {
    let source: Observable<Element>
    ....
}
```

<br>

## Single
- `.success(value)` 혹은 `.failure(Error)` 이벤트를 방출한다.
- `.success(value)`는 `.next`와 `.completed`가 합쳐진 형태.
- 데이터 다운로드, 디스크 데이터 로딩 등 **성공 또는 실패로 한 번에 확인할 수 있는 1회성 프로세스**에 적합하다.
- `asSingle()` 메서드를 통해 **Observable을 Single로 변환**시킬 수 있다.

**Example - 생성 및 사용**
```swift
enum DataError: Error {
    case cantParseJSON
}

func getRepo(_ repo: String) -> Single<[String: Any]> {
    return Single<[String: Any]>.create { single in
        let url = URL(string: "https://api.github.com/repos/\(repo)")!
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                return single(.failure(error))
            }
            
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
                  let result = json as? [String: Any] else {
                return single(.failure(DataError.cantParseJSON))
            }

            single(.success(result))
        }
        
        task.resume()
        
        return Disposables.create { task.cancel() }
    }
}
```

**Example - subscribe 활용**
```swift
getRepo("Reactive/RxSwift")
    .subscribe { event in
        switch event {
        case .success(let json):
            print("--->JSON:", json)
        case .failure(let error):
            print("--->ERROR:", error)
        }
    }
    .disposed(by: disposeBag)
```

<br>

## Completable
- `.completed` 또는 `.error(ERROR)` 이벤트를 방출한다.
- 파일 쓰기와 같은 **특정 처리가 완료되었는지만 확인하고 싶을 때 사용**한다.
- Observable이 값을 방출한 이상 Observable을 Completable로 변환시킬 수 없다.

**Example - 생성 및 사용**
```swift
enum CacheError: Error {
    case failedCaching
}

func cacheLocally() -> Completable {
    return Completable.create { completable in
        // 어떤 데이터를 로컬에 저장하기
        ...
        ...
        
        guard success else {
            completable(.error(CacheError.failedCaching))
            return Disposables.create()
        }
        
        completable(.completed)
        return Disposables.create()
    }
}
```

**Example - subscribe 활용**
```swift
cacheLocally()
    .subscribe { completable in
        switch completable {
        case .completed:
            print("--->Completed")
        case .error(let error):
            print("--->ERROR:", error)
        }
    }
    .disposed(by: disposeBag)
```

<br>

## Maybe
- **Single**과 **Completable**이 섞인 버전이다.
- `.success(value)`, `.completed`, `.error(Error)` 이벤트를 모두 방출한다.
- **프로세스가 성공/실패 여부와 함께 특정 값을 방출할 수 있을 때 사용**한다.
- `asMaybe()` 메서드를 통해 **Observable을 Maybe로 변환**시킬 수 있다.

**Example - 생성 및 사용**
```swift
func generateString() -> Maybe<String> {
    return Maybe<String>.create { maybe in
        maybe(.success("RxSwift"))
        
        // or
        
        maybe(.completed)
        
        // or
        
        maybe(.error(someError))
        
        return Disposables.create()
    }
}
```

**Example - subscribe 활용**
```swift
generateString()
    .subscribe { maybe in
        switch maybe {
        case .success(let element):
            print("--->SUCCESS:", element)
        case .completed:
            print("--->COMPLETED")
        case .error(let error):
            print("--->ERROR:", error)
        }
    }
    .disposed(by: disposeBag)
```

<br>
<br>
<br>

***
참고: https://inuplace.tistory.com/1099
