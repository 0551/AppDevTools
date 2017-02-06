#!/bin/sh

#  mountntfs.sh
#  
#
#  Created by zhx on 14/11/1.
#

#为了省点钱，自己写了个脚本，不用什么NTFS！写的不好，凑合能用。高手见笑，望完善。如果不好用请不要骂，壕，你去买软件吧。
#
#使用方法（请认真阅读，如果你是linuxer，应该不是问题的，否则一切后果概不负责。叙述较啰嗦，见谅。）：
#
#请把该文件放在你容易找到的地方
#
#把硬盘连接电脑，使用shift+command+u找到终端，并打开在终端中使用  sh mountntfs.sh  回车，脚本会提醒你输入你要挂载的盘符后回车，
#
#脚本会自动把你的要挂载分区挂载到你的桌面，这时就可以读写了。使用完后右键推出，脚本挂载过程中会自动建立一个文件夹作为挂载点，
#
#该文件夹在推出硬盘后需手动删除。
#
#使用shift+command+u找到终端并打开，开始查看你要挂载的硬盘分区的盘符方法如下：
#
#1、输入命令  ls /dev | grep disk 找到你所要挂载的分区，如disk2s1、disk2s2、disk3s1等。名称一般为disk#s# 第一个#
#
#代表硬盘编号，0为主硬盘（Mac OS X所在），这个不要折腾，如果硬盘有多个硬盘，请仔细检查，别搞错了，如果有dmg的程序，它也是一个挂载
#
#成一个硬盘。第二个#代表硬盘分区，从1开始。
#
#2、插入硬盘后使用mount命令查看,
#
#例如：输入mount命令后，终端回显一堆文本。
#
#找到类似于/dev/disk3s1 on /Volumes/Elements (ntfs, local, nodev, nosuid, read-only, noowners)
#
#其中/dev/disk3s1 就是系统自动挂载的硬盘分区，被挂载到了/Volumes下得Elements（Elements这是硬盘的卷标）后边括号内最主要的就是
#
#ntfs，硬盘格式，和read-only，只读方式挂载。如果所看到不是ntfs格式，就不要折腾了。
#
#使用中用到的问题：
#
#1、盘符不能输错，输错后delete键回删不了，直接回车，脚本会自动退出
#
#2、提示"卸载失败，请退出正在使用的该分区的文件后重新挂载"，可能你正在使用硬盘里的文件，请关闭后再重新挂载。保证硬盘未被使用。
#
#3、脚本运行会让输入密码，请确保你所用的用户为sudo用户，如果不是请在终端中使用sudo passwd xxx 修改，xxx为你的用户名。
#
#否则本脚本无法使用。


MOUNTPATH=/Users/${USER}/Desktop/  #定义挂载路径变量为当前用户的桌面

read -p "请输入你要挂载为读写的NTFS分区（如disk2s1或disk2s2），可用ls /dev | grep disk 查看:" i

MOUNT() #挂载函数
{

    sleep 3

    VOLUME=`diskutil info /dev/$i | grep "Volume Name" | awk '{print $3}'`      #抓取将被挂载的卷标

    if [ ! -d ${MOUNTPATH}${VOLUME} ];then      #判断所创建挂载点是否存在，如果不存在则创建，否则直接挂载

        mkdir ${MOUNTPATH}${VOLUME}             #在桌面创建以被挂载分区盘符命名的挂载点，硬盘退出后，该挂载点需手动删除

    else

        sudo mount -t ntfs -o noowners,nodev,nobrowse,noatime,rw /dev/$i ${MOUNTPATH}${VOLUME}  #开始以读写方式挂载

        echo 挂载成功;
    fi


}



ls /dev/ | grep $i                            #检测输入分区是否正确

if [ $? == 0 ];then                           #如果正确则开始尝试挂载

    mount | grep $i  >/dev/null 2>&1                   #检测分区是否已经被挂载

    if [ $? == 0 ];then                       #如果被挂载，则尝试卸载后重新挂载

        sudo umount /dev/$i 2>/dev/null            #尝试卸载被默认挂载的分区

        if [ $? == 0 ];then                   #如果卸载成功，则开始挂载

            MOUNT                             #调用挂载函数

        else

            echo "卸载失败，请推出正在使用的该分区的文件后重新挂载"

            exit 1;

        fi

    else                                     #如果分区未被挂载，或者之前挂载推出后没有拔下来，则直接挂载

        MOUNT                                #调用挂载函数

    fi

else

    echo "请检查输入的分区是否正确，可用ls /dev | grep disk 查看"

    exit 2

fi