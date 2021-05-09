//
//  SeriesTableViewController.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 05.05.2021.
//

import UIKit

class SeriesTableViewController: UITableViewController {
    
    
    var series = [Series]()

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return series.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "series", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = series[indexPath.row].title
        content.textProperties.color = .black
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 15)
        cell.contentConfiguration = content
        
        return cell
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailSeriesVC = segue.destination as? DetailSeriesViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        detailSeriesVC.series = series[indexPath.row]
    }
    
    func fetchSeries(id: String) {
        NetworkManager.shared.fetchSeries(id: id) { (dataSeries) in
            self.series = dataSeries
            self.tableView.reloadData()
            
        }
    }
    
}
