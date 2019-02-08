//
//  MovieListTableViewController.swift
//  MovieSearch
//
//  Created by XMS_JZhan on 2/8/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    // Source of truth
    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    // MARK: - Table view data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        let movie = movies[indexPath.row]
        cell.movie = movie
        guard let posterPath = movie.posterPath else { return cell }
        MovieController.fetchImageFor(jpegURL: posterPath) { (image) in
            DispatchQueue.main.async {
                cell.movieImageView.image = image
            }
        }
        return cell
    }
}

// MARK: - Search Bar Delegate methods
extension MovieListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, searchTerm != "" else { return }
        MovieController.fetchRequestFor(searchTerm: searchTerm) { (movies) in
            self.movies = movies
        }
    }
}
