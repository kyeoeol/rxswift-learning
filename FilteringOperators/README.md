```swift
import RxSwift

var disposeBag = DisposeBag()

print("----ignoreElements----")
let sleepMode = PublishSubject<String>()

sleepMode
    .ignoreElements()
    .subscribe { _ in
        print("🌞")
    }
    .disposed(by: disposeBag)

sleepMode.onNext("sleep")
sleepMode.onNext("sleep")
sleepMode.onNext("sleep")


print("----elementAt----")
let twiceAwake = PublishSubject<String>()

twiceAwake
    .element(at: 1)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

twiceAwake.onNext("Bell0")
twiceAwake.onNext("Bell1")
twiceAwake.onNext("Bell2")
twiceAwake.onNext("Bell3")


print("----filter----")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8)
    .filter { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("----skip----")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8)
    .skip(5)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("----skipWhile----")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8)
    .skip(while: {
        $0 != 4
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("----skipUntil----")
let guest = PublishSubject<String>()
let openHour = PublishSubject<String>()

guest
    .skip(until: openHour)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

guest.onNext("guest1")
guest.onNext("guest2")

openHour.onNext("open!")

guest.onNext("guest3")


print("----take----")
Observable.of(1, 2, 3, 4, 5, 6)
    .take(2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("----takeWhile----")
Observable.of(1, 2, 3, 4, 5, 6)
    .take(while: {
        $0 != 4
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("----takeUntil----")
let request = PublishSubject<String>()
let endRequest = PublishSubject<String>()

request
    .take(until: endRequest)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

request.onNext("1")
request.onNext("2")
request.onNext("3")

endRequest.onNext("end")

request.onNext("4")


print("----enumerated----")
Observable.of(1, 2, 3, 4, 5, 6)
    .enumerated()
    .take(while: {
        $0.index < 3
    })
    .subscribe(onNext: {
        print($0.element)
    })
    .disposed(by: disposeBag)


print("----distinctUntilChanged----")
Observable.of(1, 1, 2, 3, 4, 1, 1, 2, 2, 5, 6, 6, 6, 7, 8)
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
```
