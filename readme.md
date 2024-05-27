```shell
# 原始仓库 https://github.com/THUDM/ChatGLM-6B.git
git clone https://gitee.com/repok/THUDM--ChatGLM-6B.git   /app3/THUDM--ChatGLM-6B

cd /app3/THUDM--ChatGLM-6B

python3 -m venv .venv_chatglm

source .venv_chatglm/bin/activate

which pip
#/app/ChatGLM-6B/.venv_chatglm/bin/pip


pip install -r requirements.txt

#给出demo.py中书写的目录 "THUDM/chatglm-6b-int4"
mkdir  /app3/THUDM--ChatGLM-6B/THUDM
ln -s /app3/chatglm-6b-int4-pretrain /app3/THUDM--ChatGLM-6B/THUDM/chatglm-6b-int4
ls -lh /app3/THUDM--ChatGLM-6B/THUDM/
#lrwxrwxrwx   chatglm-6b-int4 -> /app3/chatglm-6b-int4-pretrain


python demo.py
```