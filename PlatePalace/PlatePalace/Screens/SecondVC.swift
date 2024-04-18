//
//  SecondVC.swift
//  PlatePalace
//
//  Created by PHN MAC 1 on 18/04/24.
//

import UIKit

class MessListCell: UITableViewCell{
    
}

class SecondVC: UIViewController {

    @IBOutlet weak var messList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension SecondVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messList.dequeueReusableCell(withIdentifier: MessListCell.id, for: indexPath) as! MessListCell
        return cell
    }
}


extension SecondVC: UITableViewDelegate{
    
}
