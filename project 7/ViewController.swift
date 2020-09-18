//
//  ViewController.swift
//  project 7
//
//  Created by Kristoffer Eriksson on 2020-09-16.
//  Copyright © 2020 Kristoffer Eriksson. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var searchPetition = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let urlString : String
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredit))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(promptForSearch))
            
        if navigationController?.tabBarItem.tag == 0{
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
            
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                parse(json: data)
                return
            }
        }
        showError()
        
        
    }
    func showError(){
        let ac = UIAlertController(title: "Error", message: "Failed connection", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showCredit(){
        let ac = UIAlertController(title: "Credits", message: "This site contains info from We The People API of the Whitehouse.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ok", style: .default))
        present(ac, animated: true)
    }
    
    @objc func promptForSearch(){
        let ac = UIAlertController(title: "Search", message: "Enter a search term", preferredStyle: .alert)
        ac.addTextField()
        
        //guards against an error
        let searchAction = UIAlertAction(title: "ok", style: .default){
            [weak self, weak ac] action in
            guard let term = ac?.textFields?[0].text else {return}
            self?.search(term)
        }
        ac.addAction(searchAction)
        present(ac, animated: true)
    }
    
    func search(_ term: String){
        
        searchPetition = petitions.filter {
            $0.title.lowercased().contains(term) ||
            $0.body.lowercased().contains(term)
            
        }
        
        tableView.reloadData()
    
    }
    
    func parse(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            searchPetition = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchPetition.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let petition = searchPetition[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
           
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = searchPetition[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

