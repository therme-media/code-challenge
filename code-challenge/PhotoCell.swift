//
// Created by Roland Leth on 29/06/2020.
// 
//

import UIKit

class PhotoCell: UITableViewCell {


	var photo = UIImageView()
	var lblTitle = UILabel()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		lblTitle.translatesAutoresizingMaskIntoConstraints = false
		addSubview(lblTitle)
		NSLayoutConstraint.activate([lblTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
									 lblTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: 12),
									 lblTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)])

		addSubview(photo)
		photo.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([photo.leftAnchor.constraint(equalTo: leftAnchor),
									 photo.rightAnchor.constraint(equalTo: rightAnchor),
									 photo.topAnchor.constraint(equalTo: topAnchor),
									 photo.heightAnchor.constraint(equalToConstant: 175),
//									 photoView.heightAnchor.constraint(equalToConstant: 165),
									 photo.bottomAnchor.constraint(equalTo: lblTitle.topAnchor, constant: -8)])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
