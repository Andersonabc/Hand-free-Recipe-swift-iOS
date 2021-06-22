//
//  ImageLoader.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/20.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var dataIsFetched: Bool {
        get {
            return self.image != nil
        }
    }

    private let url: URL
    private var cancellable: AnyCancellable?
    private var cache: ImageCache?
    
    // thread safety for caching
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")

    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }

    func load() {
        if self.dataIsFetched {
            return
        }
        
        if let image = cache?[url] {
            self.image = image
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: Self.imageProcessingQueue)
            .map { UIImage(data: $0.data) }
            .retry(10)
            .replaceError(with: nil)
            .handleEvents(receiveOutput: { [weak self] in self?.cache($0) })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }

    private func cache(_ image: UIImage?) {
        image.map { cache?[url] = $0 }
    }

    private func cancel() {
        cancellable?.cancel()
    }
    
    deinit {
        self.cancel()
    }
}
