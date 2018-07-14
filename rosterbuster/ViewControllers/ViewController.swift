//
//  ViewController.swift
//  rosterbuster
//
//  Created by Saurabh Gupta on 08/07/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIService.standard.getRosters { (rosters, error) in
            print(rosters)
        }
    }

}

