//
//  RealmThreadWithRunLoopScheduler.swift
//  TasCarDB
//
//  Created by Enrique Republic on 08/08/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit
import RxSwift

final class RealmThreadWithRunLoop: Thread {
    
    var runLoop: RunLoop!
    
    override func main() {
        runLoop = RunLoop.current
        runLoop.add(Port(), forMode: .common)
        runLoop.run()
    }
    
}

final class RealmThreadWithRunLoopScheduler: ImmediateSchedulerType {
    
    private let thread: RealmThreadWithRunLoop
    
    init(name: String) {
        thread = RealmThreadWithRunLoop()
        thread.name = name
        thread.start()
    }
    
    func schedule<StateType>(_ state: StateType, action: @escaping (StateType) -> Disposable) -> Disposable {
        let disposable = SingleAssignmentDisposable()
        thread.runLoop.perform {
            disposable.setDisposable(action(state))
        }
        return disposable
    }
    
}
