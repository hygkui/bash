#!/bin/bash
mkdir ~/svn-repos
cd ~/dump/svn-dump
for file in `ls`
do
	echo $file
	echo ${file%%*.}
	echo ${file%%.*}
	svn_dir=${file%%.*}
	
	svnadmin create ~/svn-repos/$svn_dir
	svnadmin load ~/svn-repos/$svn_dir < $file
	
done

