#!/bin/bash


echo "`date`: Copy and compress repositories tree"

#mkdir -p repos

# Keep a copy of the repositories as plain tree and one compressed
if [ -d "repos.1" ]; then
	# Uncomment the next line to have also a second compressed version of the repositories
	# tar -czvf repos.2.tar.gz repos.1
	
	rm -rf repos.1
fi
cp -r repos repos.1

echo "`date`: Start mirroring"

while read repo; do
	repo_array=($repo)
	name=${repo_array[0]}
	url=${repo_array[1]}
	echo "`date`: Getting $name at $url"
	if [ -d "repos/$name" ]; then
		# Update the repo
		git -C repos/$name fetch -q --tags
		ret=$?
		if [ $ret -ne 0 ]; then
			echo "Error while pulling the repository. Backup and clone again!"
			mkdir -p repos/backups
			archive="${name/\//_}"    
			tar -czvf repos/backups/$archive.tar.gz repos/$name
			echo "Created a backup archive: repos/backups/$archive.tar.gz"
			rm -rf repos/$name

			mkdir -p repos/$name
			echo git clone --mirror $url repos/$name
			git clone --mirror $url repos/$name
		fi
	else
		mkdir -p repos/$name
		echo git clone --mirror $url repos/$name
		git clone --mirror $url repos/$name
	fi
done <repos/repos.list

echo "`date` Mirroring finished."
