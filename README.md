<img src="https://cdn.rawgit.com/oh-my-fish/oh-my-fish/e4f1c2e0219a17e2c748b824004c8d0b38055c16/docs/logo.svg" align="left" width="144px" height="144px"/>

#### One
> A theme for [Oh My Fish](https://github.com/oh-my-fish/oh-my-fish).

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE)
[![Fish Shell Version](https://img.shields.io/badge/fish-v2.2.0-007EC7.svg?style=flat-square)](https://fishshell.com)
[![Oh My Fish Framework](https://img.shields.io/badge/Oh%20My%20Fish-Framework-007EC7.svg?style=flat-square)](https://www.github.com/oh-my-fish/oh-my-fish)

<br/>


## Install

```fish
$ omf install one
```

### Note for macOS users
If you're getting a `expr: syntax error` try expr from coreutils package.
If you're getting an `Array index out of bounds` error run `brew install --with-default-names gnu-sed`.

## Features

* Git ahead/behind indicator with number of commits
* Git status indicators (see below)
* Git branch info
* Abreviated working directory
* Node.js version indicator
* Current timestamp
* Display red **[!]** if previous command failed
* Superuser indicator **[⚡️]**

### Git status indication

* Green **◦** - repository is clean
* Gray • - repository has **untracked** files
* Orange • - repository has **renamed** files
* White • - repository has **copied** files
* Green • - repository has **added** files
* Blue • - repository has **updated but unmerged** files
* Purple • - repository has **modified** files


## Screenshot

<p align="center">
<img src="https://dl.dropboxusercontent.com/u/56422022/img/omf-theme-one.png">
</p>


Forked from [Toaster](https://github.com/oh-my-fish/theme-toaster)

# License

[MIT][mit] © [fivepointseven](http://github.com/fivepointseven)


[mit]:            https://opensource.org/licenses/MIT
[author]:         https://github.com/{{USER}}

[license-badge]:  https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square
