//
//  DetailViewController.swift
//  VASizeClassRefactor
//
//  Created by Vikash Anand on 22/05/19.
//  Copyright © 2019 VA. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    private lazy var detailView: DetailView? = {
        return DetailView().loadFromNib()
    }()
    
    override func loadView() {
        super.loadView()
        
        if let view = self.detailView {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                view.topAnchor.constraint(equalTo: self.view.topAnchor),
                view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
                ]
            )
        }
    }
    
    private let label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DetailViewController: PresentDetailViewOnSelectionProtocol {
    
    func tableView(_ tableView: UITableView, selectedString string: String) {
        let longString = "It’s commonly agreed that unit tests should be FIRST: Fast, Isolated, Repeatable, Self-verifying, and Timely. Sadly, networking code is never fast and frequently not repeatable, so if you’re writing tests that rely on networking it's fair to say that you’re not really writing unit tests at all.It’s possible and indeed common to write mocks for the network layer, substituting a mocked URLSession object for the real one using dependency injection, and that approach works well a lot of the time. However, if you can avoid mocking URLSession it’s usually a good idea to do so, not least because it’s easy to find yourself in a hole where you’re relying heavily on the way your mock works.In this article I’m going to show you a smart and simple alternative to network testing that lets you get fast, repeatable unit tests without having to subclass URLSession or wrap it in a protocol.Controlling network requestsApple designed URLSession to be highly extensible. When you make a request for some sort of data, internally it looks over a series of registered protocol handlers to find the right one to use. For example, if you request a site over HTTP/2, it will find the specific protocol handler for that and make it do the underlying work.Helpfully, these URL protocols all descend from a common abstract class called URLProtocol, and we can create our own custom subclass to handle network requests. We can then register that subclass with URLSession by setting its protocolClasses property, and it will take part in the standard system networking just like the built-in protocols.The best part of this is that it’s almost transparent: in your tests you configure a URLSession instance to use your custom protocol handler, then pass that to your test object to use. Internally, the test object doesn’t know or care that a custom protocol handler is being used – it just calls the URLSession directly as it normally would, and gets back data.Apple's official documentation says “the URLSession object searches the default protocols first and then checks your custom protocols until it finds one capable of handling the specified request.” However, that’s quite wrong as you’ll see – if you try requesting a web page using HTTPS you’ll get back the regular data, but if you inject your own protocol handler into the mix that will always get used instead.Subclassing URLProtocolCreating our own URL handler requires creating a subclass or URLProtocol and implementing four methods:The canInit() method is called to determine whether this handler can handle a specific kind of request. We’ll always return true from this, which means we want to handle all requests.The canonicalRequest() method is designed to convert a regular request into a canonical request. Apple’s documentation says “it is up to each concrete protocol implementation to define what canonical means,” so here we’re just going to return the original request because we don’t need anything specialThe startLoading() method will be called when we need to do our loading, and is where we’ll return some test data immediately.The stopLoading() method is required, but doesn’t need to do anything so we’ll just write an empty method.That’s the absolute minimum a URLProtocol subclass needs to do, but for our testing purposes we need to add one more thing: a static property that stores all the data we want to return for different URLs.You see, when startLoading() is called, we want to look up the URL that was requested and use that to figure out what test data to return. Using a dictionary allows test writers to program their expectations up front: when the user profile page is requested return this, but when the home page is requested return something else.Let’s put all that into code. Create a new Cocoa Touch class now, calling it “URLProtocolMock” and making it subclass URLProtocol. Technically what we’re creating is a stub rather than a mock because it’s returning fixed data, so if you want to be technically correct (the best kind of correct!) you can call it “URLProtocolStub” instead.Regardless of what you call it, when Xcode opens the file for editing give it this code:"
        self.detailView?.aLabel.text = string + " " + longString
    }
}
