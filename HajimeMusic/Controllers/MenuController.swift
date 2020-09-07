//
//  MenuController.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/12/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit

class MenuController: UITableViewController {
    
    //MARK: - LyfeCycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        
    }
    
    
    
    //MARK: - Methods -
    
    private func configureTableView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.contentInset = .init(top: 60, left: 0, bottom: 0, right: 0)
    }
}


//MARK: - Delegate -
extension MenuController {
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 { return 0 }
        return 15
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
