
[M,N] = size(enco);
fid=fopen('A1.txt','w');
for i=1:M

fprintf(fid,'%d,',enco(i,1));

end

fclose(fid);
%%
o=load('A1.txt');
o=o';
%%
I = imread('test1.png');
I=rgb2gray(I);
[M,N] = size(I);
 deco = huffmandeco(o,dict); %����
 Ide = col2im(deco,[M,N],[M,N],'distinct'); %����������ת����ͼ��飻

 subplot(1,2,1);imshow(I);title('original image');
 %%
 save('dict');
 subplot(1,2,2);imshow(uint8(Ide));title('deco image');
