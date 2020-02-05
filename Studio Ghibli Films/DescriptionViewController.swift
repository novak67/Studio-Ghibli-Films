//
//  ViewController.swift
//  Studio Ghibli Films
//
//  Created by ryan bachrach on 2/5/20.
//  Copyright © 2020 Novak Software Development. All rights reserved.
//

import UIKit

class DescriptionViewController: UITableViewController {
    
    var description1 = [[String: String]]()
    var film = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Film Details"
        let query = "https://ghibliapi.herokuapp.com/films"
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            if let url = URL(string: query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                    self.parse(json: json)
                    return
                }
            }
            self.loadError()
        }
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
            description1.append(film)
        }
        DispatchQueue.main.async {
            [unowned self] in
            self.tableView.reloadData()
        }
    }
    func loadError() {
        DispatchQueue.main.async {
            [unowned self] in
            let alert = UIAlertController(title: "Loading Error",
                                          message: "There was a problem loading the details",
                                          preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
