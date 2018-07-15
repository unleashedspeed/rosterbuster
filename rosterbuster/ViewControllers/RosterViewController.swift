//
//  RosterViewController.swift
//  rosterbuster
//
//  Created by Saurabh Gupta on 08/07/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit
import CoreData

class RosterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!

    var rosters: [NSManagedObject] = []
    let cellReuseIdentifier = "RosterCell"
    public var managedContext: NSManagedObjectContext!
    
    lazy var fetchedResultsController: NSFetchedResultsController = { () -> NSFetchedResultsController<NSManagedObject> in
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedContext = appDelegate.persistentContainer.viewContext
        }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Event")
        let primarySortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [primarySortDescriptor]
        
        let frc = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.managedContext,
            sectionNameKeyPath: "date",
            cacheName: nil)
        
        frc.delegate = self
        
        return frc
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(RosterViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("An error occurred")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Event")
//
//        do {
//            rosters = try managedContext.fetch(fetchRequest)
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//
        if fetchedResultsController.sections?.count == 0 {
            loadData()
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RosterTableViewCell.nib(), forCellReuseIdentifier: cellReuseIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
        tableView.addSubview(self.refreshControl)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadData()
    }
    
    func loadData() {
        APIService.standard.getRosters { (rosters, error) in
            if error == nil {
                guard let rosters = rosters else { return }
                self.updateStorage(rosters: rosters)
            } else {
                DispatchQueue.main.async {
                    if self.refreshControl.isRefreshing {
                        self.refreshControl.endRefreshing()
                    }
                }
            }
        }
    }
    
    func updateStorage(rosters: [Roster]) {
        self.rosters.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedContext.execute(deleteRequest)
        } catch let error as NSError {
            // TODO: handle the error
        }
        for roster in rosters {
            let entity = NSEntityDescription.entity(forEntityName: "Event", in: managedContext)!
            let rosterManagedObject = NSManagedObject(entity: entity, insertInto: managedContext)
            rosterManagedObject.setValue(roster.aircraftType, forKey: "aircraftType")
            rosterManagedObject.setValue(roster.arrivalTime, forKey: "arrivalTime")
            rosterManagedObject.setValue(roster.captain, forKey: "captain")
            rosterManagedObject.setValue(roster.date, forKey: "date")
            rosterManagedObject.setValue(roster.departTime, forKey: "departTime")
            rosterManagedObject.setValue(roster.departure, forKey: "departure")
            rosterManagedObject.setValue(roster.destination, forKey: "destination")
            rosterManagedObject.setValue(roster.dutyCode, forKey: "dutyCode")
            rosterManagedObject.setValue(roster.dutyID, forKey: "dutyID")
            rosterManagedObject.setValue(roster.firstOfficer, forKey: "firstOfficer")
            rosterManagedObject.setValue(roster.flightAttendant, forKey: "flightAttendant")
            rosterManagedObject.setValue(roster.flightnr, forKey: "flightnr")
            rosterManagedObject.setValue(roster.tail, forKey: "tail")
            
            do {
                try managedContext.save()
                self.rosters.append(rosterManagedObject)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
        DispatchQueue.main.async {
            do {
                try self.fetchedResultsController.performFetch()
            } catch {
                print("An error occurred")
            }
            self.tableView.reloadData()
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
        }
    }
}

extension RosterViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let currentSection = sections[section]
            return currentSection.numberOfObjects
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! RosterTableViewCell
        let event = fetchedResultsController.object(at: indexPath) as! Event
        cell.configureWith(event: event)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = fetchedResultsController.sections {
            let currentSection = sections[section]
            return currentSection.name
        }
        
        return nil
    }
}

