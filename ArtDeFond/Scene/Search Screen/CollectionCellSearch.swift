//
//  CollectionCellSearch.swift
//  ArtDeFond
//
//  Created by developer on 24.08.2022.
//

import Foundation
import Foundation
import UIKit

class CollectionCellSearch: UICollectionViewCell {
    
    static let reuseIdentifier = "CollectionCellSearch"
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Constants.Fonts.semibold15
        label.textAlignment = .center
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.3
        roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 16.0)
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.removeFromSuperview()
        title.removeFromSuperview()
    }
    
    func configureCell(title: String, imageView: UIImage) {
        self.title.text = title
        self.imageView.image = imageView
    }
    
    func createLayout() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.addSubview(blackView)
        blackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(title)
        title.snp.makeConstraints { make in
            make.centerY.equalTo(blackView)
            make.left.equalTo(blackView.snp.left).inset(15)
            make.right.equalTo(blackView.snp.right).inset(15)
        }
    }
    
}

extension CollectionCellSearch {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
