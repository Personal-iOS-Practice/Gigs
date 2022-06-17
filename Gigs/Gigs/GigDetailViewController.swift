//
//  GigDetailViewController.swift
//  Gigs
//
//  Created by Waseem Idelbi on 6/14/22.
//

import UIKit

protocol GigDelegate {
    func gigWasAdded(gig: Gig)
    func gigWasModified(oldGig: Gig, newGig: Gig)
}

class GigDetailViewController: UIViewController {
    
//MARK: - Properties
    var gigController: GigController!
    var gig: Gig?
    var delegate: GigDelegate?
    
//MARK: - Methods
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    // Configure UI elements
    func updateViews() {
        if let gig = gig {
            jobTitleTextField.text = gig.title
            dueDatePicker.date = gig.dueDate
            descriptionTextView.text = gig.description
        } else {
            self.title = "New Gig"
        }
    }

//MARK: - IBOutlets
    @IBOutlet weak var jobTitleTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!
    
//MARK: - IBActions
    // When the user taps the save button
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = jobTitleTextField.text,
              let description = descriptionTextView.text else { return }
        let date = dueDatePicker.date
        let newGig = Gig(title: title, description: description, dueDate: date)
        
        //TODO: pass the data to the Gig controller's POST
        
        if let gig = gig {
            delegate?.gigWasModified(oldGig: gig, newGig: newGig)
        } else {
            delegate?.gigWasAdded(gig: newGig)
        }
        
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}
