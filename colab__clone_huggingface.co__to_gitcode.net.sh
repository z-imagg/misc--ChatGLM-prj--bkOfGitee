#!/usr/bin/python3

#【描述】   利用google的colab 克隆 25GB的华为开源大模型chatGLM预训练模型git仓库huggingface.co/THUDM/chatglm-6b 、打包仓库、拆小、小传到gitcode.net
#【依赖】   
#【术语】  
#【备注】   


#1. 克隆 git仓库 huggingface.co/THUDM/chatglm-6b
########
git lfs install
git clone https://huggingface.co/THUDM/chatglm-6b
apt install -y tree 
tree 
ls -lh chatglm-6b
mkdir  /app3
mv chatglm-6b /app3/chatglm-6b-pretain 

du -h /app3/chatglm-6b-pretain  #25G	/app3/chatglm-6b-pretain

find /app3/chatglm-6b-pretain -type f -not -path "*\.git/*" -print0| xargs -0 -I@ sha256sum @ | tee  /app3/chatglm-6b-pretain.sha256.txt

#2. 打包 git仓库
#######
tar -cvf /app3/chatglm-6b-pretain.tar /app3/chatglm-6b-pretain.sha256.txt  /app3/chatglm-6b-pretain

#3. 拆分为小文件 
#########
#后缀为 001,002,...,064
split -b 400m -d  --suffix-length=3 /app3/chatglm-6b-pretain.tar /app3/chatglm-6b-pretain.tar-25GB-400MB-

#4. 在给定gitcode.net组织下创建N个仓库,仓库名是1...N
########
PYTHONPATH=/app/bash-simplify/  python3 -c "import gitcode_net_api_demo as M; M.main__createNRepo_inGrp('org--chatglm-6b',65)"

#5.0 准备
#######
gitcode_token="szgTdCTbpJ_ikGzZV5AR"
gitcode_usr="prgrmz07"

readarray -t fArr < <(ls /app3/chatglm-6b-pretain.tar-25GB-400MB-* )
fCnt="${#fArr[@]}"

repoHm=$(pwd)/gitcode_home
mkdir -p $repoHm

#5. 循环克隆N个gitcode.net仓库
for (( k=1; k<=fCnt; k++ )); do
  repokD=${repoHm}/${k}
  repok_cln_cmd="git clone https://$gitcode_usr:$gitcode_token@gitcode.net/myz/org-chatglm-6b/${k}.git ${repokD}"
  [[ -f ${repokD}/.git/config ]] || $repok_cln_cmd
done

#6. 循环, 小文件k移动到gitcode.net仓库k  并git添加、git提交
###########

for (( k=1; k<=fCnt; k++ )); do
  echo -n "${k},"
  repokD=${repoHm}/${k}
  gitArg="--work-tree ${repokD} --git-dir ${repokD}/.git"
  _k=$(printf "%03d\n" "$k")
  fk="/app3/chatglm-6b-pretain.tar-25GB-400MB-${_k}"
  # ls $fk  || continue
  # { ls $fk  && mv $fk $repokD/ ;} || true
  git $gitArg status
  git $gitArg add '*' && git $gitArg commit -m "add chatglm-6b-pretain.tar-25GB-400MB-${_k}"
done


#7. 循环, gitcode.net仓库k  git推送
###########

for (( k=1; k<=fCnt; k++ )); do
  echo -n "${k},"
  repokD=${repoHm}/${k}
  gitArg="--work-tree ${repokD} --git-dir ${repokD}/.git"
  git $gitArg push
done


