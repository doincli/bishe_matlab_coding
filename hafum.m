clear;
clear all;
I = imread('test1.png');
I=rgb2gray(I);
[M,N] = size(I);
 I1 = I(:);
 P = zeros(1,256);
 %获取各符号的概率；
 for i = 0:255
     P(i+1) = length(find(I1 == i))/(M*N);
 end
 k = 0:255;
 dict = huffmandict(k,P); %生成字典
 temp=dict;
 for i=1:length(temp)
 temp{i,2}=num2str(temp{i,2})
 end

 enco = huffmanenco(I1,dict); %编码
 deco = huffmandeco(enco,dict); %解码
 Ide = col2im(deco,[M,N],[M,N],'distinct'); %把向量重新转换成图像块；

 subplot(1,2,1);imshow(I);title('original image');
 subplot(1,2,2);imshow(uint8(Ide));title('deco image');
 %%
  subplot(1,2,1);imhist(I);title('original image');
 subplot(1,2,2);imhist(uint8(Ide));title('deco image');
