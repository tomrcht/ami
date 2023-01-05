//
//  ShareViewController.swift
//  EMShare
//
//  Created by Tom Rochat on 22/12/2022.
//

import UIKit
import UniformTypeIdentifiers
import Social

final class CustomShareViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    private func setupView() {
        view.backgroundColor = .systemGray6

        navigationItem.title = "EasyMovie"

        let cancelButton = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelAction)
        )
        self.navigationItem.setLeftBarButton(cancelButton, animated: false)

        let shareButton = UIBarButtonItem(
            image: UIImage(systemName: "paperplane.fill"),
            style: .done,
            target: self,
            action: #selector(shareAction)
        )
        // UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(shareAction))
        self.navigationItem.setRightBarButton(shareButton, animated: false)
    }

    @objc
    private func cancelAction() {
        terminateContext()
    }

    @objc
    private func shareAction() {
        guard let selectedAsset = extensionContext?.inputItems.first else {
            terminateContext()
            return
        }

        guard let providers = (selectedAsset as? NSExtensionItem)?.attachments else {
            terminateContext()
            return
        }

        let identifier = UTType.movie.identifier
        for provider in providers where provider.hasItemConformingToTypeIdentifier(identifier) {
            provider.loadItem(forTypeIdentifier: identifier) { [unowned self] data, error in
                guard error == nil else {
                    terminateContext()
                    return
                }

                if let url = data as? URL {
                    print("got movie data at URL : \(url.relativeString)")
                    let defaults = UserDefaults(suiteName: "ami-extension")
                    defaults?.set(url.relativeString, forKey: "selected-asset")
                    extensionContext?.completeRequest(returningItems: nil)
                } else {
                    print("you aint got shit")
                    terminateContext()
                }
            }
        }
    }

    private func terminateContext() {
        let error = NSError(domain: "em-extension", code: 1)
        extensionContext?.cancelRequest(withError: error)
    }
}

@objc(CustomShareNavigationController)
final class CustomShareNavigationController: UINavigationController {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "<some custom design here>"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setViewControllers([CustomShareViewController()], animated: false)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    private func setupUI() {
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

//class ShareViewController: SLComposeServiceViewController {
//
//    override func isContentValid() -> Bool {
//        // Do validation of contentText and/or NSExtensionContext attachments here
//        return true
//    }
//
//    override func didSelectPost() {
//        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
//
//        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
//        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
//    }
//
//    override func configurationItems() -> [Any]! {
//        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
//        return []
//    }
//
//}
