#!/bin/bash
#start a django project.
# 2011年 10月 22日 星期六 19:41:19 CST
#by ghh.
function usage()
{
	echo "Usage:$0 porject-name(注意使用方法：$0 项目名称)"
}

function do_it() 
{
	home_dir="/home/ghh"
	svn_dir=$home_dir/svn-repos/$1
	svn_co_dir=$home_dir/$1
	svnadmin create $svn_dir
	cp $home_dir/svn-repos/bash/hooks/post-commit $svn_dir/hooks/
	cp $home_dir/svn-repos/bash/hooks/post-revprop-change $svn_dir/hooks/
	svn co file://$svn_dir $svn_co_dir
#	touch $svn_co_dir/start.ok
#	echo "start-ok now!" > $svn_co_dir/start.ok
#	date >> $svn_co_dir/start.ok
	cd $svn_co_dir
	echo "enter the project directory:$svn_co_dir"
	echo -e "you shoud do:\r\n1)add the repos in the trac \r\n2)run the trac-admin repos? resync $1"
	echo "now start a new django project. "
	django-admin.py startproject $1
	svn ci
}

# for test
function del_it() 
{	
	w_dir="/home/ghh"
	echo "removeing directory $w_dir/$1"
	echo "removeing directory $w_dir/svn-repos/$1"
	rm -rf $w_dir/$1
	rm -rf $w_dir/svn-repos/$1
	echo "clean all!"
}

if [ $# -gt 0 ];then
	if getopts "d" opt ; then
		del_it $2
	elif [ 1 -eq $# ];then
		do_it $*
	fi
else usage
fi
