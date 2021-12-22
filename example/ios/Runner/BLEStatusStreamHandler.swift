//
//  BLEStatusStreamHandler.swift
//  Runner
//
//  Created by Steven Smith on 12/20/21.
//

import Foundation
import Flutter
import CoreBluetooth

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

final class BLEStateOperation: AsyncOperation, CBPeripheralManagerDelegate {
    
    private let operationCompletion: BLEOperationCompletion
    var bluetoothPeripheralManager: CBPeripheralManager?
    
    init(completion: BLEOperationCompletion) {
        self.operationCompletion = completion
        super.init()
        let options = [CBCentralManagerOptionShowPowerAlertKey:0] //<-this is the magic bit!
        bluetoothPeripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: options)
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
        var state: String = ""
        switch peripheral.state {
        case .poweredOn:
            state = "poweredOn"
        case .poweredOff:
            state = "poweredOff"
        case .unknown:
            state = "unknown"
        case .resetting:
            state = "resetting"
        case .unsupported:
            state = "unsupported"
        case .unauthorized:
            state = "unauthorized"
        @unknown default: break
        }
        (operationCompletion!)(state, nil)
    }
    
}
