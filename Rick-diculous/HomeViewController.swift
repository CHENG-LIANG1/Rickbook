//
//  HomeViewController.swift
//  Rick-diculous
//
//  Created by 梁程 on 2021/11/16.
//

import UIKit
import SnapKit
import SDWebImage


class HomeViewController: UIViewController{
    let charCollectionView = Tools.setUpCollectionView(20, 20, 270, (Int(K.screenWidth) - 20 - 32) / 2)
    var imageView = UIImageView()
    var charData: CharData?
    var charArray: [Char] = []
    var nextUrl: String?
    var rasterSize: CGFloat = 10.0

    
    
    let topButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrow.up.square.fill")?.withTintColor(K.brandRed).withRenderingMode(.alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration(scale: .large)), for: .normal)
        Tools.setHeight(btn, 50)
        Tools.setWidth(btn, 55)

        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        
        return btn
    }()
    
    @objc func topAction(sender: UIButton){
        sender.showAnimation {
            let gen = UIImpactFeedbackGenerator(style: .heavy)
            gen.impactOccurred()
            self.charCollectionView.setContentOffset(.zero, animated: true)
        }
    }

    func GetCharacters(_ page: Int, onCompletion:@escaping () -> ()){
        let urlString = "https://rickandmortyapi.com/api/character/?page=" + String(page)
        URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { [self]data, response, error in
            if error == nil {
                do{
                    self.charData = try JSONDecoder().decode(CharData.self, from: data!)
                    
                    charArray += charData!.results
                    DispatchQueue.main.async {
                        onCompletion()
                    }
                }catch{
                    //print(error)
                }
            }
        }).resume()
    }
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = "826 Characters"
        
        for i in 1..<42 {
            GetCharacters(i){
                self.charCollectionView.reloadData()
            }
        }
        
        charCollectionView.register(CharCell.self, forCellWithReuseIdentifier: "CharCell")
        charCollectionView.backgroundColor = UIColor(named: "background")
        charCollectionView.delegate = self
        charCollectionView.dataSource = self
        
        view.addSubview(charCollectionView)
        charCollectionView.snp.makeConstraints { make  in
            make.top.equalTo(view)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
            make.bottom.equalTo(view)
        }
        
        topButton.addTarget(self, action: #selector(topAction(sender:)), for: .touchUpInside)
        view.addSubview(topButton)
        topButton.snp.makeConstraints { make  in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-20)
        }
    }

}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharCell", for: indexPath) as! CharCell
        
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor(named: "border")?.cgColor
        cell.index = indexPath.row
        
        cell.delegate = self

        cell.nameLabel.text = charArray[indexPath.row].name

       cell.charImage.sd_setImage(with: URL(string: charArray[indexPath.row].image), placeholderImage: UIImage(named: "placeholder"))
        
        cell.statusLabel.text = "\(charArray[indexPath.row].status) - \(charArray[indexPath.row].species)"
        
        if charArray[indexPath.row].status == "Alive"{
            cell.statusLabel.textColor = K.rmGreen
        }
        
        if charArray[indexPath.row].status == "Dead"{
            cell.statusLabel.textColor = K.brandRed
        }
        
        if charArray[indexPath.row].status == "unknown"{
            cell.statusLabel.text = "Unknown"
            cell.statusLabel.textColor = K.brandBlue
        }
        
        var episode = String(charArray[indexPath.row].episode[0].suffix(2))
        var season = 0
        
        if episode.hasPrefix("/") {
            episode = String(charArray[indexPath.row].episode[0].suffix(1))
        }
        
        var episodeNum = Int(episode)!
        
        if episodeNum > 0 && episodeNum <= 11 {
            season = 1
        }else if episodeNum > 11 && episodeNum <= 21{
            season = 2
            episodeNum -= 11
        }else if episodeNum > 21 && episodeNum <= 31 {
            season = 3
            episodeNum -= 21
        }else if episodeNum > 31 && episodeNum <= 41 {
            season = 4
            episodeNum -= 31
        }else if episodeNum > 41 && episodeNum <= 51 {
            season = 5
            episodeNum -= 41
        }
        
        
        cell.episodeLabel.text = "First seen in S\(season)E\(episodeNum)"
    
        return cell
    }
    

}

extension HomeViewController: CharCellDelegate {
    
    func didLongPressCell(index: Int) {
        imageView.sd_setImage(with: URL(string: charArray[index].image))
        let gen = UIImpactFeedbackGenerator(style: .heavy)
        gen.impactOccurred()
        let bottomSheet = longPressBottomSheet()
        bottomSheet.charImage = imageView.image
        self.present(bottomSheet, animated: true, completion: nil)
    }
    
    
}
