import UIKit

class HomeViewController: UIViewController {
    let imageView = UIImageView()
    let taskViewButton = UIButton()
    let doneViewButton = UIButton()
    let catViewButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupLayout()
    }
}

extension HomeViewController {
    private func setup() {
        view.addSubview(imageView)
        view.addSubview(taskViewButton)
        view.addSubview(doneViewButton)
        view.addSubview(catViewButton)

        imageView.image = UIImage(systemName: "heart")
        imageView.contentMode = .scaleAspectFit

        taskViewButton.setTitle("Task", for: .normal)
        taskViewButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        taskViewButton.backgroundColor = UIColor.systemIndigo
        taskViewButton.setTitleColor(UIColor.white, for: .normal)
        taskViewButton.layer.cornerRadius = 8
        taskViewButton.addTarget(self, action: #selector(taskButtonTapped), for: .touchUpInside)

        doneViewButton.setTitle("Done", for: .normal)
        doneViewButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        doneViewButton.backgroundColor = UIColor.systemIndigo
        doneViewButton.setTitleColor(UIColor.white, for: .normal)
        doneViewButton.layer.cornerRadius = 8
        doneViewButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)

        catViewButton.setTitle("Cat", for: .normal)
        catViewButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        catViewButton.backgroundColor = UIColor.systemIndigo
        catViewButton.setTitleColor(UIColor.white, for: .normal)
        catViewButton.layer.cornerRadius = 8
        catViewButton.addTarget(self, action: #selector(catButtonTapped), for: .touchUpInside)
    }

    private func setupLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        taskViewButton.translatesAutoresizingMaskIntoConstraints = false
        doneViewButton.translatesAutoresizingMaskIntoConstraints = false
        catViewButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 10),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),

            taskViewButton.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 5),
            taskViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskViewButton.widthAnchor.constraint(equalToConstant: 100),
            taskViewButton.heightAnchor.constraint(equalToConstant: 36),

            doneViewButton.topAnchor.constraint(equalToSystemSpacingBelow: taskViewButton.bottomAnchor, multiplier: 3),
            doneViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneViewButton.widthAnchor.constraint(equalToConstant: 100),
            doneViewButton.heightAnchor.constraint(equalToConstant: 36),

            catViewButton.topAnchor.constraint(equalToSystemSpacingBelow: doneViewButton.bottomAnchor, multiplier: 3),
            catViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            catViewButton.widthAnchor.constraint(equalToConstant: 100),
            catViewButton.heightAnchor.constraint(equalToConstant: 36),

        ])
    }

    @objc private func taskButtonTapped() {
        navigationController?.pushViewController(TaskViewController(), animated: true)
    }

    @objc private func doneButtonTapped() {
        navigationController?.pushViewController(DoneViewController(), animated: false)
    }

    @objc private func catButtonTapped() {
        navigationController?.pushViewController(CatViewController(), animated: false)
    }
}
