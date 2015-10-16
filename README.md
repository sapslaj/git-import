# git-import

### Just the files™<sup>[1](#footnote-1)</sup>

Import git repo files. But just the files. Not the repo information.

Made this to be used for importing boilerplate code and such, like my [webdev-with-rack](https://github.com/sapslaj/webdev-with-rack) BP

## Installation

This is not a production-ready thing. So don't use it. Unless you want to deal with errors everywhere.

### No, really. Installation

```sh
git clone https://github.com/sapslaj/git-import
cd git-import
rake install
```

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
