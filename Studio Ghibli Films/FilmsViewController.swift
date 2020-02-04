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
        self.title = "Studio Ghibli Films"
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
            films.append(film)
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
                                          message: "There was a problem loading the list",
                                          preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let film = films[indexPath.row]
        cell.textLabel?.text = film["title"]
        cell.detailTextLabel?.text = film["release_date"]
        return cell
    }
}
