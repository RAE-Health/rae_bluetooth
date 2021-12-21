//
//  AsyncOperation.swift
//  Runner
//
//  Created by Steven Smith on 10/30/21.
//

import Foundation

public class AsyncOperation: Operation {
  enum State: String {
    case ready, executing, finished

    fileprivate var keyPath: String {
      return "is\(rawValue.capitalized)"
    }
  }

  var state = State.ready {
    willSet {
      willChangeValue(forKey: newValue.keyPath)
      willChangeValue(forKey: state.keyPath)
    }
    didSet {
      didChangeValue(forKey: oldValue.keyPath)
      didChangeValue(forKey: state.keyPath)
    }
  }

  public override var isReady: Bool {
    return super.isReady && state == .ready
  }

  public override var isExecuting: Bool {
    return state == .executing
  }

  public override var isFinished: Bool {
    return state == .finished
  }

  public override var isAsynchronous: Bool {
    return true
  }

  public override func start() {
    main()
    state = .executing
  }
}
