//
//  YandexApiServices.swift
//  MusicApp(final_project)
//
//  Created by yunus on 11.05.2025.
//

import Foundation

// MARK: - Перечисление для ошибок сети
enum NetworkError: Error {
    case badURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
    case unknownError
    case customError(String)
}

// MARK: - Сетевой сервис
class YandexApiServices {
    
    private let apiKey: String = "ios-advanced"
    private let baseURLString: String = "https://ios-advanced-backend.onrender.com"

    func fetchData<T: Decodable>(endpoint: String, parameters: [String: String]? = nil) async throws -> T {
        // 1. Формирование URL
        guard var urlComponents = URLComponents(string: baseURLString + endpoint) else {
            print("Ошибка: Неверный базовый URL или конечная точка: \(baseURLString + endpoint)")
            throw NetworkError.badURL
        }

        if let parameters = parameters {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        guard let url = urlComponents.url else {
            print("Ошибка: Не удалось создать URL из компонентов: \(urlComponents)")
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Добавление API-ключа в заголовок
         request.setValue(apiKey, forHTTPHeaderField: "X-API-Key") // Пример для кастомного заголовка
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("Выполняется запрос к URL: \(url.absoluteString)")
        print("Заголовки: \(request.allHTTPHeaderFields ?? [:])")

        // 3. Выполнение запроса с использованием async/await
        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            // 4. Проверка ответа
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Ошибка: Ответ не является HTTPURLResponse.")
                throw NetworkError.invalidResponse
            }
            
            print("Статус код ответа: \(httpResponse.statusCode)")
            // Вывод тела ответа для отладки (если нужно)
            // if let responseString = String(data: data, encoding: .utf8) {
            //     print("Тело ответа: \(responseString)")
            // }


            guard (200...299).contains(httpResponse.statusCode) else {
                // Попытка декодировать сообщение об ошибке от сервера, если оно есть
                if let errorDataString = String(data: data, encoding: .utf8) {
                     print("Ошибка сервера (статус \(httpResponse.statusCode)): \(errorDataString)")
                     throw NetworkError.customError("Ошибка сервера (статус \(httpResponse.statusCode)): \(errorDataString)")
                } else {
                    print("Ошибка сервера (статус \(httpResponse.statusCode))")
                    throw NetworkError.invalidResponse // или более специфичная ошибка
                }
            }

            // 5. Декодирование данных
            let decoder = JSONDecoder()
            // Настройте декодер при необходимости (например, strategy для дат)
            // decoder.dateDecodingStrategy = .iso8601
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            } catch let decodingError {
                print("Ошибка декодирования: \(decodingError)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Не удалось декодировать JSON: \(jsonString)")
                }
                throw NetworkError.decodingError(decodingError)
            }
            
        } catch let error as NetworkError {
            // Перебрасываем уже созданную NetworkError
            throw error
        } catch {
            // Другие ошибки (например, проблемы с сетью)
            print("Ошибка сетевого запроса: \(error)")
            throw NetworkError.requestFailed(error)
        }
    }
}
