# Link all dotfiles to ~/

# List all files | ignore this script | ignore directories | ln each file
ls -1 -A -p | grep -v `basename $0` | grep -v / | xargs -I {} ln {} ~/{}
