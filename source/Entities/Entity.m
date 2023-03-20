// Copyright (C) 2023 Amrit Bhogal
//
// This file is part of TowerDefenceGame.
//
// TowerDefenceGame is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// TowerDefenceGame is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with TowerDefenceGame.  If not, see <http://www.gnu.org/licenses/>.

#include "Entities/Entity.h"

#import <ObjFW/OFInitializationFailedException.h>
#import <ObjFW/OFInvalidArgumentException.h>

@implementation Entity

- (instancetype)initWithIdentifier: (OFString *)identifier
{
    self = [super init];
    if (self == nil)
        @throw [OFInitializationFailedException exceptionWithClass: [self class]];

    _components = [OFMutableDictionary dictionary];
    _tags = [OFMutableArray array];
    _identifier = identifier;
    return self;
}

+ (instancetype)entityWithIdentifier: (OFString *)identifier
{
    return [[self alloc] initWithIdentifier: identifier];
}

- (void)addComponent: (id <IComponent>) component
{
    OFMutableArray <id <IComponent>> *components = _components[[component class]];

    if (components == nil) {
        components = [OFMutableArray array];
        [_components setObject: components forKey: [component class]];
    }

    [component startWithEntity: self];

    [components addObject: component];
}

- (size_t)componentCountOfClass: (Class) class
{
    OFMutableArray <id <IComponent>> *components = _components[class];

    if (components == nil)
        return 0;

    return components.count;
}

- (void)removeComponentsWithClass: (Class) class
{
    OFMutableArray <id <IComponent>> *components = _components[class];

    if (components == nil)
        return;

    [components removeAllObjects];
}

- (void)removeAllComponents
{
    [_components removeAllObjects];
}

- (OFArray<id<IComponent>> *)getComponentsWithClass: (Class) class
{
    OFMutableArray <id <IComponent>> *components = _components[class];

    if (components == nil)
        return nil;

    return components;
}

- (void)addTag: (OFString *) tag
{
    if ([_tags containsObject: tag])
        @throw [OFInvalidArgumentException exception];

    [_tags addObject: tag];
}

- (void)removeTag: (OFString *) tag
{
    if (![_tags containsObject: tag])
        @throw [OFInvalidArgumentException exception];

    [_tags removeObject: tag];
}

- (void)removeAllTags
{
    [_tags removeAllObjects];
}

- (bool)hasTag: (OFString *) tag
{
    return [_tags containsObject: tag];
}

- (void)start
{
    for (id <IComponent> component in _components)
        [component startWithEntity: self];
}

- (void)update
{
    for (id <IComponent> component in _components) {
        if ([component respondsToSelector: @selector(updateWithEntity:)])
            [component updateWithEntity: self];
    }
}

@end
