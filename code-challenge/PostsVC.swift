//
// Created by Roland Leth on 29/06/2020.
// 
//

import UIKit
class PostsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@objc
	lazy var posts = [[String: Any]]()
	var table = UITableView()
	let currentPage = 1
	@objc var photosPerPage: Int {
		get {
			15 }
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		table.delegate = self
		table.dataSource = self
		table.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		view.addSubview(table)
		table.frame = view.frame

		self.title = "Posts"
		self.table.register(PhotoCell.self, forCellReuseIdentifier: "PhotoCell")

		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPost))
	}

	@objc
	private func addPost() {
		present(AddPostVC(), animated: true)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)


		var url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

		URLSession(configuration: .default)
			.dataTask(with: url) { r, res, e in
				let data = try! JSONSerialization.jsonObject(with: r!, options: .allowFragments)
				self.posts = data as! Array<Dictionary<String, Any>>

				DispatchQueue.main.async {
					self.table.reloadData()
				}
			}.resume()

		self.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
	}

	func numberOfSections(in tableView: UITableView) -> Int { 1 }

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if posts.isEmpty { return 0 }
		else { return currentPage * photosPerPage }
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let post = self.posts[indexPath.row]
		let cell = UITableViewCell()
		cell.textLabel?.text = post["title"] as? String
		return cell
	}

}
