//
//  TicketSearchView.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 04.06.2024.
//

import SwiftUI

struct TicketSearchView: View {
    @StateObject var viewModel: TicketSearchViewModel
    @State private var isReturnDatePickerPresented = false
    @State private var isDepartureDatePickerPresented = false

    var body: some View {
        VStack(spacing: 15) {
            ticketSearchView
            chipsView
            ticketsListView
            allTicketsButton
            subscriptionView
            Spacer()
        }
        .background(Color.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarHidden(true)
        
    }
}

extension TicketSearchView {
    var ticketSearchView: some View {
        HStack(spacing: 16) {
            Button(action: {
                viewModel.onAction?(.goBack)
            }, label: {
                Image.local.arrowLeft
                    .foregroundStyle(.white)
            })
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    CyrillicTextField(
                        text: $viewModel.route.departure,
                        placeholder: "Откуда - Москва"
                    )
                    .frame(height: 21)

                    Button(
                        action: {
                            viewModel.swapRoute()
                        }, label: {
                            Image.local.arrows
                                .foregroundStyle(.white)
                        })
                }

                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.theme.grey4)

                HStack(spacing: 8) {
                    CyrillicTextField(
                        text: $viewModel.route.arrival,
                        placeholder: "Куда - Турция"
                    )
                    .frame(height: 21)

                    Button(
                        action: {
                            viewModel.route.arrival = ""
                        }, label: {
                            Image.local.close
                                .foregroundStyle(.white)
                        })
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.theme.grey3)
                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
        )
        .padding(.horizontal, 16)
        .padding(.top, 30)
    }
    
    var chipsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer(minLength: 16)
                returnTicketDate
                departureTicketDate
                passengersView
                filterView
            }
        }
    }
    var returnTicketDate: some View {
        Button(action: {
            isReturnDatePickerPresented.toggle()
        }) {
            HStack(
                spacing: viewModel.route.returnDate == nil ? 8 : 0
            ) {
                if viewModel.route.returnDate == nil {
                    Image.local.plus
                        .foregroundStyle(Color.theme.grey7)
                    Text("обратно")
                        .foregroundStyle(.white)
                        .font(.system(size: 14, weight: .medium))
                        .italic()
                } else {
                    Text(viewModel.formattedReturnDate)
                        .foregroundStyle(.white)
                        .font(.system(size: 14, weight: .medium))
                        .italic()
                    Text(", \(viewModel.formattedReturnDateWeek)")
                        .foregroundStyle(Color.theme.grey6)
                        .font(.system(size: 14, weight: .medium))
                        .italic()
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.theme.grey3)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            )
        }
        .sheet(isPresented: $isReturnDatePickerPresented) {
            VStack(alignment: .center) {
                DatePicker(
                    "",
                    selection: viewModel.returnDateBinding,
                    displayedComponents: .date
                )
                .datePickerStyle(WheelDatePickerStyle())
                .frame(height: 300)
                .padding(35)
            }
            .presentationDetents([.height(300)])
            .background(Color.theme.grey7.edgesIgnoringSafeArea(.all))
        }
    }

    var departureTicketDate: some View {
        Button(action: {
            isDepartureDatePickerPresented.toggle()
        }) {
            HStack(spacing: 0) {
                Text(viewModel.formattedDepartureDate)
                    .foregroundStyle(.white)
                    .font(.system(size: 14, weight: .medium))
                    .italic()
                Text(", \(viewModel.formattedDepartureDateWeek)")
                    .foregroundStyle(Color.theme.grey6)
                    .font(.system(size: 14, weight: .medium))
                    .italic()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.theme.grey3)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            )
        }
        .sheet(isPresented: $isDepartureDatePickerPresented) {
            VStack(alignment: .center) {
                DatePicker(
                    "",
                    selection: viewModel.departureDateBinding,
                    displayedComponents: .date
                )
                .datePickerStyle(WheelDatePickerStyle())
                .frame(height: 300)
                .padding(35)
            }
            .presentationDetents([.height(300)])
            .background(Color.theme.grey7.edgesIgnoringSafeArea(.all))
        }
    }
    
    var passengersView: some View {
        HStack(spacing: 8) {
            Image.local.profile
                .foregroundStyle(.white)
            Text("1,эконом")
                .foregroundStyle(.white)
                .font(.system(size: 14, weight: .medium))
                .italic()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 10)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.theme.grey3)
                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
        )
    }
    
    var filterView: some View {
        HStack(spacing: 8) {
            Image.local.filter
                .foregroundStyle(.white)
            Text("фильтры")
                .foregroundStyle(.white)
                .font(.system(size: 14, weight: .medium))
                .italic()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 10)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.theme.grey3)
                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
        )
    }
    
    var ticketsListView: some View {
        VStack {
            Text("Прямые рельсы")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.white)
                .font(.system(size: 20, weight: .semibold))
            ForEach(viewModel.ticketOffers) { ticket in
                ticketOfferView(
                    color: viewModel.ticketColor(for: ticket),
                    title: ticket.title,
                    timeList: ticket.time_range.joined(separator: "  "),
                    price: NumberFormatter.formatPrice(ticket.price.value))
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.theme.grey1)
                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
        )
        .padding(.horizontal, 16)
    }
    
    func ticketOfferView(
        color: Color,
        title: String,
        timeList: String,
        price: String
    ) -> some View {
        VStack {
            HStack(alignment: .top) {
                Circle()
                    .foregroundStyle(color)
                    .frame(width: 24, height: 24)
                VStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        Text(title)
                            .foregroundStyle(.white)
                            .font(.system(size: 15))
                            .italic()
                        Spacer()
                        Text("\(price) ₽")
                            .foregroundStyle(Color.theme.blue)
                            .font(.system(size: 15))
                            .italic()
                        Image.local.arrowRight
                    }
                    Text(timeList)
                        .foregroundStyle(.white)
                        .font(.system(size: 14))
                        .lineLimit(1)
                }
            }
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.theme.grey4)
        }
        .padding(.top, 8)
    }
    
    var allTicketsButton: some View {
        Button(action: {
            viewModel.onAction?(.goToTicketsList)
        }, label: {
            Text("Посмотреть все билеты")
                .foregroundStyle(.white)
                .italic()
                
        })
        .frame(maxWidth: .infinity)
        .padding(11)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.theme.blue)
        )
        .padding(.horizontal, 16)
    }
    
    var subscriptionView: some View {
        HStack {
            Image.local.bell
                .foregroundStyle(Color.theme.blue)
            Text("Подписка на цену")
                .foregroundStyle(.white)
                .font(.system(size: 16))
            Toggle(
                isOn: .constant(false),
                label: {
                    
                })
            
        }
        .padding(.vertical, 13)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.theme.grey2)
        )
        .padding(.horizontal, 16)
    }
}
