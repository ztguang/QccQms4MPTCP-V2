#!/bin/bash
PAHT=/bin:/sbin/:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
[ -z "$2" ] && echo "you must input the 2th file" && exit 0
test -e merge && rm merge #文件存在则删除
touch merge #重新创建文件
t1=`cat $1 | wc -l` # 计算文件1的行数
t2=`cat $2 | wc -l` # 计算文件2的行数
if [ $t1 -le $t2 ]; then #求出行数最小的
   n=$t1 
else
    n=$t2
fi
for((i=1;i<=n;i=i+1)) #逐行交替放入merge
  do
     head -n $i $1 | tail -n 1 >> merge #先去前i行再取其尾部开始的一行
     head -n $i $2 | tail -n 1 >> merge
done

if [ $n -eq $t1 ]; then # 将剩余的内容存入merge
   tail -n $(($t2-$n)) $2 >> merge 
else
   tail -n $(($t1-$n)) $1 >>merge
fi
