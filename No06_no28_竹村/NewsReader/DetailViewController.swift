//
//  DetailViewController.swift
//  NewsReader
//
//  Created by 竹村博徳 on 2020/06/01.
//  Copyright © 2020 竹村博徳. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
 
    
    @IBOutlet weak var webView: WKWebView!
    
    var link:String!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let url = URL(string: self.link){
            
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    
    }
    
    
}
