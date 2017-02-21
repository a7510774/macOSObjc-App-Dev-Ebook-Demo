//
//  DBModel.h
//  Database
//
//  Created by javaliker on 15/9/9.
//  Copyright (c) 2015年 javaliker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBModel : NSObject
- (id)initWithDictionary:(NSDictionary *)dictionary;

/*save new model object*/
- (BOOL)save;

/*save updated model object*/
- (BOOL)update;

/*delete current model object*/
- (BOOL)delete;
@end
