#!/bin/bash
#start a django project.
# 2011年 10月 22日 星期六 19:41:19 CST
#by ghh.
function usage()
{
	echo -e "Usage:\r\n1)$0 porject-name(启动django项目)\r\n2)$0 -d project_name(清理新创建的项目)"
}

function do_it() 
{
	home_dir="/home/ghh"
	svn_dir=$home_dir/svn-repos/$1
	svn_co_dir=$home_dir/$1
	trac_dir="/var/www/trac"
	svnadmin create $svn_dir
	cp $home_dir/svn-repos/bash/hooks/post-commit $svn_dir/hooks/
	cp $home_dir/svn-repos/bash/hooks/post-revprop-change $svn_dir/hooks/
	svn co file://$svn_dir $svn_co_dir
#	touch $svn_co_dir/start.ok
#	echo "start-ok now!" > $svn_co_dir/start.ok
#	date >> $svn_co_dir/start.ok
	cd $svn_co_dir
	echo "enter the project directory:$svn_co_dir"
	echo -e "you shoud do:\r\n1)add the repos in the trac"
	echo -e "2)trac-admin $trac_dir repository resync $1"
	echo "now start a new django project. "
	django-admin.py startproject $1
	svn add $1
	cd $1
	chmod +x manage.py 
	python manage.py validate 
	svn ci -m "start the project $1 now."
	cd $home_dir
	./trac.run
	firefox "http://127.0.0.1:8001/trac/"
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

if [ $# -gt 0 ] ; then
	if getopts "d" opt ; then
		del_it $2
	elif [ 1 -eq $# ] ; then
		do_it $*
	fi
else usage
fi
