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

#import "Entities/Entity.h"
#import "Components/IComponent.h"

OF_ASSUME_NONNULL_BEGIN

@interface EntityManager : OFObject {
    @private OFMutableDictionary<OFString *, Entity *> *_entities;
    @private OFMutableDictionary<OFString *, OFMutableArray<Entity *> *> *_entitiesWithTags;
    @private OFMutableDictionary<Class, OFMutableArray<Entity *> *> *_entitiesWithComponents;
}

+ (instancetype)sharedInstance;

- (void)addEntity: (Entity *)entity;
- (Entity *)getEntityWithIdentifier: (OFString *)identifier;
- (void)removeEntityWithIdentifier: (OFString *)identifier;
- (void)removeAllEntities;

- (OFArray<Entity *> *)getEntitiesWithComponent: (Class)class;
- (OFArray<Entity *> *)getEntitiesWithTag: (OFString *)tag;

- (void)update;

@end

OF_ASSUME_NONNULL_END
