##RAID常见级别介绍

@(本文图片转自维基百科)

---
####RAID-0
将多块硬盘平行组织起来并行处理以提高性能，但是这样的话硬盘性能虽然提高了但是可靠性大大降低，由于RAID-0的特性，只要有一块硬盘损坏，这个磁盘阵列上的所有数据都可能会丢失，生产环境中一般不会使用。

特点：
>1、提高了磁盘读、写、IO性能，理论为硬盘原速度的*硬盘数
2、无容错能力
3、最少使用2块硬盘
4、硬盘可用空间，为所有硬盘中空间最小的硬盘空间乘以硬盘总数， 公式 N*min(Disk0..DiskN)
![image](https://github.com/dxtywt/init/blob/master/image/RAID_0.svg.png)

####RAID-1
将多个硬盘相互做成镜像，提高冗余能力，读取速度。这样极大提高了冗余能力，读取时两个硬盘也可以并行读取来提高读取性能，但是写入速度略有下降。

特点：
>1、提高了读性能，写性能下降
2、极大提高了容错能力
3、最少使用2块硬盘
4、硬盘可用空间，为所有硬盘中空间最小硬盘的空间大小， 公式 1*min(Disk0..DiskN)
![image](https://github.com/dxtywt/init/blob/master/image/RAID_1.svg.png)
####RAID-5
RAID-5采用将冗余校验码分别存放在每一个磁盘上来达到负载均衡的效果，而且极大的提高了整体性能，但是只能提供一块硬盘的冗余。

特点：
>1、提高了读写、IO性能
2、提高了容错能力，相比于RAID-4而言提高整体稳定性
3、最少使用3块硬盘
4、最大硬盘使用空间，为所有硬盘中空间最小的硬盘的空间大小乘以硬盘数减去1， 公式(N-1)*min(Disk1..DiskN)
![image](https://github.com/dxtywt/init/blob/master/image/RAID_5.svg.png)
####RAID-10/01
RAID-10/01是两种混合型RAID，RAID-10先将所有硬盘分成N组组成RAID-1提高冗余性，然后将其按组组成RAID-0提高硬盘性能，最多可支持半数硬盘损坏而不丢失数据。RAID-01先将所有硬盘分成N组组成RAID0提高性能，然后将其按组组成RAID-1提高冗余性，运气不好两块硬盘损坏就可能导致全部硬盘数据丢失。

**RAID-10**
>1、提高了读写、IO性能
2、提高了容错能力，最多支持半数硬盘损坏
3、最少使用4块硬盘
4、最大硬盘使用空间，为所有硬盘中空间最小的硬盘的空间大小乘以2， 公式(N*min(Disk0..Disk1))/2

**RAID-01**
>1、提高了读写、IO性能
2、提高了容错能力，但是效果不是很好，因为先使用不可靠的RAID-0在使用可靠的RAID1，就好像建房子地基偷工减料，而顶层却建的很结实
3、最少使用4块硬盘
4、最大硬盘使用空间，为所有硬盘中空间最小的硬盘的空间大小乘以2， 公式(N*min(Disk0..Disk1))/2
![image](https://github.com/dxtywt/init/blob/master/image/RAID_10.svg.png)
![image](https://github.com/dxtywt/init/blob/master/image/RAID_01.svg.png)



