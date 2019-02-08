//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by XMS_JZhan on 2/8/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    // MARK: - Properties
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Update Views pattern
    func updateViews() {
        guard let movie = movie else { return }
        self.titleLabel.text = movie.title
        self.ratingLabel.text = "Rating: \(movie.rating)"
        self.overviewLabel.text = movie.overview
        self.movieImageView.image = nil
    }
}
