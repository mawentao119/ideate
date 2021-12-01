
if [ -z $IDEATE_DIR ];then
    echo "==== ERROR : Please set \$IDEATE_DIR env variable ===="
else
    export PATH=$IDEATE_DIR/lib/base/bin:$IDEATE_DIR/lib/service/bin:$IDEATE_DIR/lib/case/bin:$PATH
fi

