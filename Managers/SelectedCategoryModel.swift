//
//  SelectedCategoryModel.swift
//  Retos2
//
//  Created by MobileLab User on 5/26/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit

class SelectedCategoryModel: NSObject {
    
    private var CategorySelected: String = ""
    
    static let SharedInstance = SelectedCategoryModel()
    
    func setCategory(CategorySelected: String){
        self.CategorySelected = CategorySelected
    }
    
    func retrieveCategory() -> String{
        return self.CategorySelected
    }

}
