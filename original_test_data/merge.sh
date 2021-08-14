#!/bin/bash
PAHT=/bin:/sbin/:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
[ -z "$2" ] && echo "you must input the 2th file" && exit 0
test -e merge && rm merge
touch merge
t1=`cat $1 | wc -l`
t2=`cat $2 | wc -l`
if [ $t1 -le $t2 ]; then
   n=$t1 
else
    n=$t2
fi
for((i=1;i<=n;i=i+1))
  do
     head -n $i $1 | tail -n 1 >> merge
     head -n $i $2 | tail -n 1 >> merge
done

if [ $n -eq $t1 ]; then
   tail -n $(($t2-$n)) $2 >> merge 
else
   tail -n $(($t1-$n)) $1 >>merge
fi
