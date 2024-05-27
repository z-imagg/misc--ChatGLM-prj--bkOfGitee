#!/usr/bin/python3

#【描述】   利用google的colab 克隆 25GB的华为开源大模型chatGLM预训练模型git仓库huggingface.co/THUDM/chatglm-6b 、丢弃work-tree 只留git-dir、打包、拆小、小传到google网盘
#【依赖】   
#【术语】  
#【备注】   





#1. 克隆 git仓库 huggingface.co/THUDM/chatglm-6b
git lfs install
git clone https://huggingface.co/THUDM/chatglm-6b

#2. colab页面上点击挂载google-drive（google网盘）
#  google网盘挂载后目录为 /content/drive/MyDrive

#3. 删除git仓库的work-tree,只保留git-dir。 因为google-drive只有15GB空间
rm -fr chatglm-6b/*
tar -zcvf  chatglm-6b.git.tar.gz chatglm-6b/.git/

#4. 包摘要上传到 google网盘
md5sum chatglm-6b.git.tar.gz | tee /content/drive/MyDrive/chatglm-6b-data/chatglm-6b.git.tar.gz.md5sum.txt

#5. 拆分为小文件 并上传google网盘
split -b 1024m  --numeric-suffixes=1  -d  --suffix-length=3 /content/chatglm-6b.git.tar.gz /content/drive/MyDrive/chatglm-6b-data/chatglm-6b.git.tar.gz-1GB-

#6. 去google网盘下载 chatglm-6b-data/chatglm-6b.git.tar.gz-1GB-*
#  浏览器点击下载后，当下载已开始后，禁用switchOmega 这样可以节省很大代理流量

#7. 合并小文件为包
cat /app3/chatglm-6b-data/chatglm-6b.git.tar.gz-1GB-??? > /app3/chatglm-6b.git.tar.gz