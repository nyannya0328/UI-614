//
//  Extensions.swift
//  UI-614
//
//  Created by nyannyan0328 on 2022/07/18.
//

import SwiftUI

extension View{
    
    @ViewBuilder
    func addSpotLight(_ id : Int,shape : SpotlightShape = .rectangle,roundRaidus : CGFloat = 0 ,title : String = "")->some View{
        
        self
            .anchorPreference(key : Boudskey.self ,value: .bounds) {[id : BoudsProperties(shape: shape, anchor: $0,title: title,radius: roundRaidus)]
                
            }
    }
    
    @ViewBuilder
    func addSpotlightOveray(show : Binding<Bool>,currentSpot : Binding<Int>) -> some View{
        
        self
            .overlayPreferenceValue(Boudskey.self) { value in
                
                GeometryReader{proxy in
                    
                    if let preference = value.first(where: { item in
                        
                        
                        item.key == currentSpot.wrappedValue
                    }){
                        
                        
                        let scrreSize = proxy.size
                        let anchor = proxy[preference.value.anchor]
                        
                        spotLightHelper(screenSize: scrreSize, rect: anchor, show: show, currentSpot: currentSpot, properties: preference.value) {
                            
                            
                            if currentSpot.wrappedValue <= (value.count){
                                
                                currentSpot.wrappedValue += 1
                                
                            }
                            else{
                                
                                show.wrappedValue = true
                            }
                            
                        }
                    }
                    
                }
                .ignoresSafeArea()
            }
        
    }
    
    @ViewBuilder
    func spotLightHelper(screenSize : CGSize,rect : CGRect,show : Binding<Bool>,currentSpot : Binding<Int>,properties : BoudsProperties,onTap : @escaping()->())->some View{
        
        Rectangle()
            .fill(.ultraThinMaterial)
            .environment(\.colorScheme, .dark)
            .overlay(alignment: .topLeading, content: {
                
                
                Text(properties.title)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .opacity(0)
                    .overlay {
                        
                        GeometryReader{proxy in
                            
                            let textSize = proxy.size
                            
                            
                            Text(properties.title)
                                .font(.title2.bold())
                                .foregroundColor(.white)
                                .offset(x:(rect.minX + textSize.width) > (screenSize.width - 15) ? -((rect.minX + textSize.width) - (screenSize.width - 15)) : 0)
                                .offset(y:(rect.maxY + textSize.height) > (screenSize.height - 50) ? -(textSize.height + (rect.maxY - rect.minY) + 30) : 30)
                                
                        }
                    }
                    .offset(x:rect.minX,y:rect.maxY)
                
                
            })
            .mask {
                
                Rectangle()
                    .overlay(alignment: .topLeading ,content: {
                        
                        let radius = properties.shape == .circle ? (rect.width / 2) : (properties.shape == .rectangle ? 0 : properties.radius)
                        
                        
                        RoundedRectangle(cornerRadius: radius,style: .continuous)
                        .frame(width: rect.width,height: rect.height)
                        .offset(x:rect.minX,y:rect.minY)
                        .blendMode(.destinationOut)
                        
                    })
                  
                
            }
            .onTapGesture{
                
                onTap()
            }
            
        
    }
    
}








enum SpotlightShape {
    
    case circle
    case rectangle
    case rounded
}

struct Boudskey : PreferenceKey{
    
    static var defaultValue: [Int : BoudsProperties] = [:]
    
    static func reduce(value: inout [Int : BoudsProperties], nextValue: () -> [Int : BoudsProperties]) {
        value.merge(nextValue()){$1}
    }
}

struct BoudsProperties{
    var shape : SpotlightShape
    var anchor : Anchor<CGRect>
    var title : String = ""
    var radius : CGFloat = 0
}

struct Extensions_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
