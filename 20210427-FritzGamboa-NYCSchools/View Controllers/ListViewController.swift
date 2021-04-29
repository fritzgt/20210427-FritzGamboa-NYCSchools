//
//  ViewController.swift
//  20210427-FritzGamboa-NYCSchools
//
//  Created by FGT MAC on 4/28/21.
//

import UIKit

class ListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    private var schoolController = SchoolController()
    private var selectedSchool: SchoolModelCodable?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        getData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DetailVC: DetailViewController = segue.destination as! DetailViewController
        DetailVC.selectedSchool = selectedSchool
    }
    
    // MARK: - Private methods
    private func getData() {
        schoolController.loadData() {
            //pass data to next view
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.loadingIndicator.isHidden = true
            }
        }
    }
}

extension ListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  schoolController.schools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolCell", for: indexPath)
        
        let data = schoolController.schools[indexPath.row]
        cell.textLabel?.text = data.schoolName
        cell.detailTextLabel?.text = data.neighborhood
        
        return cell
    }
    
    
}

extension ListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedSchool = schoolController.schools[indexPath.row]
        return indexPath
    }
}
