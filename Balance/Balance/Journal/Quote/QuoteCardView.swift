//
//  QuoteCardView.swift
//  Balance
//
//  Created by Yanika Telus on 10/26/23.
//

import SwiftUI

struct QuoteCardView: View {
    
    @State private var quote: QuoteModel?
    @State private var errorMessage: String?
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "quote.opening")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)

                if let tags = quote?.tags{
                    ForEach(tags, id: \.self){ tag in
                        Text(tag)
                            .padding(5)
                            .background(.white.opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .font(.caption)
                    }
                }
            }
            .padding(.vertical, 4)
            
            Text(quote?.content ?? "Fetching a quote..., Please make sure you are connected to the internet to get a quote")
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack{
                Text(quote?.author ?? "Author")
                    .italic()
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                Button(action: {
                    //save to core data\
                }, label: {
                    Image(systemName: "heart")
                        .padding(8)
                        .background(.purple.opacity(0.84))
                        .foregroundColor(.white)
                        .clipShape(.rect(cornerRadius: 8))
                })
            }
            .padding(.vertical, 4)
        }//VStack
        .task{
            await fetchAndHandleQuote()
        }
        .foregroundColor(.black)
        .padding()
        .background(.purple.opacity(0.5))
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 10)
    }//Body
    
    private func fetchAndHandleQuote() async {
        do {
            let quoteService = QuoteAPIModel()
            let fetchedQuote = try await quoteService.getQuote()
            self.quote = fetchedQuote
        } catch {
            errorMessage = "Failed to fetch quote: \(error.localizedDescription)"
        }
    }//func: fetchAndHandleQuote
}

#Preview {
    QuoteCardView()
}
