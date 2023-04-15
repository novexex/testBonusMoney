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

        // Добавление заголовка TOKEN
        request.addValue("123", forHTTPHeaderField: "TOKEN")

        // Установка тела запроса
        let bodyDict = ["offset": offset]
        let bodyData = try! JSONSerialization.data(withJSONObject: bodyDict)
        request.httpBody = bodyData

        // Выполнение запроса
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error, let response = response as? HTTPURLResponse {
                completion(nil, response.statusCode, error)
                print("Ошибка запроса: \(error.localizedDescription)")
                return
            }

            guard let data else {
                print("Данные не получены")
                return
            }

            // Обработка ответа сервера
            do {
                let response = try JSONDecoder().decode([Card].self, from: data)
                completion(response, nil, nil)
            } catch {
                print("Ошибка декодирования: \(error.localizedDescription)")
            }
        }
        task.resume()

    }
}
