function R=histogram(gray)
%Gray histogram
[ox oy]=size(gray);
for i=1:256
    G_his(i)=0;
end
for i=1:ox
    for j=1:oy
        G_his(gray(i,j)+1)=G_his(gray(i,j)+1)+1;%统计0~255每个灰度值的个数，数组下标1~256
    end
end
%输出
subplot(1,2,2),bar(G_his);
