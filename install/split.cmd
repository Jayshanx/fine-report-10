@echo off
chcp 65001

echo （1/5）创建临时文件夹
mkdir split
copy fine-third-10.0.jar split > nul
cd split

mkdir A
mkdir B


echo （2/5）解压fine-third-10.0.jar，这可能需要一些时间
jar -xf fine-third-10.0.jar
del fine-third-10.0.jar

echo （3/5）分割
move assets A > nul
move cmp A > nul
move /y LICENSE.txt A > nul
move /y NOTICE.txt A > nul
move /y Version.class A > nul
move /y font_metrics.properties A > nul
move /y stylesheet.css A > nul
move orm_2_1.xsd A > nul
move persistence_2_1.xsd A > nul
cd A
mkdir com
cd com
move ../../com/fr ./ > nul
cd ../../

for /D %%D in ("./*.*") do (
    if /I not "%%~nxD"=="B" (
        if /I not "%%~nxD" == "A" (
            move "%%~D" "./B" > nul
        )   
    )
)

move * B > nul

echo （4/5）重新打包
cd A
jar -cfM fine-third-10.0A.jar ./
move fine-third-10.0A.jar ../../ > nul

cd ../B
jar -cfM fine-third-10.0B.jar ./
move fine-third-10.0B.jar ../../ > nul

echo （5/5）删除临时文件夹
cd ../../
rmdir /s/q split
move fine-third-10.0.jar fine-third-10.0.jar_bak > nul
move fine-third-10.0A.jar fine-third-10.0.jar > nul
move fine-third-10.0B.jar fine-third-v2-10.0.jar > nul

echo 分割完成，请移走或删除fine-third-10.0.jar_bak
pause > nul