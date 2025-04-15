#!/bin/bash
# 1. hugo 生成静态文件
# 2. 复制 web-aoeai 目录下的 .git、.gitignore 到临时目录
# 3. 删除 web-aoeai 目录
# 4. 将 Hugo 生成的静态内容拷贝到 web-aoeai 目录
# 5. 将临时目录中的 .git、.gitignore 拷贝到 web-aoeai 目录
# 6. 删除临时目录
# 7. 提交新代码到码云

# hugo publishDir
_HUGO_PUBLISH_DIR="/Users/aoe/aoeai/aoeai-website/public"
rm -rf $_HUGO_PUBLISH_DIR
cd /Users/aoe/aoeai/aoeai-website/
hugo --minify

_AOEAI_DIR="/Users/aoe/gitee/aoeai"
cd $_AOEAI_DIR
# 临时存储目录
_TEMP_DIR="$_AOEAI_DIR/temp-save"

if  [ -d  "$_TEMP_DIR"  ]; then
    rm -rf $_TEMP_DIR
fi

mkdir $_TEMP_DIR

_WEB_AOEAI_DIR="$_AOEAI_DIR/web-aoeai"
cd $_WEB_AOEAI_DIR
cp -r .git $_TEMP_DIR
cp .gitignore $_TEMP_DIR

cd $_AOEAI_DIR
rm -rf $_WEB_AOEAI_DIR
cp -r $_HUGO_PUBLISH_DIR $_WEB_AOEAI_DIR
cp $_TEMP_DIR/.gitignore $_WEB_AOEAI_DIR
cp -r $_TEMP_DIR/.git $_WEB_AOEAI_DIR

rm -rf $_TEMP_DIR

cd $_WEB_AOEAI_DIR
sudo git add .
_time=$(date "+%Y%m%d-%H:%M:%S")
sudo git commit -m "auto commit $_time"
sudo git push -u origin master


echo "完成 $_time"