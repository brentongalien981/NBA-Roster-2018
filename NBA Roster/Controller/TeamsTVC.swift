//
//  TeamsTVC.swift
//  NBA Roster
//
//  Created by ops on 2017-12-08.
//  Copyright © 2017 ops. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TeamsTVC: UITableViewController {
    
    //Constants
    let MY_URL = "http://data.nba.net/prod/v1/2017/teams.json"
    
    @IBOutlet var teamsTableView: UITableView!
    
    var teams = [Team]()
    var selectedTeamIndex = -69
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTeams()

        

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    private func setTeams() {
        
        Alamofire.request(MY_URL, method: .get, parameters: nil).responseJSON {
            response in
            
            if response.result.isSuccess {
                print("Success! retrieving JSON!")
                
                // This JSON() method is from SwiftyJSON
                let teamsJson : JSON = JSON(response.result.value!)
//                print(teamsJson)
                self.populateTeams(json: teamsJson)
                
            }
            else {
                print("FAILURE on retrieving Teams JSON.")
                print("Error: \(response.result.error)")
                
            }
        }
    }
    
    private func populateTeams(json: JSON) {
        
        if let teamsJson = json["league"]["standard"].array {
            
            var count = 0
            
            for teamJson in teamsJson {
                if (teamJson["isNBAFranchise"].boolValue) {
                    count += 1
                    
                    let newTeam = Team()
                    newTeam.fullName = teamJson["fullName"].stringValue
                    newTeam.triCode = teamJson["tricode"].stringValue
                    teams.append(newTeam)
                }
                
            }
            
//            teamsTableView.reloadData()
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return teams.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamNameCell", for: indexPath)
        let team = teams[indexPath.row]
        
        cell.textLabel?.text = team.fullName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            selectedTeamIndex = indexPath.row
            
            // Get the storyboard and ResultViewController
            let storyboard = UIStoryboard (name: "Main", bundle: nil)
            let resultVC = storyboard.instantiateViewController(withIdentifier: "TeamVC") as! TeamVC
            
            //
            resultVC.team = teams[selectedTeamIndex]
            
            //
            self.present(resultVC, animated: true, completion: nil)
        }
    }
 

}
