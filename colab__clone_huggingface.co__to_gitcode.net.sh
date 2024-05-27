#!/usr/bin/python3

#【描述】   利用google的colab 克隆 25GB的华为开源大模型chatGLM预训练模型git仓库huggingface.co/THUDM/chatglm-6b 、丢弃work-tree 只留git-dir、打包、拆小、小传到google网盘
#【依赖】   
#【术语】  
#【备注】   





#1. 克隆 git仓库 huggingface.co/THUDM/chatglm-6b
git lfs install
git clone https://huggingface.co/THUDM/chatglm-6b

#1.B 拉取全部远程分支
cd /content/chatglm-6b
remote_branches=$(git branch -r | grep -v '\->' | grep -v 'master' | grep -v 'HEAD' | sed 's/^ *//')
for branch in $remote_branches; do
    # 提取远程分支名称（去掉远程仓库前缀）
    local_branch=$(echo $branch | sed 's/.*\///')
    # 创建本地跟踪分支
    # echo "git checkout -b $local_branch $branch"
    git checkout -b $local_branch $branch
done

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

#8.  签名校验正常
cat  /app3/chatglm-6b-data/chatglm-6b.git.tar.gz.md5sum.txt 
# 0904d96346064ccc8bd55a60b8d145b9  chatglm-6b.git.tar.gz
(cd /app3 &&  md5sum --check  chatglm-6b-data/chatglm-6b.git.tar.gz.md5sum.txt ;)
#chatglm-6b.git.tar.gz: OK

#9. 解包
mkdir /app3/unpack_dir
tar -zxvf /app3/chatglm-6b-data/chatglm-6b.git.tar.gz -C /app3/unpack_dir

#10. 释放.git为正常git仓库
git clone unpack_dir/chatglm-6b /app3/chatglm-6b-pretain/

ls chatglm-6b-pretain/
# config.json               MODEL_LICENSE                     pytorch_model-00005-of-00008.bin  quantization.py
# configuration_chatglm.py  pytorch_model-00001-of-00008.bin  pytorch_model-00006-of-00008.bin  README.md
# ice_text.model            pytorch_model-00002-of-00008.bin  pytorch_model-00007-of-00008.bin  test_modeling_chatglm.py
# LICENSE                   pytorch_model-00003-of-00008.bin  pytorch_model-00008-of-00008.bin  tokenization_chatglm.py
# modeling_chatglm.py       pytorch_model-00004-of-00008.bin  pytorch_model.bin.index.json      tokenizer_config.json


du -h  chatglm-6b-pretain/
# 13G     chatglm-6b-pretain/.git/lfs
# 13G     chatglm-6b-pretain/.git
# 25G     chatglm-6b-pretain/
