//
//  ViewController.swift
//  Studio Ghibli Films
//
//  Created by ryan bachrach on 2/3/20.
//  Copyright © 2020 Novak Software Development. All rights reserved.
//

import UIKit

class FilmsViewController: UITableViewController {
    
    var sources = [[String: String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ghibli Films"
        let query = "https://ghibliapi.herokuapp.com/films"
        // Do any additional setup after loading the view.
    }


}

