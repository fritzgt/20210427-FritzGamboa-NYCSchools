//
//  DetailViewController.swift
//  20210427-FritzGamboa-NYCSchools
//
//  Created by FGT MAC on 4/28/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var numberOfTestLabel: UILabel!
    
    
    // MARK: - Properties
    var selectedSchool: SchoolModelCodable?{
        didSet{
            SetLabels()
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Private methods
    private func SetLabels() {
        //Set data to labels
        guard let school = selectedSchool else {
            return
        }
        DispatchQueue.main.async {
            self.schoolNameLabel.text = school.schoolName
            self.numberOfTestLabel.text = school.satScores!.numOfSatTestTakers
        }
    }
}
