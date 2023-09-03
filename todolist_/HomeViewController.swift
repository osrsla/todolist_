import UIKit

class HomeViewController: UIViewController {
    let imageView = UIImageView()
    var appTitleLabel = UILabel()
    let taskViewButton = UIButton()
    let doneViewButton = UIButton()
    let catViewButton = UIButton()

    // animation
    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgeOffScreen: CGFloat = -1000
    var appTitleLeadingAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupLayout()

        imageView.getImageFromURL(url: "https://spartacodingclub.kr/css/images/scc-og.jpg") { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            case .failure(let error):
                print("Error loading image: \(error)")
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
}

extension HomeViewController {
    private func setup() {
        navigationItem.title = "Home"

        view.addSubview(imageView)
        view.addSubview(appTitleLabel)
        view.addSubview(taskViewButton)
        view.addSubview(doneViewButton)
        view.addSubview(catViewButton)

        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit

        appTitleLabel.text = "MEMO🐈Cat"
        appTitleLabel.textAlignment = .center
        appTitleLabel.adjustsFontForContentSizeCategory = true
        appTitleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)

        taskViewButton.setTitle("Task", for: .normal)
        taskViewButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        taskViewButton.backgroundColor = UIColor.systemBlue
        taskViewButton.setTitleColor(UIColor.white, for: .normal)
        taskViewButton.layer.cornerRadius = 8
        taskViewButton.addTarget(self, action: #selector(taskButtonTapped), for: .touchUpInside)

        doneViewButton.setTitle("Done", for: .normal)
        doneViewButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        doneViewButton.backgroundColor = UIColor.systemBlue
        doneViewButton.setTitleColor(UIColor.white, for: .normal)
        doneViewButton.layer.cornerRadius = 8
        doneViewButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)

        catViewButton.setTitle("Cat", for: .normal)
        catViewButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        catViewButton.backgroundColor = UIColor.systemBlue
        catViewButton.setTitleColor(UIColor.white, for: .normal)
        catViewButton.layer.cornerRadius = 8
        catViewButton.addTarget(self, action: #selector(catButtonTapped), for: .touchUpInside)
    }

    private func setupLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        appTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        taskViewButton.translatesAutoresizingMaskIntoConstraints = false
        doneViewButton.translatesAutoresizingMaskIntoConstraints = false
        catViewButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 10),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 150),

            appTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 2),
            appTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            taskViewButton.topAnchor.constraint(equalToSystemSpacingBelow: appTitleLabel.bottomAnchor, multiplier: 3),
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

        appTitleLeadingAnchor = appTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        appTitleLeadingAnchor?.isActive = true
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

extension HomeViewController {
    private func animate() {
        let animator1 = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
            self.appTitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()
    }
}
