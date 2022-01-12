//
//  CharCell.swift
//  Rick-diculous
//
//  Created by 梁程 on 2021/11/16.
//

import UIKit
import SnapKit
import DynamicBottomSheet
import KRProgressHUD

protocol CharCellDelegate {
    func didLongPressCell(index: Int)
}

class CharCell: UICollectionViewCell {

    var delegate: CharCellDelegate?
    var index = 0
    
    let charImage: UIImageView = {
        let iv = UIImageView()
        Tools.setHeight(iv, 200)
        iv.clipsToBounds = true
        iv.layer.borderWidth = 3
        iv.layer.cornerRadius = 10
        iv.layer.borderColor = UIColor(named: "border")?.cgColor
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "menlo", size: 16)
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    let statusLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "menlo", size: 14)
        lbl.font = UIFont.monospacedSystemFont(ofSize: 14, weight: .bold)
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    
    let episodeLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "menlo", size: 14)
        return lbl
    }()
    
    @objc func didLongPressImageView(sender: UILongPressGestureRecognizer){
        delegate?.didLongPressCell(index: index)
    }
    
    

    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressImageView(sender:)))
        
        charImage.addGestureRecognizer(longPressRecognizer)
        
        
        contentView.addSubview(charImage)
        charImage.snp.makeConstraints { make  in
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.top.equalTo(contentView)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make  in
            make.top.equalTo(charImage.snp_bottomMargin).offset(10)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
        

        contentView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make  in
            make.top.equalTo(nameLabel.snp_bottomMargin).offset(10)

            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
        
        
        contentView.addSubview(episodeLabel)
        episodeLabel.snp.makeConstraints { make  in
            make.top.equalTo(statusLabel.snp_bottomMargin).offset(10)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class longPressBottomSheet: DynamicBottomSheetViewController {
    
    var charImage: UIImage?

    @objc func saveCompleted(_ image: UIImage,
         didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {

         if let error = error {
             print("ERROR: \(error)")
         }else {
             KRProgressHUD.showMessage("Saved to album")
         }
     }
    
    func writeToPhotoAlbum(image: UIImage) {
          UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
      }
    
    @objc func downloadButtonPressed(sender: UIButton){
        sender.showAnimation {
            if self.charImage != nil {
                self.writeToPhotoAlbum(image: self.charImage!)
            }else{
                KRProgressHUD.showMessage("Failed")
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }


    override func configureView() {
        super.configureView()
        setUpBottomSheet()
    }
    
    func setUpBottomSheet(){
        let downloadButton = Tools.setUpButton(btnTitle: "Save to album", color: K.brandGreen, fontSize: 20, width: 200, height: 50, fontWeight: .bold)
        downloadButton.addTarget(self, action: #selector(downloadButtonPressed(sender:)), for: .touchUpInside)
        
        let dragButton: UIButton = {
            let btn = UIButton()
            btn.setBackgroundColor(color: K.rmGreen, forState: .normal)
            btn.layer.cornerRadius = 6
            btn.isEnabled = false

            Tools.setHeight(btn, 12)
            Tools.setWidth(btn, 50)
            
            return btn
        }()
        
        contentView.addSubview(dragButton)
        dragButton.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(8)
        }
        
        
        contentView.addSubview(downloadButton)
        contentView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        downloadButton.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.centerY.equalTo(contentView)
        }

    }
}
