//
//  ShopProductListCell.swift
//  SwiftShoppingDemo
//
//  Created by superfly on 2022/10/23.
//

import UIKit
import SDWebImage
class ShopProductListCell: UITableViewCell {
    typealias selectRowCallBack = ((_ selectIndex: Int) ->())
    private var coverView: UIImageView!
    private var nameLabel: UILabel!
    private var ratingView: UIView!
    private var ratingLabel: UILabel!
    private var priceLabel : UILabel!
    private var collectionButton: UIButton!
    var selectRowNum: Int!
    var selectRowIndex: selectRowCallBack!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpSubViews() {
        let hstackView = UIStackView.init()
        hstackView.translatesAutoresizingMaskIntoConstraints = false
        hstackView.spacing = 8

        self.contentView.addSubview(hstackView)
        
        let coverView = UIImageView.init()
        coverView.image = UIImage.init(named: "heart.fill")
        contentView.contentMode = .scaleAspectFill
        hstackView.addArrangedSubview(coverView)
        self.coverView = coverView
        
        NSLayoutConstraint.activate([
            hstackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            hstackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            hstackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            coverView.widthAnchor.constraint(equalToConstant: 100),
            coverView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        
    /// 名字和评分
        let vStackView = UIStackView.init()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.spacing = 6
        vStackView.axis = .vertical
        hstackView.addArrangedSubview(vStackView)
        
        nameLabel = UILabel.init()
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        vStackView.addArrangedSubview(nameLabel)
        
        ratingView = UIView.init()
        ratingView.translatesAutoresizingMaskIntoConstraints = true
        ratingView.backgroundColor = .clear
        vStackView.addArrangedSubview(ratingView)
        NSLayoutConstraint.activate([
            ratingView.widthAnchor.constraint(equalToConstant: 100),
            ratingView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        ratingLabel = UILabel.init()
        ratingLabel.frame = CGRect.init(x: 0, y: 0, width: 100, height: 20)
        ratingLabel.textColor = .red
        ratingView.addSubview(ratingLabel)
        
        let butSctView = UIStackView()
        butSctView.spacing = 8
        vStackView.addArrangedSubview(butSctView)
        
        priceLabel = UILabel.init()
        priceLabel.textColor = .orange
        priceLabel.text = "$12"
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        butSctView.addArrangedSubview(priceLabel)
        
        collectionButton = UIButton.init()
        collectionButton.backgroundColor = .clear
        collectionButton.setTitleColor(.red, for: .normal)
        collectionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        collectionButton.setTitle("收藏", for: .normal)
        collectionButton.addTarget(self, action:#selector(collectionButtonTouchEvent), for: .touchUpInside)
        butSctView.addArrangedSubview(collectionButton)
        NSLayoutConstraint.activate([
            collectionButton.widthAnchor.constraint(equalToConstant:60),
            collectionButton.heightAnchor.constraint(equalToConstant:30)
        ])
        
        
    }
    
    func recePageModel(dataModel: ShopProductListModel) {
        var urlString = "https://gitee.com/xiaoyouxinqing/Learn-iOS-from-Zero/raw/main/API/Shopping/Image/\(dataModel.cover)"
        self.coverView.sd_setImage(with: URL.init(string: urlString))
        self.ratingLabel.text = String.init(format: "评分为：%d分", dataModel.rating!)
        self.nameLabel.text = dataModel.name
        self.priceLabel.text = String.init(format:"$%.2f",dataModel.price!)
        if dataModel.isCollection {
            collectionButton.setTitle("已收藏", for: .normal)
        } else {
            collectionButton.setTitle("收藏", for: .normal)
        }
        
    }
    
    @objc func collectionButtonTouchEvent() {
        self.selectRowIndex(self.selectRowNum)
    }

}
