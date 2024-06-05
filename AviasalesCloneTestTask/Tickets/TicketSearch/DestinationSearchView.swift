//
//  TicketSearchView.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 04.06.2024.
//

import SwiftUI

struct DestinationSearchView: View {
    @StateObject var viewModel: DestinationSearchViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            dragBarView
            ticketSearchView
            hintsView
            destinationsListView
            Spacer()
        }
        .background(Color("Grey2"))
    }
}

extension DestinationSearchView {
    var dragBarView: some View {
        RoundedRectangle(cornerRadius: 2)
            .frame(width: 38 ,height: 4)
            .foregroundStyle(Color("Grey6"))
            .padding(.top, 16)
    }
    var ticketSearchView: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Image(systemName: "airplane")
                        .foregroundStyle(Color("Grey6"))
                    CyrillicTextField(
                        text: $viewModel.departure,
                        placeholder: "Откуда - Москва"
                    )
                    .frame(height: 21)
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color("Grey4"))
                
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.white)
                    
                    CyrillicTextField(
                        text: $viewModel.arrival,
                        placeholder: "Куда - Турция"
                    )
                    .frame(height: 21)
                    
                    Button(
                        action: {
                            viewModel.arrival = ""
                        }, label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.white)
                    })
                }
                
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("Grey3"))
                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
        )
        .padding(.horizontal, 16)
        .padding(.top, 30)
    }
    
    var hintsView: some View {
        HStack(alignment: .top) {
            hintView(
                image: Image(systemName: "road.lanes.curved.right"),
                color: Color("Green"),
                title: "Сложный маршрут", 
                action: { viewModel.onAction?(.difficultRouteChosen) }
            )
            hintView(
                image: Image(systemName: "globe"),
                color: Color("Blue"),
                title: "Куда угодно", 
                action: { viewModel.arrival = "Куда угодно" }
            )
            hintView(
                image: Image(systemName: "calendar"),
                color: Color("Dark Blue"),
                title: "Выходные", 
                action: { viewModel.onAction?(.holidaysChosen) }
            )
            hintView(
                image: Image(systemName: "flame"),
                color: Color("Red"),
                title: "Горячие билеты", 
                action: { viewModel.onAction?(.hotTicketsChosen) }
            )
        }
        .padding(.top, 26)
    }
    
    func hintView(
        image: Image,
        color: Color,
        title: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: {
            action()
        }, label: {
            VStack(spacing: 8) {
                ZStack {
                   RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(color)
                        .frame(width: 50, height: 50)
                    
                    image
                        .foregroundStyle(.white)
                }
                Text(title)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14))
            }
            .frame(width: 90)
        })
    }
    
    var destinationsListView: some View {
        VStack {
            destinationView(
                image: Image("Стамбул"),
                destinationTitle: "Стамбул",
                destinationSubtitle: "Популярное направление"
            )
            destinationView(
                image: Image("Сочи"),
                destinationTitle: "Cочи",
                destinationSubtitle: "Популярное направление"
            )
            destinationView(
                image: Image("Пхукет"),
                destinationTitle: "Пхукет",
                destinationSubtitle: "Популярное направление"
            )
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("Grey3"))
        )
        .padding(.horizontal, 16)
        .padding(.top, 26)
    }
    
    func destinationView(
        image: Image,
        destinationTitle: String,
        destinationSubtitle: String
    ) -> some View {
        VStack {
            HStack {
                image
                VStack(alignment: .leading) {
                    Text(destinationTitle)
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .semibold))
                    Text(destinationSubtitle)
                        .foregroundStyle(Color("Grey5"))
                        .font(.system(size: 14))
                }
                Spacer()
            }
            Rectangle()
                .foregroundStyle(Color("Grey4"))
                .frame(height: 1)
        }
        
    }
}

#Preview {
    DestinationSearchView(viewModel: DestinationSearchViewModel(departure: "Москва"))
}
