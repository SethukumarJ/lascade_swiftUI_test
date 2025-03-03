import SwiftUI

struct HomeScreen: View {
    @State private var selectedDate = Date()
    @State private var navigateToResults = false // Added for navigation
    @State private var navigateToLocationSelection = false
    @State private var isToogleTapped = true
    @State private var startDate = Date()
    @State private var endDate = Calendar.current.date(byAdding: .day, value: 2, to: Date())!
    @State private var showDatePicker = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Hidden NavigationLink for Navigation
                NavigationLink("", destination: FlightResultView(), isActive: $navigateToResults)
                NavigationLink("", destination: SelectLocationView(), isActive: $navigateToLocationSelection)
                VStack {
                    // Top Bar
                    HStack {
                        Image(systemName: "airplane")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                        
                        Text("Appname")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(.top, 50) // Increased padding for spacing from the notch
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10) // Adds more spacing before the card starts
                    
                    // Search Card
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 20) {
                            Text("Return")
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "#4E5DE4"))
                            
                            Text("One way")
                                .foregroundColor(.gray)
                            
                            Text("Multi city")
                                .foregroundColor(.gray)
                        }
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity) // Ensures it takes full width
                        .padding(.top, 10)
                        
                        Button(action: {
                            navigateToLocationSelection = true
                        }) {
                            FlightInfoRow(image: "airplane.departure", code: "COK", name: "KOCHI int.")
                            
                        }
                        
                        Button(action: {
                            navigateToLocationSelection = true
                        }) {
                            FlightInfoRow(image: "airplane.arrival", code: "CCN", name: "Kannur int.")
                            
                        }
                        
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(Color(hex: "#4E5DE4"))
                            Text("\(formattedDate(startDate)) - \(formattedDate(endDate))")
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .onTapGesture {
                            showDatePicker = true
                        }
                        HStack {
                            Image(systemName: "person.3.fill")
                                .foregroundColor(Color(hex: "#4E5DE4"))
                            Text("3 Passenger, Economy")
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        Button(action: {
                            navigateToResults = true
                        }) {
                            Text("Search Flight")
                                .frame(maxWidth: .infinity)
                                .padding(12)
                                .font(.title2)
                                .background(LinearGradient(gradient: Gradient(colors: [Color(red: 68/255, green: 93/255, blue: 228/255, opacity: 1.0), Color(red: 45/255, green: 57/255, blue: 171/255)]), startPoint: .leading, endPoint: .trailing))
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                        
                        HStack {
                            Image("flight-circle")
                                .resizable()
                                .frame(width: 23, height: 22)
                                .foregroundColor(.green)
                            Text("Show Only Eco Friendly Flights")
                                .font(.custom("CustomFontName", size: 12))
                                .foregroundColor(Color.gray)
                                .layoutPriority(1)
                            Spacer()
                            Toggle("", isOn: $isToogleTapped).tint(.blue).scaleEffect(0.8, anchor: .center)
                        }
                        
                        .padding(.top, 4)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(radius: 4)
                    .padding()
                    
                    VStack(spacing: 6) {
                        // Top Destinations Section
                        Text("Top Destinations")
                            .font(.title3)
                            .bold()
                            .padding(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                DestinationCard(imageName: "london", city: "London")
                                DestinationCard(imageName: "paris", city: "Paris")
                                DestinationCard(imageName: "london", city: "London")
                            }
                            .padding()
                        }
                    }
                    
                    Spacer()
                    
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                        .background(Color.white)
                    
                }
                
                .edgesIgnoringSafeArea(.top).background(LinearGradient(gradient: Gradient(colors: [Color(red: 91/255, green: 31/255, blue: 219/255, opacity: 1.0),Color.white, Color.white]), startPoint: .top, endPoint: .bottom))
            }
            .sheet(isPresented: $showDatePicker) {
                VStack {
                    DatePicker("Select Dates", selection: $startDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .tint(Color(hex: "#4E5DE4"))
                        .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        showDatePicker = false
                    }) {
                        Text("Done")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 68/255, green: 93/255, blue: 228/255, opacity: 1.0), Color(red: 45/255, green: 57/255, blue: 171/255)]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
                .presentationDetents([.medium])
            }
            
        }
        
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"
        return formatter.string(from: date)
    }
}


// Flight Info Row
struct FlightInfoRow: View {
    var image: String
    var code: String
    var name: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .foregroundColor(Color(hex: "#4E5DE4"))
            Text(code)
                .bold()
                .font(.title3)
                .foregroundColor(Color.black)
            
            Spacer()
            Text(name)
                .foregroundColor(.black).font(.caption2)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
    }
}

// Destination Card
struct DestinationCard: View {
    var imageName: String
    var city: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(width: 140, height: 120)
                .cornerRadius(10)
            Text(city)
                .font(.headline)
                .padding(.bottom, 10)
        }
        .frame(width: 140, height: 152)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

// Preview
struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

struct DateInputView: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var showStartPicker = false
    @State private var showEndPicker = false
    
    // Date Format
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy" // Example: "2 March 2025"
        return formatter
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(Color.blue)
                
                HStack(spacing: 5) {
                    // Start Date Field
                    Button(action: { showStartPicker.toggle() }) {
                        Text(dateFormatter.string(from: startDate))
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 140, height: 40)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                    
                    // End Date Field
                    Button(action: { showEndPicker.toggle() }) {
                        Text(dateFormatter.string(from: endDate))
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 140, height: 40)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            // Date Pickers (Hidden by default)
            
        }
        .padding()
    }
}
struct FlightResultView: View {
    var flights: [Flight] = [
        Flight(departureTime: "16:10", arrivalTime: "24:12", duration: "3h 10m", stops: "1 Stop", airline: "Spice Jet, Indigo Airways", price: "$120"),
        Flight(departureTime: "10:43", arrivalTime: "16:10", duration: "3h 10m", stops: "Direct", airline: "Indigo Airways", price: "$123"),
        Flight(departureTime: "16:20", arrivalTime: "20:10", duration: "3h 10m", stops: "1 Stop", airline: "Spice Jet, Indigo Airways", price: "$238"),
        Flight(departureTime: "16:10", arrivalTime: "24:12", duration: "3h 10m", stops: "1 Stop", airline: "Spice Jet, Indigo Airways", price: "$120"),
        Flight(departureTime: "10:43", arrivalTime: "16:10", duration: "3h 10m", stops: "Direct", airline: "Indigo Airways", price: "$123"),
        Flight(departureTime: "16:20", arrivalTime: "20:10", duration: "3h 10m", stops: "1 Stop", airline: "Spice Jet, Indigo Airways", price: "$238"),
        Flight(departureTime: "16:10", arrivalTime: "24:12", duration: "3h 10m", stops: "1 Stop", airline: "Spice Jet, Indigo Airways", price: "$120"),
        Flight(departureTime: "10:43", arrivalTime: "16:10", duration: "3h 10m", stops: "Direct", airline: "Indigo Airways", price: "$123"),
        Flight(departureTime: "16:20", arrivalTime: "20:10", duration: "3h 10m", stops: "1 Stop", airline: "Spice Jet, Indigo Airways", price: "$238")
    ]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24))
                        .padding(.trailing, 8)
                        .foregroundColor(.black)
                }
                Spacer()
                VStack(spacing: 4) {
                    Text("COK - CNN")
                        .font(.title2)
                        .bold()
                    HStack(spacing: 8) {
                        Text("12 Jun - 13 Sep")
                            .foregroundColor(.black.opacity(0.5))
                            .font(.system(size: 17))
                        Image(systemName: "circle.fill")
                            .font(.system(size: 8))
                            .foregroundColor(.black.opacity(0.5))
                            .font(.system(size: 16))
                        HStack(spacing: 6) {
                            Image(systemName: "person.fill")
                            Text("3, Economy")
                        }
                        .foregroundColor(.black.opacity(0.5))
                        .font(.system(size: 16))
                    }
                    
                }
                Spacer()
            }
            .padding()
            
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(flights) { flight in
                        FlightResultCard(flight: flight)
                    }
                }
                .padding().background(Color.black.opacity(0.05))
            }
        }
    }
}

struct FlightResultCard: View {
    var flight: Flight
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(flight.departureTime)
                        .font(.headline)
                    Text("COK")
                        .foregroundColor(.black.opacity(0.5))
                        .font(.system(size: 16))
                }
                
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 100, height: 1)
                        .mask(
                            HStack(spacing: 0) {
                                Rectangle()
                                Spacer().frame(width: 8)
                                Rectangle()
                            }
                        )
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 8, height: 8)
                }
                
                VStack {
                    Text(flight.arrivalTime)
                        .font(.headline)
                    Text("CNN")
                        .foregroundColor(.black.opacity(0.5))
                        .font(.system(size: 16))
                }
                Spacer()
                VStack {
                    Text(flight.duration)
                        .bold()
                        .foregroundColor(Color.black)
                    Spacer()
                    Text(flight.stops)
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.5))
                }
            }
            .padding(.horizontal)
            
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 1)
                .frame(maxWidth: .infinity)
            
            HStack {
                Image("ic-jet")
                    .foregroundColor(Color(hex: "#134E99"))
                    .offset(x: -6, y: -6)
                    .overlay {
                        Image("ic-flight-dot")
                    }
                Text(flight.airline)
                    .font(.subheadline)
                    .foregroundColor(Color.black.opacity(0.6))
                Spacer()
                Text(flight.price)
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color(hex: "#134E99"))
            }
            .padding(.top, 5)
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(.white)
        .cornerRadius(15)
        .navigationBarBackButtonHidden(true)
    }
}

struct Flight: Identifiable {
    var id = UUID()
    var departureTime: String
    var arrivalTime: String
    var duration: String
    var stops: String
    var airline: String
    var price: String
}

struct Airport: Identifiable {
    let id = UUID()
    let code: String
    let city: String
    let country: String
}

struct SelectLocationView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText: String = ""
    @State private var isSelected = false
    
    let airports = [
        Airport(code: "LON", city: "England", country: "United Kingdom"),
        Airport(code: "COK", city: "Cochin", country: "India"),
        Airport(code: "JFK", city: "New York", country: "United States"),
        Airport(code: "DXB", city: "Dubai", country: "UAE")
    ]
    
    var filteredAirports: [Airport] {
        if searchText.isEmpty {
            return airports
        } else {
            return airports.filter { $0.city.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        VStack {
            // Top Navigation Bar
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24))
                        .padding(.trailing, 8)
                        .foregroundColor(.black)
                }
                
                Text("Select locations")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            .padding()
            
            // Search Fields
            VStack(spacing: 10) {
                HStack {
                    // Airplane Icon
                    Image(systemName: "airplane.departure")
                        .foregroundColor(Color(hex: "#4E5DE4"))
                    
                    // Search Field
                    ZStack(alignment: .leading) {
                        TextField("", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .opacity(0)
                        
                        Text(searchText.isEmpty ? "Calicut Int." : searchText)
                            .foregroundColor(.black.opacity(!isSelected ? 1 : 0.5))
                            .padding(.vertical, 12)
                    }
                    .disabled(true)  // Keeps the field disabled
                    
                    
                    // Clear Button
                    Button(action: {
                        searchText = ""
                    }) {
                        if !isSelected {
                            Image(systemName: "xmark")
                                .frame(width: 12, height: 12)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.horizontal, 12)
                .frame(height: 50)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(isSelected ? Color.clear : Color(hex: "#4E5DE4"), lineWidth: 1)
                    
                )
                .padding(.horizontal)
                .onTapGesture {
                    isSelected.toggle()
                }
                
                HStack {
                    // Airplane Icon
                    Image(systemName: "airplane.departure")
                        .foregroundColor(Color(hex: "#4E5DE4"))
                    
                    ZStack(alignment: .leading) {
                        TextField("", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .opacity(0)
                        
                        Text(searchText.isEmpty ? "Enter a location or Airport" : searchText)
                            .foregroundColor(.black.opacity(isSelected ? 1 : 0.5))
                            .padding(.vertical, 12)
                    }
                    .disabled(true)
                    
                    // Clear Button
                    Button(action: {
                        searchText = ""
                    }) {
                        if isSelected {
                            Image(systemName: "xmark")
                                .frame(width: 12, height: 12)
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
                .padding(.horizontal, 12)
                .frame(height: 50)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(!isSelected ? Color.clear : Color(hex: "#4E5DE4"), lineWidth: 1)
                )
                .padding(.horizontal)
                .padding(.bottom, 15)
                .onTapGesture {
                    isSelected.toggle()
                }
                // Use Current Location Button
                Button(action: {
                    print("Using current location")
                }) {
                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.green)
                        Text("Use Current Location")
                            .foregroundColor(.green)
                            .bold()
                    }
                    .padding(.horizontal, 12)
                    .padding(10)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(40)
                    
                }
                .padding(.horizontal)
            }
            .padding(.top)
            
            // Airport List
            List(filteredAirports) { airport in
                HStack {
                    Text(airport.code)
                        .font(.system(size: 18))
                        .foregroundColor(Color(hex: "#4E5DE4"))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 10)
                        .background(Color(hex: "#4E5DE4").opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(hex: "#4E5DE4"), lineWidth: 1)
                        )
                        .cornerRadius(15)
                    
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(airport.city), \(airport.country)")
                            .font(.system(size: 18))
                        Text("\(airport.city), \(airport.country)")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 5)
                    Spacer()
                }
                
                .padding(.vertical, 4)
            }
            .listStyle(PlainListStyle())
        }
        .navigationBarHidden(true)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: Double
        r = Double((int >> 16) & 0xFF) / 255.0
        g = Double((int >> 8) & 0xFF) / 255.0
        b = Double(int & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}


// Dummy Profile Screen with User Info
struct ProfileView: View {
    var body: some View {
        VStack(spacing: 20) {
            
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            
            
            Text("John Doe")
                .font(.title)
                .bold()
            
            Text("johndoe@example.com")
                .foregroundColor(.gray)
            
            
            List {
                Section(header: Text("Settings")) {
                    HStack {
                        Image(systemName: "gear")
                        Text("Account Settings")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Image(systemName: "bell")
                        Text("Notifications")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                
                Section(header: Text("Support")) {
                    HStack {
                        Image(systemName: "questionmark.circle")
                        Text("Help & Support")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Image(systemName: "arrow.right.square")
                            .foregroundColor(.red)
                        Text("Logout")
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
            }
        }
        .padding(.top, 40)
    }
}
