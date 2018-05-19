#!/bin/bash
rm -rf ./output
mkdir output
mkdir ./output/deck
mkdir ./output/docs
mkdir ./output/pics
mkdir ./output/pics/field
mkdir ./output/script
mkdir ./output/sound
mkdir ./output/sound/custom
mkdir ./output/sound/BGM
mkdir ./output/sound/BGM/custom

find ./archive/*.rar | xargs -I {} bash -c "7z x -oarchive/\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM -y '{}'"
find ./archive/*.zip | xargs -I {} bash -c "7z x -oarchive/\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM -y '{}'"
find ./archive/*.7z | xargs -I {} bash -c "7z x -oarchive/\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM -y '{}'"
rm -rf archive/*.rar archive/*.zip archive/*.7z

find ./archive/ | grep ".lua" | xargs -I {} mv -f {} ./output/script/
find ./archive/ | grep ".txt" | xargs -I {} mv -f {} ./output/docs/
find ./archive/ | grep ".mp3" | xargs -I {} mv -f {} ./output/sound/BGM/custom/
find ./archive/ | grep ".ogg" | xargs -I {} mv -f {} ./output/sound/BGM/custom/
find ./archive/ | grep ".wav" | xargs -I {} mv -f {} ./output/sound/custom/

find ./archive/ | grep "thumbnail" | xargs -I {} rm -rf {}
find ./archive/ | grep -P "field/.+\.jpg" | xargs -I {} mv -f {} ./output/pics/field/
find ./archive/ | grep ".jpg" | xargs -I {} mv -f {} ./output/pics/

rm -rf database
mkdir database
rm -rf new.cdb

find ./archive/ | grep ".cdb" | xargs -I {} bash -c "mv -f '{}' database/\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM\$RANDOM.cdb"
ls database/*.cdb | xargs -I {} sqlite3 {} .dump | sqlite3 new.cdb

echo "update texts set desc=replace(desc,'①效果','①的效果');" | sqlite3 new.cdb
echo "update texts set desc=replace(desc,'②效果','②的效果');" | sqlite3 new.cdb
echo "update texts set desc=replace(desc,'③效果','③的效果');" | sqlite3 new.cdb
echo "update texts set desc=replace(desc,'④效果','④的效果');" | sqlite3 new.cdb
echo "update texts set desc=replace(desc,'⑤效果','⑤的效果');" | sqlite3 new.cdb
echo "update texts set desc=replace(desc,'⑥效果','⑥的效果');" | sqlite3 new.cdb
echo "update texts set desc=replace(desc,'⑦效果','⑦的效果');" | sqlite3 new.cdb
echo "update texts set desc=replace(desc,'⑧效果','⑧的效果');" | sqlite3 new.cdb
echo "update texts set desc=replace(desc,'⑨效果','⑨的效果');" | sqlite3 new.cdb
echo "update texts set desc=replace(desc,'⑩效果','⑩的效果');" | sqlite3 new.cdb

echo "update texts set desc=replace(desc,'①:','①：');" | sqlite3 new.cdb
echo "update texts set desc=replace(desc,'②:','②：');" | sqlite3 new.cdb
echo "update texts set desc=replace(desc,'③:','③：');" | sqlite3 new.cdb
echo "update texts set desc=replace(desc,'④:','④：');" | sqlite3 new.cdb
echo "update texts set desc=replace(desc,'⑤:','⑤：');" | sqlite3 new.cdb
echo "update texts set desc=replace(desc,'⑥:','⑥：');" | sqlite3 new.cdb
echo "update texts set desc=replace(desc,'⑦:','⑦：');" | sqlite3 new.cdb
echo "update texts set desc=replace(desc,'⑧:','⑧：');" | sqlite3 new.cdb
echo "update texts set desc=replace(desc,'⑨:','⑨：');" | sqlite3 new.cdb
echo "update texts set desc=replace(desc,'⑩:','⑩：');" | sqlite3 new.cdb

echo "update datas set ot=replace(ot,'0','4');" | sqlite3 new.cdb
echo "update datas set ot=replace(ot,'1','4');" | sqlite3 new.cdb
echo "update datas set ot=replace(ot,'2','4');" | sqlite3 new.cdb
echo "update datas set ot=replace(ot,'3','4');" | sqlite3 new.cdb

rm -rf ydk
mkdir ydk
java -jar ./jar/cdb_to_ydk.jar new.cdb

cd ydk
ls | xargs -I {} mv -f {} $(date +%m.%d){}
cd ..

mv -f new.cdb ./output/
mv -f ydk/* ./output/deck/

cd ./output/
7z a -mx9 ../$(date +%m.%d).7z *
cd ..
