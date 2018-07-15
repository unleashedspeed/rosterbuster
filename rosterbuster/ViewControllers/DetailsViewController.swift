//
//  DetailsViewController.swift
//  rosterbuster
//
//  Created by Saurabh Gupta on 15/07/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var flightnrLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var aircraftTypeLabel: UILabel!
    @IBOutlet weak var tailLabel: UILabel!
    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    @IBOutlet weak var dutyIdLabel: UILabel!
    @IBOutlet weak var dutyCodeLabel: UILabel!
    @IBOutlet weak var captainLabel: UILabel!
    @IBOutlet weak var firstOfficerLabel: UILabel!
    @IBOutlet weak var flightAttendantLabel: UILabel!
    
    var event: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDetails()
    }
    
    // MARK: Helper Methods to set details
    func setDetails() {
        eventImageView.image = DutyCode(rawValue: event.dutyCode ?? "FLIGHT")?.image
        flightnrLabel.text = event.flightnr ?? ""
        dateLabel.text = event.date ?? ""
        aircraftTypeLabel.text = event.aircraftType ?? ""
        tailLabel.text = event.tail ?? ""
        departureLabel.text = event.departure ?? ""
        destinationLabel.text = event.destination ?? ""
        departureTimeLabel.text = event.departTime ?? ""
        arrivalTimeLabel.text = event.arrivalTime ?? ""
        dutyIdLabel.text = event.dutyID ?? ""
        dutyCodeLabel.text = event.dutyCode ?? ""
        captainLabel.text = event.captain ?? ""
        firstOfficerLabel.text = event.firstOfficer ?? ""
        flightAttendantLabel.text = event.flightAttendant ?? ""
    }
}
