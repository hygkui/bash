# convert my local svn resposity to git 
# then send them to gitHub.

git svn clone file:///home/ghh/svn-repos/"$1" --no-metadata -A authors.txt  "$1"
cd "$1"
git config --global user.name "GuoHuanHuan"
git config --global user.email fevernova.life@gmail.com
git remote add origin git@github.com:GuoHuan/"$1".git
git push -u origin master 
cd ..
rm -rf "$1"
