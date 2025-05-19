//
//  CustomModalViewController.swift
//  SportsApp
//
//  Created by MacBook on 17/05/2025.
//

import UIKit

class CustomModalViewController: UIViewController {
    
    // MARK: - Views
    private lazy var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ronaldo")
        return imageView
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
    private lazy var tableContentVC: TeamDetailsViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(
            withIdentifier: "TeamDetailsViewController"
        ) as! TeamDetailsViewController
        return vc
    }()
    
    // MARK: - Layout Properties
    private let defaultHeight: CGFloat = 500
    private let dismissibleHeight: CGFloat = 200
    private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    private var currentContainerHeight: CGFloat = 500
    private var containerViewHeightConstraint: NSLayoutConstraint?
    private var containerViewBottomConstraint: NSLayoutConstraint?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    // MARK: - Setup
    private func setupViews() {
        view.backgroundColor = .clear
        
        // Dimmed View
        view.addSubview(dimmedView)
        
        // Container View
        view.addSubview(containerView)
        
        // Header Image
        containerView.addSubview(headerImageView)
        
        // Table Content
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
        
        // Header Image Constraints
        NSLayoutConstraint.activate([
            headerImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headerImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            headerImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.3)
        ])
        
        // Table Content Constraints
        tableContentVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableContentVC.view.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 20),
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
            if newHeight < dismissibleHeight {
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
