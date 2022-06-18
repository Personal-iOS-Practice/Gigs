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
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }
    
//MARK: - Methods
    // When the view has finished loading in memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // When the view has finished being drawn on the screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let _ = gigController.bearer {
            getLukeAsGig()
        } else {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        }
    }
    // Handle fetching and showing Luke's data
    func getLukeAsGig() {
        gigController.fetchLukeAsGig { result in
            DispatchQueue.main.async {
                do {
                    let lukeGig = try result.get()
                    self.gigController.gigs.append(lukeGig)
                    self.tableView.reloadData()
                } catch {
                    print("ERROR: Failed getting Luke as a Gig with error message: \(error)")
                    return
                }
            }
        }
    }

//MARK: TableView DataSource and Delegate
    // Number of rows in the tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gigController.gigs.count
    }
    // Configure each cell in the tableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currGig = gigController.gigs[indexPath.row]
        let dateString = dateFormatter.string(from: currGig.dueDate)
        let cell = tableView.dequeueReusableCell(withIdentifier: "GigCell", for: indexPath)
        cell.textLabel?.text = currGig.title
        cell.detailTextLabel?.text = "Due \(dateString)"
        return cell
    }
    
//MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginSegue" {
            let loginVC = segue.destination as! LoginViewController
            loginVC.gigController = gigController
        } else if segue.identifier == "NewGigSegue" {
            let detailVC = segue.destination as! GigDetailViewController
            detailVC.gigController = gigController
            detailVC.delegate = self
        } else if segue.identifier == "ViewGigSegue" {
            let detailVC = segue.destination as! GigDetailViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let gig = gigController.gigs[indexPath.row]
            detailVC.delegate = self
            detailVC.gigController = gigController
            detailVC.gig = gig
            
        }
    }
    
}

extension GigsTableViewController: GigDelegate {
    // When a new gig is added
    func gigWasAdded(gig: Gig) {
        gigController.gigs.append(gig)
        tableView.reloadData()
    }
    // When an existing gig is modified
    func gigWasModified(oldGig: Gig, newGig: Gig) {
        guard let index = gigController.gigs.firstIndex(where: { $0 == oldGig }) else { return }
        gigController.gigs.remove(at: index)
        gigController.gigs.insert(newGig, at: index)
        tableView.reloadData()
    }
}
