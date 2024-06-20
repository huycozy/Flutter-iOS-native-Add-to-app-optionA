//
//  ViewController.swift
//  reproduce_issue_ios_native_addtoapp_optionA
//
//  Created by HuyNQ on 23/03/2023.
//

import UIKit
import Flutter

class ViewController: UIViewController {

    @IBOutlet var counterLabel: UILabel!
    var methodChannel : FlutterMethodChannel?
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        if let flutterEngine = (UIApplication.shared.delegate as? AppDelegate)?.flutterEngine {
            methodChannel = FlutterMethodChannel(name: "dev.flutter.example/counter",
                                                 binaryMessenger: flutterEngine.binaryMessenger)
            methodChannel?.setMethodCallHandler({ [weak self]
                (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                if let strongSelf = self {
                    switch(call.method) {
                    case "incrementCounter":
                        strongSelf.count += 1
                        strongSelf.counterLabel.text = "Current counter: \(strongSelf.count)"
                        strongSelf.reportCounter()
                    case "requestCounter":
                        strongSelf.reportCounter()
                    default:
                        // Unrecognized method name
                        print("Unrecognized method name: \(call.method)")
                    }
                }
            })
        }
    }

    func reportCounter() {
        methodChannel?.invokeMethod("reportCounter", arguments: count)
    }

    @IBAction func openFlutterButtonClick(_ sender: Any) {
        if let flutterEngine = (UIApplication.shared.delegate as? AppDelegate)?.flutterEngine {
            let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
//            self.present(flutterViewController, animated: false, completion: nil)
            self.navigationController?.pushViewController(flutterViewController, animated: true)
            print("done")
        }
    }
}

