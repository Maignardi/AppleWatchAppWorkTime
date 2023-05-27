import SwiftUI

struct ContentView: View {
    @State private var arrivalTime: Date?
    @State private var isArrivalTimeVisible = true

    private var departureTime: Date? {
        guard let arrivalTime = arrivalTime else {
            return nil
        }
        let calendar = Calendar.current
        let endTime = calendar.date(byAdding: .hour, value: 9, to: arrivalTime)!
        return calendar.date(byAdding: .minute, value: 15, to: endTime)!
    }

    private var formattedDepartureTime: String {
        guard let departureTime = departureTime else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: departureTime)
    }

    var body: some View {
        ScrollView {
            VStack {
                Spacer()

                Text("Ponto")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center) // Centralizar o título

                VStack(alignment: .center) {
                    Text("Horário de Chegada:")
                        .font(.headline)
                        .padding(.top)

                    if let arrivalTime = arrivalTime {
                        Text(getTimeString(from: arrivalTime))
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                    } else {
                        Button(action: {
                            arrivalTime = Date()
                            isArrivalTimeVisible = false
                        }) {
                            Text("Registrar Chegada")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center) // Centralizar o VStack

                VStack(alignment: .center) {
                    Text("Horário de Saída:")
                        .font(.headline)
                        .padding(.top)

                    Text(formattedDepartureTime)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding()
                }
                .frame(maxWidth: .infinity, alignment: .center) // Centralizar o VStack

                Spacer()

                Button(action: {
                    resetArrivalTime()
                }) {
                    Text("Resetar")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding()
                }
                .frame(maxWidth: .infinity, alignment: .trailing) // Alinhar o botão à direita
                .padding(.trailing)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .alignmentGuide(.top) { $0[.bottom] }
        }
    }

    private func getTimeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    private func resetArrivalTime() {
        arrivalTime = nil
        isArrivalTimeVisible = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
