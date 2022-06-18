```swift
import Foundation
import RxSwift

var disposeBag = DisposeBag()

protocol Player {
    var point: BehaviorSubject<Int> { get }
}

print("----ignoreElements----")
Observable.of("A", "B", "C")
    .toArray() // -> Single
    .subscribe(onSuccess: {
        print($0)
    })
    .disposed(by: disposeBag)


print("----map----")
Observable.of(Date())
    .map { date -> String in
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
    

print("----flatMap----")
struct FootballPlayer: Player {
    var point: BehaviorSubject<Int>
}

let koreanPlayer = FootballPlayer(point: BehaviorSubject<Int>(value: 10))
let usaPlayer = FootballPlayer(point: BehaviorSubject<Int>(value: 8))

let olympicGame = PublishSubject<Player>()

olympicGame
    .flatMap { player in
        player.point
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

olympicGame.onNext(koreanPlayer)
koreanPlayer.point.onNext(10)

olympicGame.onNext(usaPlayer)
koreanPlayer.point.onNext(10)
usaPlayer.point.onNext(9)


print("----flatMapLatest----")
struct BaseballPlayer: Player {
    var point: BehaviorSubject<Int>
}

let seoul = BaseballPlayer(point: BehaviorSubject<Int>(value: 7))
let jeju = BaseballPlayer(point: BehaviorSubject<Int>(value: 6))

let korea = PublishSubject<Player>()

korea
    .flatMapLatest { player in
        player.point
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

korea.onNext(seoul)
seoul.point.onNext(9)

korea.onNext(jeju)
seoul.point.onNext(10)
jeju.point.onNext(3)


print("----materialize and dematerialize----")
enum Faul: Error {
    case handball
}

struct Runner: Player {
    var point: BehaviorSubject<Int>
}

let rabbit = Runner(point: BehaviorSubject<Int>(value: 0))
let dog = Runner(point: BehaviorSubject<Int>(value: 1))

let runningGame = BehaviorSubject<Player>(value: rabbit)

runningGame
    .flatMapLatest {
        $0.point
            .materialize()
    }
    .filter {
        guard let error = $0.error else {
            return true
        }
        print(error)
        return false
    }
    .dematerialize()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

rabbit.point.onNext(1)
rabbit.point.onError(Faul.handball)
rabbit.point.onNext(2)

runningGame.onNext(dog)
```
