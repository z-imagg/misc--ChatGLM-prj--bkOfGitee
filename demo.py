#模型文件 用分支int4 https://huggingface.co/THUDM/chatglm-6b/tree/int4



#模型代码仓库
#git clone -b main https://github.com/THUDM/ChatGLM-6B.git /app3/ChatGLM-6B

#预训练模型文件仓库
#  此仓库 13GB 一般的T子不行，  
#  思路： 
#    1. 用一般的T子 去colab正常克隆该仓库，
#        git lfs install   
#        git clone https://huggingface.co/THUDM/chatglm-6b /app3/chatglm-6b-pretain
#    2. 传回国内
#          记录仓库中各文件的摘要、 打包、 记录包摘要、 切分成N个足够小的文件 分别放入gitee.com的N个仓库中  , 从而间接的传回G内
#        TODO: 记录仓库中各文件的摘要、
#        TODO: 打包、
#        TODO: 记录包摘要、
#        TODO: 切分成N个足够小的文件
#        TODO: 建立N个gitee仓库
#        TODO: 分别放入gitee.com的N个仓库中
#        从而间接的传回G内


#int4 模型文件下载 到 /app3/chatglm-6b-pretain/ 下
# 仓库 /app3/chatglm-6b-pretain 切换到分支int4
#      https://cloud.tsinghua.edu.cn/d/674208019e314311ab5c/?p=%2Fchatglm-6b-int4&mode=list
# cd /app3/chatglm-6b-pretain/  
# axel -n 5 "https://cloud.tsinghua.edu.cn/d/674208019e314311ab5c/files/?p=%2Fchatglm-6b-int4%2Fpytorch_model.bin&dl=1"
# wget "https://cloud.tsinghua.edu.cn/d/674208019e314311ab5c/files/?p=%2Fchatglm-6b-int4%2FMODEL_LICENSE&dl=1""
# wget "https://cloud.tsinghua.edu.cn/d/674208019e314311ab5c/files/?p=%2Fchatglm-6b-int4%2Fice_text.model&dl=1"

#给出以下代码中书写的目录 "THUDM/chatglm-6b-int4"
# ln -s  /app3/chatglm-6b-pretain /app3/chatglm-6b/THUDM/chatglm-6b-int4


#本文来自:  https://github.com/THUDM/ChatGLM-6B/blob/a0d6b9e1698f5bfd7ca610ebf03a4bd595f53dda/README.md#%E4%BB%A3%E7%A0%81%E8%B0%83%E7%94%A8

#本文件路径:  /app3/ChatGLM-6B/demo.py

from transformers import AutoTokenizer, AutoModel
tokenizer = AutoTokenizer.from_pretrained("THUDM/chatglm-6b-int4", trust_remote_code=True,revision="v1.1.0")
model = AutoModel.from_pretrained("THUDM/chatglm-6b-int4", trust_remote_code=True).half().cuda()
# 模型文件下载 https://cloud.tsinghua.edu.cn/d/674208019e314311ab5c/?p=%2Fchatglm-6b-int4&mode=list
model = model.eval()
response, history = model.chat(tokenizer, "你好", history=[])
print(response)
#你好👋!我是人工智能助手 ChatGLM-6B,很高兴见到你,欢迎问我任何问题。
response, history = model.chat(tokenizer, "晚上睡不着应该怎么办", history=history)
print(response)
"""
晚上睡不着可能会让你感到焦虑或不舒服,但以下是一些可以帮助你入睡的方法:

1. 制定规律的睡眠时间表:保持规律的睡眠时间表可以帮助你建立健康的睡眠习惯,使你更容易入睡。尽量在每天的相同时间上床,并在同一时间起床。
2. 创造一个舒适的睡眠环境:确保睡眠环境舒适,安静,黑暗且温度适宜。可以使用舒适的床上用品,并保持房间通风。
3. 放松身心:在睡前做些放松的活动,例如泡个热水澡,听些轻柔的音乐,阅读一些有趣的书籍等,有助于缓解紧张和焦虑,使你更容易入睡。
4. 避免饮用含有咖啡因的饮料:咖啡因是一种刺激性物质,会影响你的睡眠质量。尽量避免在睡前饮用含有咖啡因的饮料,例如咖啡,茶和可乐。
5. 避免在床上做与睡眠无关的事情:在床上做些与睡眠无关的事情,例如看电影,玩游戏或工作等,可能会干扰你的睡眠。
6. 尝试呼吸技巧:深呼吸是一种放松技巧,可以帮助你缓解紧张和焦虑,使你更容易入睡。试着慢慢吸气,保持几秒钟,然后缓慢呼气。

如果这些方法无法帮助你入睡,你可以考虑咨询医生或睡眠专家,寻求进一步的建议。
"""