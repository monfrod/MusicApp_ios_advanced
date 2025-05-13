//
//  ResourceLoaderDelegate.swift
//  MusicApp(final_project)
//
//  Created by yunus on 13.05.2025.
//


import AVFoundation

class ResourceLoaderDelegate: NSObject, AVAssetResourceLoaderDelegate {
    let apiKey: String
    let value: String

    init(apiKey: String, value: String) {
        self.apiKey = apiKey
        self.value = value
    }

    func resourceLoader(_ resourceLoader: AVAssetResourceLoader, shouldWaitForLoadingOfRequestedResource loadingRequest: AVAssetResourceLoadingRequest) -> Bool {
        guard let url = loadingRequest.request.url else { return false }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: value)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let response = response else {
                loadingRequest.finishLoading(with: error)
                return
            }

            loadingRequest.dataRequest?.respond(with: data)
            loadingRequest.response = response
            loadingRequest.finishLoading()
        }
        task.resume()

        return true
    }
}
