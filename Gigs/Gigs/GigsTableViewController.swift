//
//  GigsTableViewController.swift
//  Gigs
//
//  Created by Waseem Idelbi on 6/6/22.
//

import UIKit

class GigsTableViewController: UITableViewController {

//MARK: - Properties
    let gigController = GigController()
    
//MARK: - Methods
    // When the view has finished loading in memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // When the view has finished being drawn on the screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let _ = gigController.bearer {
            // TODO: fetch gigs here
        } else {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        }
    }

//MARK: TableView DataSource and Delegate
    // Number of rows in the tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    // Configure each cell in the tableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    
//MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
