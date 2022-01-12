//
//  LocationCell.swift
//  Rick-diculous
//
//  Created by 梁程 on 2021/11/17.
//

import UIKit
import SnapKit

class LocationCell: UICollectionViewCell {

    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "menlo", size: 16)
        lbl.font = UIFont.monospacedSystemFont(ofSize: 16, weight: .bold)
        lbl.textColor = K.brandYellow
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    let typeLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "menlo", size: 16)
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    let dimensionLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "menlo", size: 16)
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make  in
            make.top.equalTo(contentView).offset(8)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
        
        contentView.addSubview(typeLabel)
        typeLabel.snp.makeConstraints { make  in
            make.top.equalTo(nameLabel.snp_bottomMargin).offset(8)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
        
        contentView.addSubview(dimensionLabel)
        dimensionLabel.snp.makeConstraints { make  in
            make.top.equalTo(typeLabel.snp_bottomMargin).offset(8)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

