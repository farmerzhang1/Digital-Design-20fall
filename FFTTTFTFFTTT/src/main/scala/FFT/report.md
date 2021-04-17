# 中国科学技术大学计算机学院

# 《数字电路实验》报告

* 姓名：張棟澈
* 學號：PB19111677
* 日期：2020.12.31

## 【实验题目】

## 使用Chisel構造FFT電路

## 【实验目的】

1. 熟悉快速傅立葉變換(Fast Fourier Transform)
2. 掌握Chisel語言(Constructing Hardware in a Scala Embedded Language)
3. 进一步熟悉 FPGA 开发的整体流程

## 【实验环境】

1. Visual Studio Code
2. Xilinx Vivado
3. fpgaol.ustc.edu.cn

## Prerequisites

2. Scala
3. Chisel
3. FFT

(just kidding)

## 一、Chisel是什麼？

##     C'est quoi ? Chisel ?

Chisel是一种开源的硬件描述语言（HDL），用于描述寄存器传输级的数字电路。Chisel是基于Scala的嵌入式DSL。Chisel继承了Scala面向对象和功能方面的特点，用于描述数字硬件。以Scala为基础可以描述电路生成器。[wiki]

与HLS（High Level Synthesis，高层次综合）通常采用的软件代码辅以编译控制的策略相比，Chisel更贴近原生的硬件构建，例如我们可以使用Chisel显式地创建线网变量或寄存器变量。通过充分利用Chisel的语法特性，可以使代码具有高度参数化(Parameterization)以及高度可配置性的特点，从而得到所谓的电路生成器（Circuit Generator)。电路生成器会根据不同的参数配置生成不同的电路架构，例如是否流水，采用定点数还是浮点数，等等。另外，Chisel作为硬件编译器框架的先驱，采用了类似于LLVM这种multi-stage的架构。首先，前端将Chisel编译为一种称为FIRRTL（Flexible Intermediate Representation for RTL）的电路中间表示，中端接着优化FIRRTL并执行用户自定义的转换，最终后端基于优化的FIRRTL产生Verilog代码。这种前/中/后端强解耦的设计模式极大地给予了用户便利，使得对Chisel的定制扩展极为方便。

Chisel最突出的用法是RISC-V指令集的实现(by Berkeley)，即开源的Rocket芯片。

## 二、FFT簡介

快速傅里叶变换（英語：Fast Fourier Transform, FFT），是快速计算序列的离散傅里叶变换（DFT）或其逆变换的方法。傅里叶分析将信号从原始域（通常是时间或空间）转换到頻域的表示或者逆过来转换。FFT会通过把DFT矩阵分解为稀疏（大多为零）因子之积来快速计算此类变换。因此，它能够将计算DFT的复杂度从只用DFT定义计算需要的 O(n^{2})，降低到 O(n\log n)，其中 n 为数据大小。

下文將使用矩陣簡要說明

