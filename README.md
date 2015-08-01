# Make Repo

A simple set of scripts to convert a your source/artifacts into a repo and enable sharing. 
This avoid having to zip/xcopy your source to share.  Since it builds on git you can  work against
a respository that others on your team can also look at or contribute into. 
The `create` script is the bootstrapper and does 3 things 

1. Converts your artifacts to a local repository and commits them. 
2. Creates a remote repository on a share specified. 
3. Configures an origin and pushes your work and gives you a `git clone URL`. 

### Example

```
c:\git\makerepo\test
> \\localhost\C$\git\makerepo\tree\create maketest
Initialized empty Git repository in c:/git/makerepo/test/.git/
[master (root-commit) e7dab2d] Initial Commit for repo
 2 files changed, 218 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 clean.cmd
-------------- CREATED LOCAL REPO --------------
Going to initialize a git repo in \\localhost\C$\temp\sajaya\maketest.git
Initialized empty Git repository in //localhost/C$/temp/sajaya/maketest.git/
-------------- CREATED REMOTE REPO --------------
Configuring remote origin to //localhost/C$/temp/sajaya/maketest.git
Pushing changes to remote //localhost/C$/temp/sajaya/maketest.git
Counting objects: 4, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (4/4), 1.87 KiB | 0 bytes/s, done.
Total 4 (delta 0), reused 0 (delta 0)
To //localhost/C$/temp/sajaya/maketest.git
 * [new branch]      master -> master

------------- CLONE URL--------------
git clone //localhost/C$/temp/sajaya/maketest.git maketest
```

### Configuring the Root Share

The remote respositories are stored in some pre-configured share. The script looks for a 
`~$hareName.txt` in the script folder. This file is git ignored for convenince but will 
be prompted for if it hasn't been configured and if you specify just a name instead of a UNC
```
create testrepo
```
This will prompt for script creation.  