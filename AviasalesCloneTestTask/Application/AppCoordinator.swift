//
//  AppCoordinator.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 31.05.2024.
//

import Combine
import SwiftUI
import UIKit

enum AppTab {
    case tickets
    case hotels
    case shorter
    case subscriptions
    case profile

    var title: String {
        switch self {
        case .tickets:
            "Авиабилеты"
        case .hotels:
            "Отели"
        case .shorter:
            "Короче"
        case .subscriptions:
            "Подписки"
        case .profile:
            "Профиль"
        }
    }

    var icon: UIImage? {
        switch self {
        case .tickets:
            UIImage(named: "airplane")
        case .hotels:
            UIImage(named: "hotels")
        case .shorter:
            UIImage(named: "pin_icon")
        case .subscriptions:
            UIImage(systemName: "bell.fill")
        case .profile:
            UIImage(systemName: "person.fill")
        }
    }
}

class AppCoordinator {
    private var tabBarController: UITabBarController
    let sharedConcertsProvider = ConcertProvider()
    let ticketOfferProvider = TicketOffersProvider()
    let ticketListProvider = TicketListProvider()
    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
        tabBarController = UITabBarController()
    }

    func start() {
        let tabs: [(AppTab, UIViewController)] = [
            (.tickets, ticketsRootScreen()),
            (.hotels, emptyScreen()),
            (.shorter, emptyScreen()),
            (.subscriptions, emptyScreen()),
            (.profile, emptyScreen()),
        ]

        setupTabs(tabs: tabs)

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    private func updateFavoritesTabIcon(count: Int) {
        if let tabItems = tabBarController.tabBar.items {
            let favoritesTabIndex = 1
            if tabItems.indices.contains(favoritesTabIndex) {
                let item = tabItems[favoritesTabIndex]
                item.badgeValue = count > 0 ? "\(count)" : nil
            }
        }
    }

    private func setupTabs(tabs: [(tab: AppTab, viewController: UIViewController)]) {
        let viewControllers = tabs.map { tuple -> UIViewController in
            let navController = UINavigationController(rootViewController: tuple.viewController)
            navController.tabBarItem = UITabBarItem(title: tuple.tab.title, image: tuple.tab.icon, selectedImage: nil)
            return navController
        }

        tabBarController.setViewControllers(viewControllers, animated: false)
    }
    
    private func emptyScreen() -> UIViewController {
        let emptyController = UIHostingController(rootView: EmptyView())

        return emptyController
    }
    
    private func ticketsRootScreen() -> UIViewController {
        let ticketsViewModel = TicketsRootViewModel(
                concertProvider: self.sharedConcertsProvider
            )
        let ticketsView = TicketsRootView(viewModel: ticketsViewModel)
        let ticketsController = UIHostingController(rootView: ticketsView)
        
        ticketsViewModel.onAction = { [weak ticketsController, weak self] action in
            guard let self else { return }
            switch action {
            case let .arrivalTextfieldActivated(departure):
                ticketsController?.present(
                    destinationSearchScreen(
                        departure: departure,
                        onDifficultRouteChosen: {
                            ticketsController?.navigationController?.pushViewController(self.emptyScreen(), animated: true)
                        },
                        onArrivalChosen: { route in
                            ticketsController?.navigationController?.pushViewController(
                                self.ticketSearchScreen(route: route),
                                animated: true
                            )
                        },
                        onHolidaysChosen: {
                            ticketsController?.navigationController?.pushViewController(self.emptyScreen(), animated: true)
                        },
                        onHotTicketsChosen: {
                            ticketsController?.navigationController?.pushViewController(self.emptyScreen(), animated: true)
                        }
                    ),
                    animated: true,
                    completion: nil
                )
            case let .destinationChosen(route):
                ticketsController?.navigationController?.pushViewController(
                    ticketSearchScreen(route: route),
                    animated: true
                )
            }
        }

        return ticketsController
    }
    
    private func destinationSearchScreen(
        departure: String,
        onDifficultRouteChosen: @escaping () -> Void,
        onArrivalChosen: @escaping (Route) -> Void,
        onHolidaysChosen: @escaping () -> Void,
        onHotTicketsChosen: @escaping () -> Void
    ) -> UIViewController {
        let viewModel = DestinationSearchViewModel(
                departure: departure
            )
        let ticketSearchView = DestinationSearchView(viewModel: viewModel)
        let destinationSearchController = UIHostingController(rootView: ticketSearchView)
        
        viewModel.onAction = { [weak destinationSearchController] action in
            switch action {
            case .difficultRouteChosen:
                destinationSearchController?.dismiss(animated: true, completion: {
                    onDifficultRouteChosen()
                })
            case .holidaysChosen:
                destinationSearchController?.dismiss(animated: true, completion: {
                    onHolidaysChosen()
                })
            case .hotTicketsChosen:
                destinationSearchController?.dismiss(animated: true, completion: {
                    onHotTicketsChosen()
                })
            case let .destinationChosen(route):
                destinationSearchController?.dismiss(animated: true, completion: {
                    onArrivalChosen(route)
                })
            }
        }

        return destinationSearchController
    }
    
    private func ticketSearchScreen(route: Route) -> UIViewController {
        let viewModel = TicketSearchViewModel(route: route, ticketOffersProvider: ticketOfferProvider)
        let ticketSearchController = UIHostingController(rootView: TicketSearchView(viewModel: viewModel))
        ticketSearchController.navigationController?.navigationBar.isHidden = true
        
        viewModel.onAction = { [weak ticketSearchController, weak self] action in
            guard let self else { return }
            switch action {
            case .goBack:
                ticketSearchController?.navigationController?.popViewController(animated: true)
            case .goToTicketsList:
                ticketSearchController?.navigationController?.pushViewController(
                    ticketListScreen(route: viewModel.route),
                    animated: true
                )
            }
        }

        return ticketSearchController
    }
    
    private func ticketListScreen(route: Route) -> UIViewController {
        let viewModel = TicketListViewModel(route: route, ticketListProvider: ticketListProvider)
        let ticketListController = UIHostingController(rootView: TicketListView(viewModel: viewModel))
        ticketListController.navigationController?.navigationBar.isHidden = true
        
        viewModel.onAction = { [weak ticketListController] action in
            switch action {
            case .goBack:
                ticketListController?.navigationController?.popViewController(animated: true)
            }
        }

        return ticketListController
    }
}
