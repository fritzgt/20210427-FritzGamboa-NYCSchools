//
//  ModelController.swift
//  20210427-FritzGamboa-NYCSchools
//
//  Created by FGT MAC on 4/28/21.
//

import Foundation

class SchoolController {
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    private let baseURL = URL(string: "https://data.cityofnewyork.us")
    
    private lazy var schoolsURL = URL(string: "/resource/s3k6-pzi2.json", relativeTo: baseURL)
    private lazy var scoresURL = URL(string: "/resource/f9bf-2cp4.json", relativeTo: baseURL)
    
    // MARK: - Properties
    var schools: [SchoolModelCodable] = []
    private var scoresArray: [ScoreModelCodable] = []

    
    // MARK: - Methods
    private func getData(getScores: Bool, completion: @escaping () -> Void) {
        
        var urlComponents: URLComponents?
        
        //if there is a scoresForSchool term/name the we get the scores else we request a list of schools
        if getScores {
            urlComponents = URLComponents(url: scoresURL!, resolvingAgainstBaseURL: true)
        }else{
            urlComponents = URLComponents(url: schoolsURL!, resolvingAgainstBaseURL: true)
        }
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion()
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, _, error) in
            
            if let _ = error {
                print("Error fetching data")
                completion()
                return
            }
            
            guard let self = self else{
                completion()
                return
            }
            
            guard let data = data else{
                print("No data returned from data task")
                completion()
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do{
                if getScores{
                    let scores = try jsonDecoder.decode([ScoreModelCodable].self, from: data)
                    self.scoresArray.append(contentsOf: scores)
                    
                    completion()
                }else{
                    let schoolsResults = try jsonDecoder.decode([SchoolModelCodable ].self, from: data)
                    self.schools.append(contentsOf: schoolsResults)
                    completion()
                }

            }catch{
                print("Unable to decode data: \(error)")
                completion()
                return
            }
            
            
        }.resume()
        
    }
    
    func loadData(completion: @escaping () -> Void) {
        getData(getScores: false) {
            self.getData(getScores: true) {
                self.mapSATScoresToSchools()
                completion()
            }
        }
    }
    
    private func mapSATScoresToSchools() {
        
        let previous = schools
        schools.removeAll()
        
        for satScore in scoresArray{
             
                var matchSchool = previous.first(where: { (nycHighSchool) -> Bool in
                    
                    return nycHighSchool.dbn == satScore.dbn
                })
            guard matchSchool != nil else {
                continue
            }
            
            matchSchool?.satScores = satScore
            schools.append(matchSchool!)
        }
    }
}
