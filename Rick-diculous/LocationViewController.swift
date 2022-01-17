//
//  LocationViewController.swift
//  Rick-diculous
//
//  Created by 梁程 on 2021/11/17.
//

import UIKit

class LocationViewController: UIViewController {
    let locationCollectionView = Tools.setUpCollectionView(10, 20, 75, (Int(K.screenWidth) - 20 - 32))
    let searchController = UISearchController(searchResultsController: nil)
    var locationData: LocationData?
    var locationList: [Location] = []
    func GetLocations(_ page: Int, onCompletion:@escaping () -> ()){
        let urlString = "https://rickandmortyapi.com/api/location/?page=" + String(page)
        URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { [self]data, response, error in
            if error == nil {
                do{
                    self.locationData = try JSONDecoder().decode(LocationData.self, from: data!)
                    
                    locationList += locationData!.results
                    DispatchQueue.main.async {
                        onCompletion()
                    }
                }catch{
                    //print(error)
                }
            }
        }).resume()
    }
    
    let searchButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "magnifyingglass.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(K.brandYellow), for: .normal)
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        btn.backgroundColor = UIColor(named: "background")
        btn.layer.cornerRadius = 25
        btn.layer.borderWidth = 5
        btn.layer.borderColor = K.rmGreen.cgColor
        Tools.setHeight(btn, 50)
        Tools.setWidth(btn, 50)
        return btn
    }()
    
    @objc func searchPressed(sender: UIButton){
        sender.showAnimation {
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationCollectionView.delegate = self
        locationCollectionView.dataSource = self
        locationCollectionView.register(LocationCell.self, forCellWithReuseIdentifier: "LocationCell")
        locationCollectionView.backgroundColor = UIColor(named: "backgroud")
        locationCollectionView.showsVerticalScrollIndicator = true
        for i in 0..<7 {
            GetLocations(i){
                self.locationCollectionView.reloadData()
            }
        }

        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.title = "126 Locations"
        
        view.addSubview(locationCollectionView)
        locationCollectionView.snp.makeConstraints { make  in
            make.top.equalTo(view)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
            make.bottom.equalTo(view)
        }
        
        
        searchButton.addTarget(self, action: #selector(searchPressed(sender:)), for: .touchUpInside)
        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-30)
            make.right.equalTo(view).offset(-30)
            
        }
    }
    

}

extension LocationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationCell", for: indexPath) as! LocationCell
        cell.layer.borderWidth = 3
        cell.layer.borderColor = K.rmGreen.cgColor
        cell.layer.cornerRadius = 10
        
        cell.nameLabel.text = locationList[indexPath.row].name
        cell.typeLabel.text = "Type: \(locationList[indexPath.row].type == "" ? "Unkown" : locationList[indexPath.row].type)"
        cell.dimensionLabel.text = "Dimention: \(locationList[indexPath.row].dimension)"
        
        
        return cell
    }
}

