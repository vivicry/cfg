function cfg --wraps='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME' --description 'alias cfg /usr/bin/git --git-dir=/home/viv/.cfg/ --work-tree=/home/viv'
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $argv
end
