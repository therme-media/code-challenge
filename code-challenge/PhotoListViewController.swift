//
// Created by Roland Leth on 29/06/2020.
// 
//

import UIKit

class PhotoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	lazy var table = UITableView()
	@objc
	var photos = [[String: Any]]()
	let currentPage = 1
	@objc var photosPerPage: Int { get { 10 } }

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.


		view.backgroundColor = .red

		table.delegate = self
		table.dataSource = self
		table.translatesAutoresizingMaskIntoConstraints = false

		view.addSubview(table)
		NSLayoutConstraint.activate([
										table.leftAnchor.constraint(equalTo: view.leftAnchor),
										table.rightAnchor.constraint(equalTo: view.rightAnchor),
										table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
										table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])

		self.title = "Posts"
		self.table.register(PhotoCell.self, forCellReuseIdentifier: "PhotoCell")
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)


		var url = URL(string: "https://jsonplaceholder.typicode.com/photos")!
		tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
		URLSession(configuration: .default)
			.dataTask(with: url) { r, res, e in
				let data = try! JSONSerialization.jsonObject(with: r!, options: .allowFragments)
				self.photos = data as! Array<Dictionary<String, Any>>

				DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
					self.table.reloadData()
				}
			}.resume()

	}


	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if photos.isEmpty { return 0 } else { return currentPage * photosPerPage }
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let photo = photos[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell?

		cell!.lblTitle.text = photo["title"] as? String
		URLSession(configuration: .default)
			.dataTask(with: URL(string: photo["url"] as! String)!) { data, res, e in
				if let data = data {
					DispatchQueue.main.async {
						cell!.photo.image = UIImage.init(data: data)
					}
				}
			}
			.resume()

		return cell!
	}

}

