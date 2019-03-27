#!/usr/bin/env bash
git pull
var=$(cat .config)
arr=()
for element in $var
do
    arr[${#arr[*]}]=$element
done
echo ${arr[0]} ${arr[1]};
data=${arr[0]}
tag=${arr[1]}

export basedir=$data
export tag=$tag

sh pullImage.sh $tag

cd $data/service
echo "reinstall service"
docker-compose up -d
cd -
sleep 30

cd $data/workspace
echo "reinstall apps"
docker-compose up -d

cd -


cd $data/nginx
echo "reinstall nginx"
docker-compose up -d

cd -

sh restart.sh

echo "在你的浏览器中打开 http://IP 即可访问毕升文档"
