# 鼠鬚管輸入法

自定义指南
https://github.com/rime/home/wiki/CustomizationGuide



## 推荐的安装方法
`brew cask install squirrel`

+ 更多系统的下载方法
http://rime.im/download/

## 使用方法
在输入状态下，按下control + ` ，可以切换输入法

+ 
输入/xh ，就会输入/xh
使用说明：
https://github.com/rime/home/wiki/UserGuide

## 配置 default.yaml 
`page_size: 8`

## 符号的修改和自定义符号或短语
symbols.yaml中修改

## 外观排版文件

```bash
# weasel.custom.yaml 在0.9.6版以前保存在这个文件中，查看版本号在installation.yaml这个文件中
patch:
  style/horizontal: true      # 候選橫排
  style/inline_preedit: true  # 內嵌編碼（僅支持TSF）
  style/display_tray_icon: true  # 顯示托盤圖標
```

字体
patch:
  "style/font_face": "明兰"  # 字體名稱，從記事本等處的系統字體對話框裏能看到
  "style/font_point": 14     # 字號，只認數字的，不認「五號」、「小五」這樣的
  
## 拼音相关
（加入以下文件后就可以启用中文简体和中文繁体输入的切换）
```bash
# luna_pinyin.custom.yaml

patch:
  switches:                   # 注意縮進
    - name: ascii_mode
      reset: 0                # reset 0 的作用是當從其他輸入方案切換到本方案時，
      states: [ 中文, 西文 ]  # 重設爲指定的狀態，而不保留在前一個方案中設定的狀態。
    - name: full_shape        # 選擇輸入方案後通常需要立即輸入中文，故重設 ascii_mode = 0；
      states: [ 半角, 全角 ]  # 而全／半角則可沿用之前方案中的用法。
    - name: simplification
      reset: 1                # 增加這一行：默認啓用「繁→簡」轉換。
      states: [ 漢字, 汉字 ]
 ```
 
 我的配置文件 [RIME配置文件](https://github.com/0551/AppDevTools/RIME)
 
