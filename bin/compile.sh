uglify="uglifyjs"
#uglify="cat"
version="0.1"

d="../dist/$version/js"
cxf="$d/crosslet.js"
cx="$d/crosslet-raw.js"
cxfm="$d/crosslet-min.js"
cxm="$d/crosslet-raw-min.js"
rm -rf $d
mkdir -p $d
for f in `find ../lib/ -type f -name "*.js" | sort`
do
echo $f
cat $f  >> $cxf
done

for f in `find ../src/ -type f -name "*.js" | sort`
do
echo $f
cat $f >> $cx
done

coffee -cbp ../src/coffee/init.coffee  >> $cx
for f in `find ../src/ -type f -name "*.coffee" | sort | grep -v init.coffee`
do
echo $f
echo "coffee -cbp $f "
coffee -cbp $f >> $cx
done

cat $cx >> $cxf
cat $cx | $uglify > $cxm
cat $cxf | $uglify > $cxfm
