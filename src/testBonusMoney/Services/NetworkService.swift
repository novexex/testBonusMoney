//
//  NetworkService.swift
//  testBonusMoney
//
//  Created by Artour Ilyasov on 15.04.2023.
//

import Foundation

class NetworkService {
    static func fetchCompanies(offset: Int, completion: @escaping ([Card]?, Int?, Error?) -> Void) {
        guard let url = URL(string: "http://dev.bonusmoney.pro/mobileapp/getAllCompanies") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        request.addValue("123", forHTTPHeaderField: "TOKEN")

        let bodyDict = ["offset": offset]
        let bodyData = try! JSONSerialization.data(withJSONObject: bodyDict)
        request.httpBody = bodyData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }

            do {
                guard let data else { return }
                let response = try JSONDecoder().decode([Card].self, from: data)
                completion(response, nil, nil)
            } catch {
                completion(nil, response.statusCode, error)
            }
        }
        task.resume()

    }
}
