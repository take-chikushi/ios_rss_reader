//
//  SplashViewController.swift
//  RSSReader
//
//  Created by chikushi on 2020/04/07.
//  Copyright © 2020 co.jp.vivinet. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         imageView.image = UIImage(named:"splash_image")
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
