//
//  WebViewController.swift
//  RSSReader
//
//  Created by chikushi on 2020/04/15.
//  Copyright © 2020 co.jp.vivinet. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    
    // URL
    var targetUri:String!
    
    /// 画面表示後の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        // ページ読込
        let myURL = URL(string: targetUri)
        let myRequest = URLRequest(url: myURL!)
        webview.load(myRequest)
        
        // SwipeBack処理設定
        setSwipeBack()
    }
    

    @IBAction func buttonReturnTapped(_ sender: Any) {
        // self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
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
