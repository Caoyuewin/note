echo "hello world"
# 变量
x=1
name="caoyuewen"
echo $name
name="cyw"
echo $name

# 只读变量
readonly_var="readonly_var"
readonly $readonly_var
echo $readonly_var "is readonly"

# 删除变量
# unset不能删除只读变量
# unset readonly_var
unset name
echo $name

# 字符串类型
# 双引号
# 双引号里可以有变量
# 双引号里可以出现转义字符
str1="str"
echo "'\$str1' is a \"$str1\""
# 单引号
# 单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的；
# 单引号字串中不能出现单独一个的单引号（对单引号使用转义符后也不行），但可成对出现，作为字符串拼接使用。
str2='str2'
# 没有引号
str3=str3
echo $str1 $str2 $str3

# 获取字符串长度
echo 获取字符串长度
string="abcd"
unset string
echo ${#string}

# 提取子字符串
echo 提取子字符串
string="get a sub stringj"
echo ${string:1:4}
unset string

# 查找子字符
echo 查找子字符串
string="find sub string in: aa bb cc dd"
echo `expr index "$string" a`
echo `expr index "$string" b`
echo `expr index "$string" c`
unset string

# shell数组
echo shell数组
int_array=(1 2 3 4 5)
echo $int_array[0]
echo 获取数组所有元素
echo "int_array的所有元素:"${int_array[@]}

echo 获取数组长度
echo ${#int_array[@]}
echo 获取数组单个元素长度
echo ${#int_array[1]}

echo 多行注释
:<<EOF
注释1
注释2
注释3
EOF
:<<!
注释1
注释2
注释3
!

echo shell传递参数
echo "第一个参数是文件名：$0"
echo "第二个参数：$1"
echo "第三个参数：$2" 
echo "传递到脚本的参数个数：$#"
echo "以一个字符串显示所有向脚本传递的参数：$*"
echo "脚本运行的进程ID号：$$"
echo "后台进程运行的最后一个进程的ID号：$!"
echo "以一个字符串显示所有向脚本传递的参数：$@"
echo "显示shell使用的当前选项：$-"
echo "显示最后命令的退出状态,0标识没有错误，其他任意值标识有错误：$?"

echo shell基本运算符
# expr 运算时表达式和运算符之前 一定要有空格，并且要被``包裹
echo "2+2=`expr 2 + 2`"
echo "2-2=`expr 2 - 2`"
echo "4/2=`expr 4 / 2`"
# *号前要加\才能实现乘法运算
echo "2*2=`expr 2 \* 2`"
echo "4%2=`expr 4 % 2`"
a=2
b=$a
echo b
unset a
unset b

# if后要跟空格，[ 和 表达式之间,== 和表达式之间也要有空格
if [ 2 == 2 ]
then
		echo "2等于2"
fi

if [ 2 != 3 ]
then
		echo "2不等于3"
fi

# 关系运算符`
echo 关系运算符
a=10
b=20
if [ $a -eq $b ]
then
		echo "a等于b"
fi
if [ $a -ne $b ]
then
		echo "a不等于b"
fi
if [ $a -gt $b ]
then
		echo "a大于b"
fi
if [ $a -lt $b ]
then
		echo "a小于b"
fi
if [ $a -ge $b ]
then
		echo "a大于等于b"
fi
if [ $a -le $b ]
then
		echo "a小于等于b"
fi
if [ $a -le $b -a $a -gt 5 ]
then
		echo "a小于等于b,且a大于5"
fi
if [ $a -ge $b -o $a -gt 5 ]
then
		echo "a大于等于b,或a大于5"
fi
if [[ $a -le $b && $a -gt 5 ]]
then
		echo "a小于等于b,且a大于5"
fi
if [[ $a -ge $b || $a -gt 5 ]]
then
		echo "a大于等于b,或a大于5"
fi

# read命令从标准输入读取一行，把输入行的每个字段的值指定给shell变量
# read name
echo "$name is my name"
# -e开启转义 \n 换行 \c 不换行
echo -e "换行\n"
echo 换行
echo -e "不换行\c"
echo 不换行

echo 显示结果定向至文件
echo "i am a file" > myfile
echo `date`

# printf
printf "%-10s %-8s %-4s\n" 姓名 性别 体重kg
printf "%-10s %-8s %-4.2f\n" 郭靖 男 66.1234
printf "%-10s %-8s %-4.2f\n" 杨过 男 78.4325234
printf "%-10s %-8s %-4.2f\n" 郭芙 女 45.6575

# test
# 数值测试
num1=100
num2=100
if test $[num1]  -eq $[num2]
then
		echo "num1等于num2"
else
		echo "num1不等于num2"
fi

# 字符串测试
str1="test1"
str2="test2"
if test $str1 = $str2
then
		echo "str1等于str2"
else
		echo "str1不等于str2"
fi

#文件测试
if test -e ./myfile
then
		echo 文件存在
fi
if test -r ./myfile
then
		echo 文件可读
fi
if test -w ./myfile
then
		echo 文件可写
fi
if test -x ./myfile
then
		echo 文件可执行
fi
if test -s ./myfile
then
		echo 文件至少有一个字符
fi
if test -d ./myfile
then
		echo 文件为目录
fi
if test -f ./myfile
then
		echo 文件为文件
fi
if test -c ./myfile
then
		echo 文件为字符型特殊文件
fi
if test -b ./myfile
then
		echo 文件为块特殊文件
fi

# 流程控制
# if else elif fi
num4=5
if [ $num4 -gt 9 ]
then
		echo "num4大于9"
elif [ $num4 -gt 7 ]
then
		echo "num4大于7"
elif [ $num4 -gt 5 ]
then
		echo "num4大于5"
else
		echo "num4大于3"
fi

# for
for value in 1 2 3 4 5
do
		echo "the value is: $value"
done

# while
int=1
while(( $int<=5 ))
do
		echo $int
		let "int++"
done

:<<!
while read FILM
do 
		echo "$FILM 是一个好电影"
done
!

# until false执行，true停止
int=1
until (( int > 5 ))
do
		echo $int;
		let "int++"
done

# case
:<<!
read input
case $input in
		1) echo 你选择了1
				;;
		2) echo 你选择了2
				;;
		3) echo 你选择了3
				;;
		4) echo 你选择了4
				;;
		*) echo 你没有选择任何数
				;;
esac
!

# 跳出循环
# break 跳出所有循环
# continue 跳出当前循环

# shell函数

demoFun(){
		echo 这是我的第一个函数
}

demoFun


#funWithReturn(){
#		echo 请输入第一个数
#		read x
#		echo 请输入第二个数
#		read y
#		echo 两数之和为
#		return $(($x+$y))
#}
#funWithReturn

funWithParams(){
	echo $1
	echo $2
	echo $3
	echo $4
	echo $5
	echo $6
	echo $7
	echo $8
	echo $9
	# n >= 10时需要{}
	echo ${10}
}

funWithParams 1 2 3 4 5 6 7 8 9 10;

# 输入输出重定向
# > 输出重定向,会覆盖原有内容；>> 输出追加重定向
# < 输入重定向,会覆盖原有内容；<< 输入追加重定向
echo 重定向输入 >> myfile
echo 重定向输出 >> myfile

# >& 合并输出文件
# <& 合并输入文件

# command 2>file ：将stderr重定向到file
# command > file 2>&1 : 将stderr和stdout合并后重定向到file
# command > /dev/null 重定向到/dev/null的内容都会被丢弃

# who命令输出重定向到./users
who > ./users
# wc
wc -l ./users
# wc命令输入重定向,./users作为wc命令的输入
wc -l < ./users


# shell 文件包含 (.)和文件名中间有空格
. ./name.sh #或source ./name.sh
echo myname:$name






















