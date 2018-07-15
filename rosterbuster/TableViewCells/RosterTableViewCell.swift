//
//  RosterTableViewCell.swift
//  rosterbuster
//
//  Created by Saurabh Gupta on 14/07/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit
import FontAwesome_swift

class RosterTableViewCell: UITableViewCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventInformationLabel: UILabel!
    @IBOutlet weak var dutyInformationLabel: UILabel!
    @IBOutlet weak var eventTimingsLabel: UILabel!
    @IBOutlet weak var eventExtraInformation: UILabel!
    
    enum DutyCode: String {
        case off = "OFF"
        case report = "REPORT"
        case flight = "FLIGHT"
        case debrief = "DEBRIEF"
        case layover = "LAYOVER"
        case training = "TRAINING"
        case standby = "Standby"
        case positioning = "POSITIONING"
        
        var image: UIImage {
            switch self {
            case .off:
                return UIImage.fontAwesomeIcon(name: .suitcase, textColor: .black, size: CGSize(width: 40, height: 40))
            case .report:
                return UIImage.fontAwesomeIcon(name: .hourglassStart, textColor: .black, size: CGSize(width: 40, height: 40))
            case .flight:
                return UIImage.fontAwesomeIcon(name: .plane, textColor: .black, size: CGSize(width: 40, height: 40))
            case .debrief:
                return UIImage.fontAwesomeIcon(name: .hourglassEnd, textColor: .black, size: CGSize(width: 40, height: 40))
            case .layover:
                return UIImage.fontAwesomeIcon(name: .suitcase, textColor: .black, size: CGSize(width: 40, height: 40))
            case .training:
                return UIImage.fontAwesomeIcon(name: .book, textColor: .black, size: CGSize(width: 40, height: 40))
            case .standby:
                return UIImage.fontAwesomeIcon(name: .paste, textColor: .black, size: CGSize(width: 40, height: 40))
            case .positioning:
                return UIImage.fontAwesomeIcon(name: .mapMarker, textColor: .black, size: CGSize(width: 40, height: 40))
            }
        }
    }

    func configureWith(event: Event) {
        if let dutyCode = event.dutyCode {
            self.eventImageView.image = DutyCode(rawValue: dutyCode)?.image
            switch dutyCode.capitalized {
            case DutyCode.off.rawValue.capitalized:
                eventInformationLabel.text = dutyCode
                dutyInformationLabel.text = " "
                eventTimingsLabel.text = "24 Hours"
                eventExtraInformation.text = " "
            
            case DutyCode.report.rawValue.capitalized, DutyCode.flight.rawValue.capitalized:
                eventInformationLabel.text = (event.departure ?? "") + " - " + (event.destination ?? "")
                dutyInformationLabel.text = " "
                eventTimingsLabel.text = (event.departTime ?? "") + " - " + (event.arrivalTime ?? "")
                eventExtraInformation.text = " "
                
            case DutyCode.debrief.rawValue.capitalized:
                eventInformationLabel.text = dutyCode
                dutyInformationLabel.text = ""
                eventTimingsLabel.text = "24 Hours"
                eventExtraInformation.text = ""
                
            case DutyCode.layover.rawValue.capitalized:
                eventInformationLabel.text = dutyCode
                dutyInformationLabel.text = event.departure ?? ""
                eventTimingsLabel.text = "24 Hours"
                eventExtraInformation.text = ""
                
            case DutyCode.training.rawValue.capitalized:
                eventInformationLabel.text = dutyCode
                dutyInformationLabel.text = ""
                eventTimingsLabel.text = "24 Hours"
                eventExtraInformation.text = ""
                
            case DutyCode.standby.rawValue.capitalized:
                eventInformationLabel.text = dutyCode
                dutyInformationLabel.text = event.dutyID ?? ""
                eventTimingsLabel.text = (event.departTime ?? "") + " - " + (event.arrivalTime ?? "")
                eventExtraInformation.text = "Match Crew"
                
            case DutyCode.positioning.rawValue.capitalized:
                eventInformationLabel.text = dutyCode
                dutyInformationLabel.text = ""
                eventTimingsLabel.text = "24 Hours"
                eventExtraInformation.text = ""
            
            default:
                // Handle any default case here, this is just an example
                self.eventImageView.image = UIImage.fontAwesomeIcon(name: .plane, textColor: .black, size: CGSize(width: 40, height: 40))
                eventInformationLabel.text = ""
                dutyInformationLabel.text = ""
                eventTimingsLabel.text = ""
                eventExtraInformation.text = ""
            }
            
        }
        
    }
    
}
