sudo pdbedit -L
echo -n "delete user:<SPECIFIC USER> (y/N): "
read INPUT
case $INPUT in
    y|yes)
        sudo pdbedit -x <SPECIFIC USER>
esac

echo -n "exit (y/N): "
read INPUT
case $INPUT in
    y|yes)
        exit
esac

echo -n "Admin username: "
while read ADMINUSER
do
    sudo pdbedit -a "$ADMINUSER"
    break
done
exit