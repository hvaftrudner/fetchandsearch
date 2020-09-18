//
//  DetailViewController.swift
//  project 7
//
//  Created by Kristoffer Eriksson on 2020-09-17.
//  Copyright © 2020 Kristoffer Eriksson. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var detailItem : Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let detailItem = detailItem else {return}
        
        let html = """
            <html>
            <head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <style> body { font-size: 150% ; } </style>
            </head>
            <body>
            \(detailItem.body)
            </body>
            </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)

}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
