//
//  CustomModalViewController.swift
//  SportsApp
//
//  Created by MacBook on 17/05/2025.
//

import UIKit
import Kingfisher

class CustomModalViewController: UIViewController {
    
    var sportId: Int?
    var teamId: Int?
    var teamLogo: String?
    var teamName: String?
    
    // MARK: - Views
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.kf.setImage(with: URL(string: teamLogo ?? "https://static.becharge.be/img/be/placeholder.png"),
                              placeholder: UIImage(named: "leaguePlaceholder"))
        return imageView
    }()
    
    private lazy var teamNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.text = teamName ?? "Liverpool"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Table Content
    private lazy var tableContentVC: PlayersViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(
            withIdentifier: "PlayersViewController"
        ) as! PlayersViewController
        
        vc.sportId = sportId
        vc.teamId = teamId
        
        return vc
    }()
    
    // MARK: - Layout Properties
    private var defaultHeight: CGFloat = 0
    private let dismissibleHeightPercentage: CGFloat = 0.3
    private var maximumContainerHeight: CGFloat {
        return view.bounds.height - 64
    }
    private var currentContainerHeight: CGFloat = 0
    private var containerViewHeightConstraint: NSLayoutConstraint?
    private var containerViewBottomConstraint: NSLayoutConstraint?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultHeight = view.bounds.height * 0.7
        currentContainerHeight = defaultHeight
        setupViews()
        setupConstraints()
        setupGestures()
        setupPanGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            if self.currentContainerHeight > self.maximumContainerHeight {
                self.animateContainerHeight(self.maximumContainerHeight)
            }
            self.currentContainerHeight = self.containerViewHeightConstraint?.constant ?? self.defaultHeight
        })
    }
    
    // MARK: - Setup
    private func setupViews() {
        view.backgroundColor = .clear
        
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        
        containerView.addSubview(headerView)
        headerView.addSubview(headerImageView)
        headerView.addSubview(teamNameLabel)
        
        addChild(tableContentVC)
        containerView.addSubview(tableContentVC.view)
        tableContentVC.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        // Dimmed View
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Container View
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Header View
        let headerHeightMultiplier = headerView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.4)
        headerHeightMultiplier.priority = .defaultHigh
        headerHeightMultiplier.isActive = true
        headerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150).isActive = true
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor)
        ])
        
        // Header Image
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 16),
            headerImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            headerImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            headerImageView.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.7)
        ])
        
        // Team Name Label
        NSLayoutConstraint.activate([
            teamNameLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 8),
            teamNameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            teamNameLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            teamNameLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])
        
        teamNameLabel.adjustsFontSizeToFitWidth = true
        teamNameLabel.minimumScaleFactor = 0.7
        teamNameLabel.numberOfLines = 1
        
        // Table Content
        tableContentVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableContentVC.view.topAnchor.constraint(equalTo: teamNameLabel.bottomAnchor, constant: 20),
            tableContentVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            tableContentVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableContentVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        // Dynamic Constraints
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    
    // MARK: - Gestures
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCloseAction))
        dimmedView.addGestureRecognizer(tapGesture)
    }
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    // MARK: - Pan Handler
    @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let isDraggingDown = translation.y > 0
        let newHeight = currentContainerHeight - translation.y
        
        switch gesture.state {
        case .changed:
            if newHeight < maximumContainerHeight {
                containerViewHeightConstraint?.constant = newHeight
                view.layoutIfNeeded()
            }
        case .ended:
            let dismissThreshold = currentContainerHeight * dismissibleHeightPercentage
            if newHeight < dismissThreshold {
                animateDismissView()
            }
            else if newHeight < defaultHeight {
                animateContainerHeight(defaultHeight)
            }
            else if newHeight < maximumContainerHeight && isDraggingDown {
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                animateContainerHeight(maximumContainerHeight)
            }
        default:
            break
        }
    }
    
    // MARK: - Animations
    private func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        }
        currentContainerHeight = height
    }
    
    private func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    private func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0.6
        }
    }
    
    @objc private func handleCloseAction() {
        animateDismissView()
    }
    
    private func animateDismissView() {
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            self.view.layoutIfNeeded()
        }
    }
}
