//
//  TodayViewController.swift
//  TodayExtension
//
//  Created by Christian Noon on 5/6/15.
//  Copyright (c) 2015 Alamofire. All rights reserved.
//

import Alamofire
import NotificationCenter
import UIKit

class TodayViewController: UIViewController, NCWidgetProviding {

    let manager: Manager = {
        var defaultHeaders = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
        defaultHeaders["User-Agent"] = "MyUserAgentString"
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = defaultHeaders
        let manager = Manager(configuration: configuration)

        return manager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Float(NSEC_PER_SEC))), dispatch_get_main_queue()) { [weak self] in
            if let strongSelf = self {
                let request = strongSelf.manager.request(.GET, "http://httpbin.org/get", parameters: ["foo": "bar"], encoding: .URL)
                request.responseJSON { request, response, json, error in
                    println(request)
                    println(response)
                    println(json)
                    println(error)
                }

                debugPrintln(request)
            }
        }
    }
}
