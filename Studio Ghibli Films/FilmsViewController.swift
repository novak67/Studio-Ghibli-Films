//
//  ViewController.swift
//  Studio Ghibli Films
//
//  Created by ryan bachrach on 2/3/20.
//  Copyright © 2020 Novak Software Development. All rights reserved.
//

import UIKit

class FilmsViewController: UITableViewController {
    
    var films = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ghibli Films"
        let query = "https://ghibliapi.herokuapp.com/films"
        
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                parse(json: json)
                return
            }
        }
        loadError()
    }
    func parse(json: JSON) {
        for result in json[].arrayValue {
            let title = result["title"].stringValue
            let description = result["description"].stringValue
            let director = result["director"].stringValue
            let producer = result["producer"].stringValue
            let release_date = result["release_date"].stringValue
            let rt_score = result["rt_score"].stringValue
            let film = ["title": title, "description": description, "director": director, "producer": producer, "release_date": release_date, "rt_score": rt_score]
            films.append(film)
        }
        tableView.reloadData()
    }
    func loadError() {
        let alert = UIAlertController(title: "Loading Error",
                                      message: "There was a problem loading the list",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil) }
}
