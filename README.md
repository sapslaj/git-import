# git-import

Just the files™<sup>[1](#footnote-1)</sup>

## Installation

`gem install git-import` if I ever get around to putting it up on Rubygems.

## Usage

`git import [options] <GIT URL> [<directory>]`

For simple usage:
`git import https://github.com/git/hello-world`


To initialize a repo after importing files:
`git import -i https://github.com/git/hello-world`

To import files to `.`:
`git import https://github.com/git/hello-world .`


## Footnotes
<a name="footnote-1">1</a>: Not actually trademarked to me. Plz don't sue.
