//
//  ViewController.swift
//  Project8Codable
//
//  Created by Ana Caroline de Souza on 03/01/20.
//  Copyright © 2020 Ana e Leo Corp. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    var urlString : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showCredit))
        
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                parse(json: data)
                return
            }
        }
        showError()
    }
    
    @objc func showCredit(){
        
        let ac = UIAlertController(title: urlString, message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let searchResult = ac?.textFields?[0].text else { return }
            guard let resultFiltered = self?.petitions.filter({$0.body.contains(searchResult)}) else{return}
            self?.petitions = resultFiltered
            self?.tableView.reloadData()
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func showError(){
        let ac = UIAlertController(title: "problem loading", message: "there was a problem", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac,animated: true)
    }
    
    func parse(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
        
    }
    
    func showAlertToGetText() {
        let ac = UIAlertController(title: "Enter the new list item:", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let searchResult = ac?.textFields?[0].text else { return }
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = petitions[indexPath.row].title
        cell.detailTextLabel?.text = petitions[indexPath.row].body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

