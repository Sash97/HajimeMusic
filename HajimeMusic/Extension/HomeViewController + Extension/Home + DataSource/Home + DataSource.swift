//
//  Home + DataSource.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 9/7/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit



extension HomeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.artist, for: indexPath) as! ArtistsCell
        cell.setCell(with: artists?[indexPath.row])
        cell.tapGestureCallBack = {
            let dampingRatio: CGFloat = 0.8
            let initialVelocity: CGVector = CGVector.zero
            let springParameters: UISpringTimingParameters = UISpringTimingParameters(dampingRatio: dampingRatio, initialVelocity: initialVelocity)
            let animator = UIViewPropertyAnimator(duration: 0.5, timingParameters: springParameters)
            self.view.isUserInteractionEnabled = false

            if let selectedCell = self.expandedCell {
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
            }
            
            animator.addCompletion { _ in self.view.isUserInteractionEnabled = true }
            animator.startAnimation()
        }
        cell.artistCellMusicCellDidTapped = { [weak self] index in
            guard let self = self else { return }
            DispatchQueue.main.async {
                var artist = self.artists![indexPath.row]
                artist.currentAudioIndex = index
                self.coordinator?.drivePlayerController(from: self, artist: artist)
            }
        }
        return cell
    }
}
