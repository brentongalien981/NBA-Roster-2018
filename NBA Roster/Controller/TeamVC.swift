//
//  TeamVC.swift
//  NBA Roster
//
//  Created by ops on 2017-12-16.
//  Copyright © 2017 ops. All rights reserved.
//

import UIKit

class TeamVC: UIViewController {

    @IBOutlet weak var teamLogoImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamConfNameLabel: UILabel!
    @IBOutlet weak var teamDivNameLabel: UILabel!
    
    var team : Team!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teamNameLabel.text = team.fullName
        print("tricode \(team.triCode.lowercased())")
        setTeamLogoImageView(teamTriCode: team.triCode.lowercased())
        
//        sillyString.lowercased()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeTeamVC(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setTeamLogoImageView(teamTriCode : String) {
        
        let rawUrl = "http://i.cdn.turner.com/nba/nba/.element/img/1.0/teamsites/logos/teamlogos_500x500/" + teamTriCode + ".png"
        let url = URL(string: rawUrl)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.teamLogoImageView.image = UIImage(data: data!)
            }
            
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
