//
//  KGCellDescription.m
//  
//
//  Created by Olexa Boyko on 5/10/17.
//  Copyright © 2017 Olexa Boyko. All rights reserved.
//

#import "KGCellDescription.h"

@implementation KGCellDescription

CDSelectionType _selectionType = CDSelectionTypeNone;

+ (NSString*) nibName {
    [NSException raise:@"Override nibName!" format:@"Override nibName!"];
    return nil;
}

+ (NSString*) reuseIdentifier {
    [NSException raise:@"Override reuseIdentifier!" format:@"Override reuseIdentifier!"];
    return nil;
}

- (NSString*) reuseIdentifier {
    return [[self class] reuseIdentifier];
}

- (instancetype)initWithSelectionType:(CDSelectionType)selectionType
{
    self = [super init];
    if (self) {
        _selectionType = selectionType;
        _height = 44.0;
    }
    return self;
}

+ (void)registerCellFor:(UITableView*)tableView {
    [tableView registerNib:[UINib nibWithNibName:[self nibName] bundle:nil] forCellReuseIdentifier:[self reuseIdentifier]];
}

- (void)setUpCell:(UITableViewCell* )cell {}

- (UITableViewCell* )instantiateCellForTableView:(UITableView *)tableView {
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[self reuseIdentifier]];
    
    if(!cell) {
        [NSException raise:@"Trying instantiate not registered cell." format:@"Reuse identifier: %@", [self reuseIdentifier]];
        return nil;
    }
    
    switch (_selectionType) {
        case CDSelectionTypeNone:
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
        case CDSelectionTypeCommon:
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case CDSelectionTypeExtendable:
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
    }
    
    [self setUpCell:cell];
    
    return cell;    
}

@end
