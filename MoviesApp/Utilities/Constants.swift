//
//  Constants.swift
//  MoviesApp
//
//  Created by Ramiro Gutierrez on 13/07/24.
//

import Foundation

enum AppMessages: String {
    case onboardingMessageOne = "¡Bienvenido a MoviesApp!"
    case onboardingMessageTwo = "Descubre las últimas películas y los clásicos de siempre en un solo lugar."
    case onboardingMessageThree = "Guarda y organiza tus películas favoritas en listas personalizadas."
}

enum AlertTitles: String {
    case addFavorite = "Añadir a Favoritos"
    case deleteFavorite = "Eliminar de Favoritos"
    case internetConnectionFailed = "Sin conexión a Internet"
}

enum AlertsMessage: String {
    case addFavorite = "¿Estás seguro que deseas añadir este show a tus favoritos?"
    case deleteFavorite = "¿Estás seguro que deseas eliminar este show de tus favoritos?"
    case internetConnection = "Ocurrió un error al consultar el servicio. ¿Quieres intentar nuevamente?"
}
enum TitleButton: String {
    case retry = "Reintentar"
}

enum EmptyMessage: String {
    case emptyFavorite = "Aún no has agregado ningún show a tus favoritos."
}
