# EquipMe

[![TravisCI Status][travis-master-badge]][travis-master-status]
[![MPL 2.0 License][mpl-badge]][mpl]
[![Latest GitHub release][ghreleasebadge]][ghrelease]

An AddOn for World of Warcraft that manages your equipment by letting you save them into sets to easily equip and switch between.

It's mostly meant for Classic WoW since retail WoW already has a built-in equipment manager. Nothing will stop it from being able to work in retail, but my efforts will be mostly focused on getting it to work in classic.

Inspired by existing equipment manager AddOns I decided to make my own since it seems none of the big ones are interested in supporting classic, and/or use a proprietary license that makes patching and contributions impossible.

EquipMe is Free/Libre and Open Source Software (FLOSS) from the start and welcomes any contributions from anyone wanting to improve it!

**This AddOn is currently in early experimental stages and as such won't have a lot of features to start out with. Below follows an outline of what is planned for the first public release (v1.0.0).**

## Features

Planned features for [v1.0.0][v1]:

 * Ability to save currently equipped items into a set (via slash command)
 * Ability to equip a previously saved set of items (via slash command)
 * Ability to quickly change individual pieces of gear from the character sheet (via pop-out menu)

Features planned for future versions, but with no set milestone/date yet:

 * A nice (or at least functional) GUI for managing saved sets.
 * Ability to ignore certain slots in a set, so they are not replaced when equipping said set.
 * An "equip these after combat" queue, for items that can't be swapped in combat.

To see the status of features or submit requests of new ones, visit the [issues page on the GitHub repo][issues].

## Bug reports

Please refrain from submitting bug reports as a comment on WowAce or CurseForge, as I can't easily manage them there. Submit any bug reports [on GitHub][issues].

If you submit a bug report as a comment, I will likely create a GitHub issue from it and link to it for any further information.

## Contributing

As mentioned, all contributions to EquipMe are welcome! Especially contributions in the form of graphic material like logos (I am terrible at graphic design).

Please make contributions by [submitting a PR][pr] to the GitHub repo.

## License

Copyright © 2019 by [Adam Hellberg][sharparam].

This Source Code Form is subject to the terms of the [Mozilla Public
License, v. 2.0][mpl]. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.

See the file [LICENSE][] for more details.

## External links

 * [WowAce][]
 * [CurseForge][]

[mpl]: https://mozilla.org/MPL/2.0/
[mpl-osi]: https://opensource.org/licenses/MPL-2.0
[mpl-badge]: https://img.shields.io/badge/license-MPL%202.0-blue.svg

[issues]: https://github.com/SharpWoW/EquipMe/issues
[pr]: https://github.com/SharpWoW/EquipMe/pulls
[license]: https://github.com/SharpWoW/EquipMe/blob/master/LICENSE
[v1]: https://github.com/SharpWoW/EquipMe/milestone/1

[sharparam]: https://github.com/Sharparam

[ghrelease]: https://github.com/SharpWoW/EquipMe/releases
[ghreleasebadge]: https://img.shields.io/github/release/SharpWoW/EquipMe.svg?logo=github

[travis-master-status]: https://travis-ci.com/SharpWoW/EquipMe
[travis-master-badge]: https://travis-ci.com/SharpWoW/EquipMe.svg?branch=master

[wowace]: https://www.wowace.com/projects/equipme
[curseforge]: https://www.curseforge.com/wow/addons/equipme
