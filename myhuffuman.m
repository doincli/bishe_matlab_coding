clear ;
clc;
 I1=imread('θ��.jpg');
 I2=rgb2gray(I1);
 imshow(I2);
 %% ���б��뺯��
[R,C]=size(I2);
a=I2(:);%1:M*N;
P=zeros(1,256);%��ȡ���ŵĸ���
for i=0:255
    P(i+1)=length(find(a==i))/(R*C);
end
%�������ǿ���ʹ���Դ��ĺ�����ͬʱҲ����ʹ���Լ�д�ĺ���
k=0:255;
dict=huffmandict(k,P);%������
%�����Լ�д�ĺ���
[output,p]=hufuman(I2);
%  %% ���������r  
%  %����H,����һ��Ҫ��Ϊ0��ֵȥ����������Զ�������
 H=0;
 for i=1:256
     if p(i) ~= 0
        H=H+p(i)*log2(1/p(i));
     end
 end
 %����ƽ���볤
 R=0;
 for i=1:256
     R=length(strtrim(output(i,:)))*p(i)+R;
 end
 %���������
 n=1-(H/(R*log2(256)));
 fprintf('�����nΪ %f\n',n )  
 fprintf('ƽ���볤nΪ %f\n',H ) 
 
 output;
%�Լ�д�ı��뺯���ļ�
function [output,p]=hufuman(input)
%inputΪ����ͼ��outputΪ���ͼ��
[R,C]=size(input);
a=input(:);%1:M*N;
p=zeros(1,256);%��ȡ���ŵĸ���
for i=0:255
    p(i+1)=length(find(a==i))/(R*C);
end
%�������ǿ���ʹ���Դ��ĺ�����ͬʱҲ����ʹ���Լ�д�ĺ���
n=length(p); 
p=sort(p);
q=p;
m=zeros(n-1,n);%255*256
for i=1:n-1
    [q,e]=sort(q); 
    m(i,:)=[e(1:n-i+1),zeros(1,i-1)]; %������l ����һ�����󣬸þ���������ʺϲ�ʱ��˳�����ں���ı���
    q=[q(1)+q(2),q(3:n),1]; 
end
 
for i=1:n-1
    c(i,1:n*n)=blanks(n*n); %c �������ڽ���huffman ����
end
    c(n-1,n)='1'; %����a ����ĵ�n-1 �е�ǰ����Ԫ��Ϊ����huffman ����Ӻ�����ʱ���õ������������(�ڱ�����Ϊ0.02��0.08)�������ֵΪ0 ��1
    c(n-1,2*n)='0'; 
for i=2:n-1
    c(n-i,1:n-1)=c(n-i+1,n*(find(m(n-i+1,:)==1))-(n-2):n*(find(m(n-i+1,:)==1))); %����c �ĵ�n-i �ĵ�һ��Ԫ�ص�n-1 ���ַ���ֵΪ��Ӧ��a �����е�n-i+1 ����ֵΪ1 ��λ����c �����еı���ֵ
    c(n-i,n)='0'; 
    c(n-i,n+1:2*n-1)=c(n-i,1:n-1); %����c �ĵ�n-i �ĵڶ���Ԫ�ص�n-1 ���ַ����n-i �еĵ�һ��Ԫ�ص�ǰn-1 ��������ͬ����Ϊ����ڵ���ͬ
    c(n-i,2*n)='1'; 
    for j=1:i-1
         c(n-i,(j+1)*n+1:(j+2)*n)=c(n-i+1,n*(find(m(n-i+1,:)==j+1)-1)+1:n*find(m(n-i+1,:)==j+1));
            %����c �е�n-i �е�j+1 �е�ֵ���ڶ�Ӧ��a �����е�n-i+1 ����ֵΪj+1 ��ǰ��һ��Ԫ�ص�λ����c �����еı���ֵ
    end
end 
for i=1:n
    output(i,1:n)=c(1,n*(find(m(1,:)==i)-1)+1:find(m(1,:)==i)*n); %��h��ʾ����huffman ����
    len(i)=length(find(abs(output(i,:))~=32)); %����ÿһ������ĳ���
end
output=strtrim(output);
end