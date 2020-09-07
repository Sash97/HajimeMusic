//
//  Home + Delegate.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 9/7/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit



extension HomeController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.transform = .identity
        
        UIView.animate(withDuration: 0.6) {
            cell.alpha = 1
            cell.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        }
        cell.transform = .identity
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dampingRatio: CGFloat = 0.8
        let initialVelocity: CGVector = CGVector.zero
        let springParameters: UISpringTimingParameters = UISpringTimingParameters(dampingRatio: dampingRatio, initialVelocity: initialVelocity)
        let animator = UIViewPropertyAnimator(duration: 0.5, timingParameters: springParameters)
        
        self.view.isUserInteractionEnabled = false
        
        if let selectedCell = expandedCell {
            animator.addAnimations {
                selectedCell.collapse()
                self.tableViewTopConstraint.constant += 100
                self.artistTableView.layoutIfNeeded()
                self.backView.alpha = 0
                for cell in self.hiddenCells {
                    cell.show()
                }
            }
            
            animator.addCompletion { _ in
                tableView.isScrollEnabled = true
                self.expandedCell = nil
                self.hiddenCells.removeAll()
            }
        } else {
            tableView.isScrollEnabled = false
            
            let selectedCell = tableView.cellForRow(at: indexPath)! as! ArtistsCell
            let frameOfSelectedCell = selectedCell.frame
            
            expandedCell = selectedCell
            hiddenCells = tableView.visibleCells.map { $0 as! ArtistsCell }.filter { $0 != selectedCell }
            
            animator.addAnimations {
                if let cell = tableView.cellForRow(at: IndexPath(row: self.artists!.count - 1, section: 0)) {
                    if tableView.visibleCells.contains(cell) {
                         selectedCell.expand(in: tableView, last: true)
                    }
                } else {
                    selectedCell.expand(in: tableView)
                }
                        
                self.tableViewTopConstraint.constant -= 100
                self.artistTableView.layoutIfNeeded()
                self.backView.alpha = 1
                
                for cell in self.hiddenCells {
                    cell.hide(in: tableView, frameOfSelectedCell: frameOfSelectedCell)
                }
            }
        }
        
        animator.addCompletion { _ in self.view.isUserInteractionEnabled = true }
        animator.startAnimation()
    }
}
