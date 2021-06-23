//
//  AspectVGrid.swift
//  SwiftAppPractice
//
//  Created by Leeann Warren on 6/23/21.
//

import SwiftUI

struct AspectVGrid<inBoundItem, iBTView>: View where iBTView: View, inBoundItem: Identifiable{ // where iBTView acts/behaves like a View
    // creating the information variables/constants for this view
    var items: [inBoundItem]
    var aspectRatio: CGFloat
    var content: (inBoundItem) -> iBTView // content is a function that takes in iBT and returns a view in the form of iBTView
    
    init(items: [inBoundItem], aspectRatio: CGFloat, @ViewBuilder content: @escaping (inBoundItem) -> iBTView){
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }// end init -- content is a passing function so @escaping helps to keep/hold this value found there AKA a pointer to 'content'
    
    var body: some View {
        GeometryReader{geometry in
            VStack{
            let width: CGFloat = customFit(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio) // width is 'adaptive'
            LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0){
                ForEach(items){item in
                    content(item).aspectRatio(aspectRatio, contentMode: .fit)
                } // end foreach -- for each content item, fit
            } // end lazyVGrid --
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            } // end vStack -- gives more flexibility space to the code
        } // end Geometry Reader
    } // end body
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0;
        return gridItem
    } // end adaptiveGridItem -- manually remove the gridItem spacing then return it
    
    private func customFit(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        
        repeat{
            let itemWidth = size.width / CGFloat(columnCount) // itemWidth is the size divided by the total columns
            let itemHeight = itemWidth / itemAspectRatio // itemHeigh is the itemWidth divided by the item's aspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            } // end if statement -- if there isnt enough space, break
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount // rowCount is the
        }while columnCount < itemCount // end while-repeat
        if columnCount > itemCount {
            columnCount = itemCount
        } // end if statement --
        return floor(size.width / CGFloat(columnCount)) // returns the rounded down math expression
    }// end customFit -- adjusts the width of the view shapes by how many are on the app
    
} // end AspectVGrid

