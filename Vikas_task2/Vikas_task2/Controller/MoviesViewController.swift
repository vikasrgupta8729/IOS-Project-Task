//
//  MoviesViewController.swift
//  Vikas_task2
//
//  Created by BATWOMAN on 21/04/23.
//

import UIKit


class MoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesTable: UITableView!
    
    private var viewModel = MovieViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadMoviesData()
        
    }
    
    private func loadMoviesData() {
        viewModel.fetchPopularMoviesData { [weak self] in
//            self?.moviesTable.dataSource = self
            self?.moviesTable.reloadData()
        }
    }
    
    
    @IBAction func refreshBtnClicked(_ sender: UIButton) {
        //reload the table
        
        for i in 0..<viewModel.popularMovies.count{
            viewModel.popularMovies[i].checkbox = false
        }
        
        moviesTable.reloadData()
        
    }
    
}


extension MoviesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section) //count of images
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = moviesTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        cell.titleLbl.text = viewModel.popularMovies[indexPath.row].title //title of movie
        
        cell.desclbl.text = viewModel.popularMovies[indexPath.row].overview //description of movie
        
        //fetch img data from server
        let imgPath = "https://image.tmdb.org/t/p/w300" + (viewModel.popularMovies[indexPath.row].posterImage ?? "not getting image path")
        
        if let imgUrl = URL(string: imgPath){
//            getImageDataFrom(url: imgUrl)
            
            URLSession.shared.dataTask(with: imgUrl) { (data, response, error) in
                // Handle Error
                if let error = error {
                    print("DataTask error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    // Handle Empty Data
                    print("Empty Data")
                    return
                }
                
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
//                        self.moviePoster.image = image
                        cell.movieImg.image = image
                    }
                    
                }
            }.resume()
        }
        
        
        
        if viewModel.popularMovies[indexPath.row].checkbox{
            cell.checkboxBtn.setImage(UIImage(named: "tick"), for: .normal)
        }
        else{
            cell.checkboxBtn.setImage(UIImage(named: "untick"), for: .normal)
        }
        
        cell.checkboxBtn.tag = indexPath.row
        
        cell.checkboxBtn.addTarget(self, action: #selector(checkboxClicked(_:)), for: .touchUpInside)
        
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    @objc func checkboxClicked(_ sender: UIButton) {
        
        //set the checkbox value
        viewModel.popularMovies[sender.tag].checkbox = !viewModel.popularMovies[sender.tag].checkbox
        
        let indexpath = IndexPath(row: sender.tag, section: 0)
        moviesTable.reloadRows(at: [indexpath], with: .none)
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = moviesTable.dequeueReusableCell(withIdentifier: "cell") as! MovieTableViewCell
        
        if viewModel.popularMovies[indexPath.row].checkbox{
            // Display a dialog with the movie description
            let alertController = UIAlertController(title: "Description", message: viewModel.popularMovies[indexPath.row].overview, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
        else{
            // Display an alert to inform the user that the checkbox is disabled
            let alertController = UIAlertController(title: "Checkbox is disabled", message: "Please enable the checkbox to view the movie description.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            
        }
    }
    
    
    
    
}
