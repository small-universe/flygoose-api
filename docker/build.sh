#版本
version=v1
# 镜像名
image_name=flygoose-api
docker build --no-cache -t $image_name:$version -f ./Dockerfile ../