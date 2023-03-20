// Copyright (C) 2023 Amrit Bhogal
//
// This file is part of Tower Fefence Game
//
// pogn is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// pogn is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with pogn.  If not, see <http://www.gnu.org/licenses/>.

// #include <SDL.h>

#include "common.h"
#import "EntityManager.h"

@interface SayHelloComponent : OFObject<IComponent>

+ (instancetype)component;

@end

@implementation SayHelloComponent

+ (instancetype)component
{ return [[self alloc] init]; }

- (void)startWithEntity: (Entity *)entity
{
    puts("Hello");
}

@end


int main(int argc, const char *argv[])
{
    auto entityManager = [EntityManager sharedInstance];
    auto entity = [Entity entityWithIdentifier: @"Hello"];
    [entity addComponent: [SayHelloComponent component]];

//     SDL_Init(SDL_INIT_EVERYTHING);
//     auto wind = SDL_CreateWindow("Tower Defence Game", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, 800, 600, SDL_WINDOW_SHOWN);


//     SDL_Event event;
//     while (true) {
//         while (SDL_PollEvent(&event)) {
//             switch (event.type) {
//                 case SDL_QUIT:
//                     goto end;
//             }
//         }

//     }

// end:
//     SDL_Quit();
//     return 0;
}
