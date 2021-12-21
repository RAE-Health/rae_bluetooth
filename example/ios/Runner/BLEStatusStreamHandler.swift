//
//  BLEStatusStreamHandler.swift
//  Runner
//
//  Created by Steven Smith on 12/20/21.
//

import Foundation
import Flutter

typealias BLEOperationCompletion = ((String?, Error?) -> Void)?

class BLEStatusStreamHandler: NSObject, FlutterStreamHandler {
    private let queue = OperationQueue()
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        queue.addOperation(BLEStateOperation { (data,error) in
            if (data != nil) {
                events(data)
            }
        })
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
}

final class BLEStateOperation: AsyncOperation {
    private let operationCompletion: BLEOperationCompletion
    init(completion: BLEOperationCompletion) {
        self.operationCompletion = completion
        super.init()
    }
    
}
