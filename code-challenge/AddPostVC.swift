//
// Created by Roland Leth on 29/06/2020.
// 
//

import UIKit


class AddPostVC: UIViewController {

	var txtTitle = UITextField()
	var txtBody = UITextView()

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)

		txtTitle.borderStyle = .roundedRect
		txtTitle.translatesAutoresizingMaskIntoConstraints = false
		txtBody.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(txtTitle)
		view.addSubview(txtBody)
		NSLayoutConstraint.activate([txtTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
									 txtTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
									 txtTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
									 txtTitle.heightAnchor.constraint(equalToConstant: 26)])
		NSLayoutConstraint.activate([txtBody.topAnchor.constraint(equalTo: txtTitle.bottomAnchor, constant: 20),
									 txtBody.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
									 txtBody.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
									 txtBody.heightAnchor.constraint(equalToConstant: 126)])

		let button = UIButton(type: .custom)
		button.backgroundColor = .systemBlue
		button.addTarget(self, action: #selector(addPost), for: .touchDown)
		button.setTitle("Save", for: .normal)
		button.setTitleColor(.white, for: .normal)
		view.addSubview(button)
		button.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([button.topAnchor.constraint(equalTo: txtBody.bottomAnchor, constant: 20),
									 button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
									 button.widthAnchor.constraint(equalToConstant: 100),
									 button.heightAnchor.constraint(equalToConstant: 46)])
	}

	@objc
	private func addPost() {
		var url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
		var request = URLRequest(url: url)
		let parameters =  [
			"title": txtTitle.text as Any,
			"body": txtBody.text as Any,
			"userId": 1
		]

		request.httpMethod = "POST"
		request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)

		URLSession(configuration: .default)
			.dataTask(with: request).resume()
	}

}
