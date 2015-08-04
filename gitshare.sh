gitshare () {
	if [ -z "$1" ]; then
		echo "please give a name to the repo!"
		echo "> gitshare [name]"
		return
	fi
	read -p 'Are you sure you would like to upload everything in '$(pwd) -n 1 -r
	echo    # (optional) move to a new line
	if [[ ! $REPLY =~ ^[Yy]$ ]]
	then
	    return
	fi
	if [[ $(git init) != *"Reinitialized" ]]; then #if it's already a git repo, dont do anything 
		git add -A
		git commit -am "sharing"
	fi
	repo='//aaptperffs/repos/'$(id -u -n)'/'$1
	pushd //aaptperffs/repos > /dev/null
	mkdir -p $(id -u -n)'/'$1'/.git'
	popd > /dev/null
	cp -r .git $repo
	cp -r ./* $repo
	echo 'share this URL for others to clone!'
	echo 'file://'$repo
}