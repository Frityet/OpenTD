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

#import <ObjFW/OFObject.h>
#import <ObjFW/OFString.h>

OF_ASSUME_NONNULL_BEGIN

@class Entity;

@protocol IComponent<OFObject>

- (void)startWithEntity:    (Entity *)entity;

@optional
- (void)updateWithEntity:   (Entity *)entity;

@end

OF_ASSUME_NONNULL_END
