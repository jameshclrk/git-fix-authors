# WARNING: This is destructive and there is no checking.

Use at your own risk.

## Prerequisites
 - [shyaml](https://github.com/0k/shyaml)

## Usage
 - Clone target repo with "git clone --bare https://github.com/user/other-repo.git"
 - Clone this repo
 - Copy authors.yml.example to target repo as authors.yml
 - Edit authors.yml in target repo, with details of authors that need fixing
 - Run fix-authors.sh inside target repo
 - Hope it worked

## Example
```bash
$ git clone --bare https://github.com/user/other-repo.git
$ git clone https://github.com/jameshclrk/git-fix-authors.git
$ cd other-repo.git
$ cp ../git-fix-authors/authors.yml.example ./authors.yml
$ vim authors.yml
$ ../git-fix-authors/fix-authors.sh
```

