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

#include "EntityManager.h"

#import <ObjFW/OFInitializationFailedException.h>
#import <ObjFW/OFInvalidArgumentException.h>
#import <ObjFW/OFMutableArray.h>
#import <ObjFW/OFMutableDictionary.h>

static EntityManager *sharedInstance = nil;

@implementation EntityManager

+ (instancetype)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[self alloc] init];
    }

    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self == nil)
        @throw [OFInitializationFailedException exceptionWithClass: [self class]];

    _entities = [OFMutableDictionary dictionary];
    return self;
}

- (void)addEntity: (Entity *)entity
{
    [entity start];
    [_entities setObject: entity forKey: entity.identifier];
}

- (Entity *)getEntityWithIdentifier: (OFString *)identifier
{
    return [_entities objectForKey: identifier];
}

- (void)removeEntityWithIdentifier: (Entity *)entity
{
    [_entities removeObjectForKey: entity.identifier];
}

- (void)removeAllEntities
{
    [_entities removeAllObjects];
}

- (OFArray<Entity *> *)getEntitiesWithComponent: (Class)class
{
    OFMutableArray<Entity *> *entities = [OFMutableArray array];

    for (Entity *entity in _entities) {
        if ([entity componentCountOfClass: class] > 0)
            [entities addObject: entity];
    }

    return entities;
}

- (OFArray<Entity *> *)getEntitiesWithTag: (OFString *)tag
{
    OFMutableArray<Entity *> *entities = [OFMutableArray array];

    for (Entity *entity in _entities) {
        if ([entity hasTag: tag])
            [entities addObject: entity];
    }

    return entities;
}

- (void)update
{
    for (Entity *entity in _entities)
        [entity update];
}

@end
