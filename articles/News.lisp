(in-package :twb)

;; (defvar *news-topics* (make-hash-table :test 'equal))
;; (defun news-set-topic (topic value)
;;   (setf (gethash topic *news-topics*) value))
;; (defun news-get-topic (topic)
;;   (gethash topic *news-topics*))


(defparameter *news-topics* nil)
(defun news-add-topic (topic)
  (push topic *news-topics*))

(let ((show t))
  (defun news-topic (title time &rest content)
    (let ((id (format nil "collapse~a" (random 10000))))
      `(div (:class "topic card")
            (div (:class "card-header d-flex w-100 justify-content-between")
                 (button (:class ,(concat "btn btn-link" (if show
                                                             ""
                                                             " collapsed"))
                                 :type "button"
                                 :data-toggle "collapse"
                                 :data-target ,(concat "#" id))
                         (h2 () ,title))
                 (small () ,(format nil "更新时间: ~a" time)))
            (div (:class ,(concat "collapse"
                                  (if show
                                      (progn (setf show nil)
                                             " show")
                                      ""))
                         :id ,id
                         :data-parent "#topic-accordion")
                 (div (:class "card-body")
                      ,@content))))))


;; (defun news-to-topic (title time &rest content)
;;   (news-set-topic title (->html (apply #'news-topic title time content))))

(defun news-to-topic (title time &rest content)
  (news-add-topic (->html (apply #'news-topic title time content))))

(defun @ (link &optional title)
    (let ((tle (if title title link))) 
        `(a (:href ,link) ,tle)))

(defun u (&rest rest)
  `(ul () ,@rest))

(defun :- (&rest rest)
  `(li () ,@rest))

(defun news-index ()
  (->html
   (layout-template
    nil
    :title "News 新鲜事"
    :links `((link (:rel "stylesheet" :href "/testwebsite/css/bootstrap.min.css"))
             (link (:rel "stylesheet" :href "/testwebsite/css/font-awesome.min.css"))
             (link (:rel "stylesheet" :href "/testwebsite/css/style.css")))
    :head-rest `((style () "
.btn-link {color: black }
.btn-link:hover {text-decoration:none}
cite {
font-size: 88% }
q {
border-left: 5px rgb(210, 212, 212) solid;
display: block;
padding: 5px 10px 5px 10px;
text-align: justify;
}
q::before, q::before {
display: block;
content: \"\";
}
li pre {
display: inline;
margin: 0;
white-space: pre-wrap;
}
li q {
margin-left: 16px;
}

.zoom {      
-webkit-transition: all 0.35s ease-in-out;    
-moz-transition: all 0.35s ease-in-out;    
transition: all 0.35s ease-in-out;     
cursor: -webkit-zoom-in;      
cursor: -moz-zoom-in;      
cursor: zoom-in;  
}     
.zoom:hover,  
.zoom:active,   
.zoom:focus {
-ms-transform: scale(7);    
-moz-transform: scale(7);  
-webkit-transform: scale(7);  
-o-transform: scale(7);  
transform: scale(7);    
position:relative;      
z-index:100;  
}
"))
    :content
    `(,(site-header)
       (main (:class "content")
             ;; 
             (div (:class "accordion" :id "topic-accordion"
                          :style "font-size: 140%")
                  ;; ,@(loop for v being the hash-values of *news-topics*
                  ;;      collect v)
                  ,@(nreverse *news-topics*)))
       ,(site-footer))
    :scripts `((script (:src "/testwebsite/js/jquery-3.2.1.min.js"))
               (script (:src "https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
                             :integrity "sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
                             :crossorigin "anonymous"))))))

(defparameter *news-topics-guo* nil)

(push
 (u (:- '(small () "2019.2.26")
        (u (:- "郭文(报平安 照片): " (@ "https://www.guo.media/posts/178800")
               '(q () (pre () "2月25号：尊敬的战友们好！你们健身了吗！你在我身上泼水了吗！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.25")
        (u (:- "郭文(短视频): " (@ "https://www.guo.media/posts/178637")
               '(q () (pre () "2月24日：四个人渣……")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/178635")
               '(q () (pre () "2月24日：轻烟姐姐的感觉……我是感同深受……"))
               (u (:- '(pre () "64纪念碑"))
                  (:- `(cite () "輕煙姐姐 @Lydia354217306 : "
                             ,(@ "https://twitter.com/Lydia354217306/status/1099651985987448834")))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=wUIbwiwjCJU"
                           "2019年2月24日文贵谈，法治基金建立的真正目的。")
               '(small () "Youtube")
               (u (:- '(pre () "画  神奇女侠 吻 超人  纽约  (我: 英雄救美 哈哈哈 神奇女侠可厉害了 不止拿下超人 蝙蝠侠也都给拿下了"))
                  (:- '(pre () "宗教 灭佛")
                      (u (:- `(cite () ,(@ "https://zh.wikipedia.org/zh-cn/三武灭佛"
                                           "三武灭佛")
                                    (small () "Wikipedia")))))
                  (:- '(pre () "真正的自治 联邦制"))
                  (:- '(pre () "委内瑞拉  文贵爆料战术  信息 金融"))
                  (:- '(pre () "不要低估 中共的 洗脑 宣传"))
                  (:- '(pre () "未来一周到10天 英国的变化   两到三周 世界有巨大的变化 中美贸易谈判 美国的决定行动  南海 华为  法国 "))
                  (:- '(pre () "王林清"))
                  (:- '(pre () "法治基金 负责任 每一分钱都要花到 目标相关的地方  意义  未来解救中国人 让中国能够和平变革 一个合法的机构"))
                  (:- '(pre () "欧洲国家领导人  看留言  不再去中共国  新疆  挺中和挺共两回事"))
                  (:- '(pre () "香港 占中  缺 钱 有智慧的领导  坚持下去 20亿美元"))
                  (:- '(pre () "大湾区"))
                  (:- '(pre () "捐款比例 钱海外大 国内人数多"))
                  (:- '(pre () "法治基金 开启民智  独立于政治外的法治"))
                  (:- '(pre () "64纪念碑  能灭共?  (我: 是6米+4米)"))
                  (:- '(pre () "建筑 盘古大观 花岗岩  裕达国贸 帷幕墙 Permasteelisa Group"))
                  (:- '(pre () "骇客 郭媒体"))
                  (:- '(pre () "法治基金 成为 未来被全世界各国接受的 代表 新中国的 一个法治机构"))
                  (:- '(pre () "网络公司 20亿美元  委内瑞拉 不到1亿美元"))
                  (:- '(pre () "建国基金"))
                  (:- '(pre () "中共万里长征"))
                  (:- '(pre () "没有一个因64镇压 进监狱 受到法律惩罚的  过去近30年所谓64英雄斗争结果 跑去立碑 消费死人"))
                  (:- '(pre () "崔永元 绝对是了不起的人 是英雄 他已经做得够多了 不要毁人家 (我: 在国内 能够站出来发声已经很了不起了 至于结果 就不是他能控制的了 背后的中共的那些家伙 会利用他做的事 达成它们的目的 甚至扭转整个局面  它们推也好 压也好 都要承担风险  我相信 崔永元暂时不会有什么大问题 但不太可能继续发声) "))
                  (:- '(pre () "不要傻捐 不要勉强 量力而为   法治基金 有更高层的战略意义 不要想的太简单 不仅仅是为了筹钱  连接东西方的桥梁 大家的平台  重要的是 行动"))
                  (:- '(pre () "捐款的金额和人数都重要  郭先生一个人完成不了 必须是大家一起努力  如果人数到达5亿 代表中国的合法政府"))
                  (:- '(pre () "成事 要 钱 和 人  清晰的目标 和 时间表  喜马拉雅 2020年"))
                  (:- '(pre () "压力大  小额捐款"))
                  (:- '(pre () "法治基金的意义 远不止如此"))
                  (:- '(pre () "健身"))
                  (:- '(pre () "华为 看结果"))
                  (:- '(pre () "祈福"))))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/178543")
               '(q () (pre () "2月24号：尊敬的战友们好．感恩感激你们对法治基金的支持和留言！一切都是刚刚开始！
"))
               (u (:- `(cite () "郭文视频: "
                             ,(@ "https://www.youtube.com/watch?v=isBG_9qOzpE"
                                 "2月24号尊敬的战友们好你们健身的吗？一切都是刚刚开始！")
                             (small () "Youtube"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.24")
        (u (:- "郭文(短视频): " (@ "https://www.guo.media/posts/178397")
               '(q () (pre () "
2月23号：美国针对委内瑞拉就是一场爆料革命的战术！这开辟了世界上一个新的战斗模式，《爆料和平战争》爆料战争的成功的前提是．以真打假．以善治恶．加上国家媒体的力量精细合作．必然成功。这是人类迈向和平．远离战争，追求美好未来的最好的手段，一切都是刚刚开始！")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/178388")
               '(q () (pre () "
2月23日：罗宾逊他是英国的未来．真实版的欧洲007……CCP 的送葬者之一……东西方文化优良结合的完美融合于一身的国际政治家！中国文化的粉丝……中国人民的好朋友……拟目以待吧……新的人类．全球的精英唯二标准．……（人1）反CCP……（2）以劳苦大众为核心的价值观！ 一切都是刚刚开始！"))
               (u (:- '(pre () "汤米·罗宾逊(Tommy Robinson) Panorama"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/178351")
               '(q () (pre () "
2月23号：感谢勇推战友对我的夸奖！看来用战友是高人啊！坦白的说，今天是我最近直播我自己最满意的一次，我觉得我的身体．精神状态．还有讲的话题得到了神示……突然间好像天门打开！好多好多过去的想法都蹦了出来！特别享受！后近一个小时的自己的纯天然发挥，我发现了我当一个传道士！可能更好！我要好对着镜子亲亲我自己的脸了，一切都是刚刚开始！郭文贵今天的直播，連線在欧洲的班农、谈宗教 。文贵的知识、阅历、 眼界、对13亿同胞的赤诚奉献之心，无不令人佩服感动。这又是一次足以载入史册的成功演讲。我骄傲我自豪，幸遇这样一位彪炳史册的民族英雄 与我同时代，与我同肩而行。】
"))
               (u (:- `(cite () "勇推 ✊  ✊  ✊ @KzygMichael : "
                             ,(@ "https://twitter.com/KzygMichael/status/1099333299049320448")))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=MjF_DKBDWdw"
                           "2月23日郭文贵和班农谈宗教革命：爆梵蒂冈与中共的交易")
               '(small () "Youtube")
               (u (:- '(pre () "班农先生 在 梵蒂冈 连线"))
                  (:- '(pre () "中梵协议")
                      (u (:- '(pre () "(一些相关报道)"))
                         (:- `(cite ()
                                    ,(@ "https://www.bbc.com/zhongwen/simp/chinese-news-45619984"
                                        "中国梵蒂冈签临时协议 断交六十载能否泯恩仇")
                                    (small () "2018.9.23 BBC中文")))
                         (:- `(cite ()
                                    ,(@ "https://cn.nytimes.com/china/20180926/china-vatican-agreement-appoint-catholic-bishops/"
                                        "中国与梵蒂冈达成历史性协议，欲加强对基督教控制")
                                    (small () "2018.9.26 纽约时报中文网")))))
                  (:- '(pre () "梵蒂冈 教皇召开4天峰会 处理 教会 虐童事件"))
                  (:- '(pre () "现在更重要的是 教皇 一个月前和中共 签的协议 要了解这个协议 及其对被迫害的基督徒的影响 "))
                  (:- '(pre () "秘密协议  违反联合国条约 梵蒂冈是独立国家 需要公开这些协议"))
                  (:- '(pre () "协议内容 中共可自己任命大主教  这是背叛天主教原则的"))
                  (:- '(pre () "行动 要让梵蒂冈 公开这个协议 了解所有条文"))
                  (:- '(pre () "班农先生 将在峰会中 谈论 中共国被迫害的事实"))
                  (:- '(pre () "不服中共的 中共国主教被免职"))
                  (:- '(pre () "梵蒂冈 为什么 向 中共低头?"))
                  (:- '(pre () "1934 方志敏 达能夫妇  1935 薄己  1922 非基督运动"))
                  (:- '(pre () "香港主教陈日君受威胁 辞职  汤汉 接替"))
                  (:- '(pre () "法治基金 采取法律途径 对梵蒂冈施压 公开秘密协议的内容"))
                  (:- '(pre () "本笃十六世 辞职 是否有 中共黑手?"))
                  (:- '(pre () "为本迫害的教徒 提供保护"))
                  (:- '(pre () "灭佛 太平天国 非基督运动 共产党人绑架教会人员 文革"))
                  (:- '(pre () "法治 信仰"))
                  (:- '(pre () "政教分离 钱教分离"))
                  (:- '(pre () "宗教管理"))
                  (:- '(pre () "据了解 政法委 几个月前 将新疆关押的60万人转移到全国各地"))
                  (:- '(pre () "王震 新疆"))
                  (:- '(pre () "美国 自由 法治 GDP"))
                  (:- '(pre () "中共国的 GDP 养老保险 教育 撒币"))
                  (:- '(pre () "你表忠 是因为你害怕中共  懦弱 出卖灵魂人格"))
                  (:- '(pre () "法治基金 要追求 让每一个中国人 未来有开心 健康 安全的生活 活在没有恐惧的日子里"))
                  (:- '(pre () "(1:37:00) 未来是你自己决定的 发自内心"))
                  (:- '(pre () "猪"))
                  (:- '(pre () "大部分华人 在海外 都很优秀"))
                  (:- '(pre () "恶心人"))
                  (:- '(pre () "祈福"))
                  (:- '(pre () "保留好捐款的回执"))
                  (:- '(pre () "让CCP演"))
                  (:- '(pre () "法治基金 验证人心"))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/178350")
               '(q () (pre () "
2月23号：文贵在此衷心地感谢轻烟姐姐一家！万佛万神保佑你们全家人安全．健康！一切都是刚刚开始！【我們一家四口祖孫三代（吉祥四寶），每人捐款法治基金$200，支持文貴先生、班農先生，帶領全球華人走向喜馬拉雅、自由法治，正道主義必勝✊】"))
               (u (:- `(cite () "輕煙姐姐 @Lydia354217306 : "
                             ,(@ "https://twitter.com/Lydia354217306/status/1099114212050141185") ))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/178302")
               '(q () (pre () "
2月23号：我2:30睡的觉5:00起的床，现在开始准备直播！看到战友们捐款和留言，真的是让我充满了动力！无法形容的感激．和感动．一切都是刚刚开始！🙏🙏🙏🙏🙏🙏🙏🙏🙏😘😘😘😘😘😘😻😻😻"))
               (u (:- `(cite () "郭文视频: 捐款留言 "
                             ,(@ "https://www.youtube.com/watch?v=FR7QfnK4pT4" "2月23号：我2:30睡的觉5:00起的床，现在开始准备直播！看到战友们捐款和留言，真的是让我充满了动力！无法形容的感激．和感动．一切都是刚刚开始！🙏🙏🙏🙏🙏🙏🙏🙏🙏")))))
           (:- "郭文(照片 Snow): " (@ "https://www.guo.media/posts/178183")
               '(q () (pre () "2月22日：应战友们的要求发几张SNOW 的照片！我代SNOW 谢谢大家的关心！😂😂😂"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.23")
        (u (:- "郭文(短视频): " (@ "https://www.guo.media/posts/178166")
               '(q () (pre () "
2月22日：UBS 银行,王歧山以及AMAC Aerospace 和马哈迪合作，将把郭文贵先生的私人飞机 ACJ319-115 (CJ) (serial number: MSN5040; Reg: VP-CAD) 强行拍卖给他们自己人，请大家高度关注此事。 UBS bank, Wang qishan and AMAC Aerospace, in collaboration with Mr. Kadri Muhiddin. They will forcibly auction Mr. Guo wengui's private plane ACJ319-115 (CJ) (serial number: MSN5040; Reg: VP-CAD) to their own people, please pay close attention to this matter."))
               (u (:- `(cite () "中文: "
                             ,(@ "https://www.youtube.com/watch?v=vKmCRF3f3yI"
                                 "UMSN5040AMAC Aerospace ACJ319-115 (CJ) (serial number")
                             (small () "Youtube")))
                  (:- `(cite () "英文: "
                             ,(@ "https://www.youtube.com/watch?v=3RqL_TauG9A"
                                 "ACJ319-115 (CJ) (serial number: UBS bank, Wang qisha AMAC Aerospace, in collaboration with王岐山")
                             (small () "Youtube")))))
           (:- "郭文: " (@ "https://www.guo.media/posts/178137")
               '(q () (pre () "
2月22号：尊敬的战友们好！明天的直播！会同时在法治基金的You Tube官方网站同时直播！请大家关注You TUBE这个帐号，谢谢，一切都是刚刚开始！https://www.youtube.com/channel/UCfG2D1ZWTfvp5p3gl5PHmmg"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/channel/UCfG2D1ZWTfvp5p3gl5PHmmg"
                                    "法治基金 Rolfoundation")
                             (small () "Youtube")))))
           (:- "郭文: " (@ "https://www.guo.media/posts/178128")
               '(q () (pre () "
2月22号：佐藤先生一路走好🙏🙏🙏🙏🙏🙏🙏🙏🙏希望到天堂上，祝我们爆料革命成功，感谢制作。这个视频的战友🙏🙏🙏🙏🙏🙏一切都是刚刚开始【佐藤純弥，著名电影高仓健主演的《追捕 》就是他导演的，刚刚去世了 一年多前，当时的日本及全球挺郭会的官方宣传片，至今让人热血沸腾又杂味。。。个人觉得还是一部好的爆料片】"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=39T0VgKpjP4&feature=youtu.be"
                                    "【佐藤純弥，著名电影高仓健主演的《追捕 》就是他导演的，刚刚去世, 一年多前，当时的日本及全球挺郭会的官方宣传片")
                             (small () "Youtube")))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/178120")
               '(q () (pre () "
2月22号：这个桥就是共产党整个体制共产党的体制也如此桥庞大．不堪一击，只要找到他的七寸。他什么都不是！可悲的是很多以为如这个桥一样的CCP棺材政权！万年长青．要依靠他．信任他！我们爆料革命就如这台拆掘车灭掉共产党的这个流氓体制！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/178116")
               '(q () (pre () "
2月22号：找到王岐山！孟建柱！孙力军！的＂亲爹＂了！请看以下下视频！感谢伟大的智慧的战友，一切都是刚刚开始！"))
               (u (:- `(cite () "大明朝 反贪 "
                             ,(@ "https://www.youtube.com/watch?v=1zUrCKyxkMc"
                                 "2月22号：找到王岐山！孟建柱！孙力军！的＂亲爹＂了！请看以下下视频！感谢伟大的智慧的战友，一切都是刚刚开始！")
                             (small () "Youtube")))))
           (:- "郭文: " (@ "https://www.guo.media/posts/178114")
               '(q () (pre () "2月22号：这是谁干的！"))
               (u (:- `(cite () ,(@ "https://therealdeal.com/2019/02/21/exiled-chinese-billionaire-guo-wengui-sues-soho-china-for-300m/"
                                    "Exiled Chinese billionaire Guo Wengui sues Soho China for $300M")
                             (small () "2019.2.21 The Real Deal")))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/178110")
               '(q () (pre () "
2月22号：从王庆林案发生的那天起2019年1月1号文贵就做出了判断！只要是政法委接手的所有案件都是以黑办案！文贵又懵对了！请大家认真看完这个视频！"))
               (u (:- `(cite () "郭文视频: "
                             ,(@ "https://www.youtube.com/watch?v=aEQHMl8N6_8"
                                 "2月22号：从王清林案发生的那天起2019年1月1号文贵就做出了判断！只要是政法委接手的所有案件都是以黑办案！文贵又懵对了！请大家认真看完这个视频！")
                             (small () "Youtube")))))
           (:- "郭文: " (@ "https://www.guo.media/posts/178108")
               '(q () (pre () "
2月22日：让文贵给懵对了！大侄子金正恩在北京时间24号晚上即星期天！进入中国！共在中国行驶两天半时间……横跨中国从北到南，全中国，老百姓的火车都要为他让路，他的火车对面不能有火车！因他的到来必须瘫掉中国的老百姓火车路线！然后返回的时候！再在北京等逗留几天！顺手牵羊再弄个几十亿！此次大侄子南行在北京及很多经停火车站不做长时间逗留！这是14亿中国人的悲哀！全人类的问题都要中国老百姓买单！这是谁做的决定！这和中国梦有什么关系！可怜的同胞们呀！该我们出手的时候了……一切都是刚刚开始！")))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/178100")
               '(q () (pre () "2月22日：文贵拜谢亲爱的战友！🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏"))
               (u (:- '(pre () "郭文视频: 捐款的留言"))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=lYj4EPKehGY"
                           "2019年2月22日文贵报平安谈摩根家族及郭宝胜案情。")
               '(small () "Youtube")
               (u (:- '(pre () "所有给 法治基金 捐款的 战友 一定留好 银行回执  未来可能会有用"))
                  (:- '(pre () "王林清"))
                  (:- '(pre () "法治基金   欺民贼 就像电影2020 上不了船了 就搞破坏"))
                  (:- '(pre () "共产党 一骗就灵  最大武器就是 不要脸 最大工具就是 欺骗性"))
                  (:- '(pre () "北朝鲜 又要去 中共国 骗一把了  买烧鸡 炖好烧肉  大撒币"))
                  (:- '(pre () "不拯救 台湾 香港  就是西方没落的开始 人权正义都不再被相信"))
                  (:- '(pre () "PAG(太盟投资) 海航 律师事务所"))
                  (:- '(pre () "董克文"))
                  (:- '(pre () "华人在西方的形象"))
                  (:- '(pre () "郭宝胜"))
                  (:- '(pre () "魔根"))
                  (:- '(pre () "轻易不把实力量出"))
                  (:- '(pre () "祈福"))
                        (:- '(pre () "前同事  比以前好 九死一生 控制恐惧 利用恐惧")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.22")
        (u (:- "郭文(图片): "
               (@ "https://www.guo.media/posts/178045") " "
               (@ "https://www.guo.media/posts/177981")
               '(q () (pre () "
2月22号：尊敬的战友们好！当我看到这些留言．真的是无法形容被鼓励的那种感激，你们每个人的坚定的支持实现法治中国！没有共产党才有新中国的行动！就是对我们14亿人民未来的真正的投票！体现我们每一个人的人权！民族未来必须是所有人参与的伟大事业！我们每时每刻都在高效的与国际友人！与国内的有良知的战友！党内的很多好战友们！在不同的战线．在瓦解中共！我们感恩上天的帮助．让我们每天都有不同的新战友加入！我们的反共联盟已经越来越大……！明天也就是纽约的星期六的上午8:00北京时间，明天晚上9:00文贵将在郭媒体直播！一切都是刚刚开始！

2月21日：今天的捐款又比昨天多了很多，无论从数量和质量都是让我惊讶不已己！无法形容，我对战友们的感激和被你们鼓励的感受，中国人相信轮回报应，我也相信我们这次的所有我们的行动就是过去70年中国人民所遭受的善恶轮回的一个关键点，那就是除恶迎善的时代已经到来……我感受到了这个巨大的力量，共产党这个棺材应该回他老家了！衷心地感激所有的战友们一切都是刚刚开始！"))
               (u (:- '(pre () "郭文图片: 捐款留言"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/177976")
               '(q () (pre () "
2月21号：尊敬的战友们好！请大家务必小心下面这个微信支付！所谓的代收．给法制基金的捐款，绝对是假的。任何与法治官方网站公布的信息不相同的，请大家都不要相信！法治基金只有官方网站公布的银行收款信息是唯一收款方式！千万不要上当受骗！请战友互相转告！。一切都是刚刚开始！")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/177910")
               '(q () (pre () "
2月21日：法国政府和海航．中信香港．建立类似于国际保安公司，并通过此手段行贿法国总统府的大内总管……．这个报导将揭开C C P在法国的蓝金黄．和在法国高层的腐败！掩盖王建之死！幕后真相，一切都是刚刚开始！"))
               (u (:- '(pre () "Alexandre Benalla"))))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/177902")
               '(q () (pre () "
2月21日，文贵非常荣幸的被我尊敬．摩根先生．及家族邀请看一些从未公布的一些关于中国的信息．关于中国的收藏！过几天我会将相关信息与战友们分享！一切都是刚刚开始！"))
               (u (:- `(cite () ,(@ "https://www.themorgan.org"
                                    "The Morgan Library & Museum")))
                  (:- `(cite () "(我: 不相关 但挺有趣 在此记录) "
                             ,(@ "https://artsandculture.google.com"
                                 "Google Arts & Culture")
                             " 和 "
                             ,(@ "https://archive.org"
                                 "Internet Archive")))))
           (:- "郭文: " (@ "https://www.guo.media/posts/177884")
               '(q () (pre () "郭宝胜谈钱"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=4tw04EmS7GY"
                                    "郭宝胜谈钱．看看这个假牧师如何撒谎．如何无耻与无知无礼")
                             (small () "Youtube")))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=z4BGKKCCE6Q"
                           "2月21日：尊敬的战友们好，你们健身了吗？再次谈法治基金捐款到底捐给了谁！一切都是刚刚开始！")
               '(small () "Youtube")
               (u (:- '(pre () "周六 可能 连线直播"))
                  (:- '(pre () "政治 经济 军事 文化界 过去两三周 正在酝酿着巨大的事件"))
                  (:- '(pre () "买的画 到了 但没时间换"))
                  (:- '(pre () "郭宝胜 剪辑 剪掉对它不利的部分"))
                  (:- '(pre () "打欺民贼 打伪类 因为它们祸害海外华人 损害华人的形象 在西方造成恶劣影响 它们不能代表华人"))
                  (:- '(pre () "这些官司 是为了 让大家看到 真正的法治是是什么"))
                  (:- '(pre () "5天到7天 弗吉尼亚  选择 法官 还是 大陪审团 ?: 大陪审团  3月份"))
                  (:- '(pre () "遣返文贵 相关的 官员"))
                  (:- '(pre () "法治基金 捐款 量力而行"))
                  (:- '(pre () "支持"))
                  (:- '(pre () "上天在看 良心在看"))
                  (:- '(pre () "法治基金 不是捐给郭文贵 是捐给中国的未来 任何个人不会动一分钱"))
                  (:- '(pre () "祈福")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.21")
        (u (:- "郭文(短视频): " (@ "https://www.guo.media/posts/177696")
               '(q () (pre () "
2月20号：只要有真情只要有真爱，只要坚定自己的信念！没有什么敌人可以打败你！这就是永远不变的法则！是最大的力量！一切都是刚刚开始！"))
               (u (:- '(pre () "郭文视频: 斑马从豹口中救出同类"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/177672")
               '(q () (pre () "
2月20号：每一个战友的捐款和对文贵的热情留言，都让文贵感激万分！这是信任。这也是责任！这也是文贵的动力。今天的捐款一直就没停过！这个一笔笔地捐款，我更是感慨万千，我们中国人实在是太可怜了，我们没有希望！没有安全！没有公平，没有未来！活在恐惧里的日子将一去不复返！法治基金是属于14亿中国人民我们共同的家！和共同走向未来的舞台！每一分钱都会使用到与中国实现法治信仰自由有关！一定以最高效的的行动，最高质量的结果！干倒CCP！为奋斗目标！希望战友们！能量力而行！千万不要勉强！一切都是刚刚开始！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/177641")
               '(q () (pre () "从质询视频中看到的郭文贵起诉郭宝胜的七个原因"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=H2Fn3xDU8ew"
                                    "从质询视频中看到的郭文贵起诉郭宝胜的七个原因")))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/177638")
               '(q () (pre () "
2月20日：共产党与海外欺民贼的所谓民主民运人士的战友情都是一样的结果！背叛．欺骗．利用．出卖．灭口．灭九族……")))
           (:- "郭文: " (@ "https://www.guo.media/posts/177632")
               '(q () (pre () "
2月20号：这个卑鄙可耻的．假牧师郭宝胜．竟然将我的庭讯视频剪辑后才发出！像我指正过宝盛的最关键的部分剪掉，这是何等的龌龊以可耻！文贵从来不干那个卑鄙的事情！百分之百推出郭宝的的视频， 不管郭宝剩说什么，我都将法庭提供的视频百分之百的真实地推动出，这是做人和对社会尊重的起码的底线！就这一点．宝盛大骗子都做不到！ 这就是高低之分，好坏只别！我深信伟大的战友们．和有良知的人呢们！能分出这是何等的性质，在这方面郭宝胜假牧师都造假．他还有什么能是真的！在视频中．几乎都是在撒谎，任何有良知的人随便一看就知道郭宝盛是谎言狂！卑鄙可耻的牧师！更不要谈民主，这样的人竞然能上视频能给别人上课……上天一定会惩罚这种可悲的小人，一切都是刚刚开始！"))
               (u (:- `(cite () "文贵接受郭宝胜律师庭外问询视频（无删减版）"
                             ,(@ "https://www.youtube.com/watch?v=mINxRPaiL0o"
                                 "-1")
                             " "
                             ,(@ "https://www.youtube.com/watch?v=qOQ_68KiDoQ"
                                 "-2")))
                  (:- `(cite () "假牧师郭宝胜被文贵律师庭外审问视频（无删减版）"
                             ,(@ "https://www.youtube.com/watch?v=rlmCci0DncE"
                                 "-1")
                             " "
                             ,(@ "https://www.youtube.com/watch?v=aPrMytTUJgA"
                                 "-2")
                             " "
                             ,(@ "https://www.youtube.com/watch?v=vaaNspFTp6o"
                                 "-3")))))
           (:- "郭文: " (@ "https://www.guo.media/posts/177608")
               '(q () (pre () "
2月20号：尊敬的战友们好．UBS是与CCP合作的巨大的国际犯罪组织！他今天的出事儿，只是刚刚开始，法国将有CCP贿赂法国政客重大政治丑闻！法国政府也将有重大变化，CCP在法国制造的腐败以经深度影响法国政局的详细信息将被公布出来！海航在法国的犯罪以及王建被杀的真相即将曝光！咱们拭目以待！一切都是刚刚开始！"))
               (u (:- `(cite () 
                             ,(@ "https://www.reuters.com/article/us-ubs-trial-fraud/ubs-to-appeal-after-fined-4-5-billion-euros-in-french-tax-fraud-case-idUSKCN1Q91DR"
                                 "UBS to appeal after fined 4.5 billion euros in French tax fraud case")
                             (small () "2019.2.20 Reuters"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.20")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/177451")
               '(q () (pre () "
2月19日： 看看这些与吴征及盗国贼同案犯的名单吧！！ 吴征．帮孟建柱孙立军持有脏钱．及洗钱的资产离岸公司．还有e租宝．泛亚．钱被转移的公司！这家公司是关键的公司之一！量子挖掘机的战友们查查，这家公司的个签名人是谁！神秘的背后往往就是肮脏，一切都是刚刚开始！"))
               (u (:- '(pre () "郭文图片: Ideanomics, Inc  Ownership Information"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/177449")
               '(q () (pre () "
2月19日：吴征．帮孟建柱孙立军持有脏钱．及洗钱的资产离岸公司．还有e租宝．泛亚．钱被转移的公司！这家公司是关键的公司之一！量子挖掘机的战友们查查，这家公司的个签名人是谁！神秘的背后往往就是肮脏，一切都是刚刚开始！"))
               (u (:- '(pre () "郭文图片: Advantech Capital Investment II Limited,  Wong Kok Wai"))
                  (:- `(cite () ,(@ "https://fintel.io/doc/sec/1728716/000110465919007729/a19-4671_1sc13ga.htm"
                                    "IDEX / Ideanomics, Inc. / Advantech Capital Ii L.p. - SC 13G/A")
                             (small () "2019.2.13 Fintel")))))
           (:- "郭文: " (@ "https://www.guo.media/posts/177447")
               '(q () (pre () "
2月19日：看来全世界的宗教信仰都在行动中！CARDINAL SINS Steve Bannon and the Pope’s Sex-Abuse Circus Are Coming to Rome"))
               (u (:- `(cite ()
                             ,(@ "https://www.thedailybeast.com/steve-bannon-and-the-popes-sex-abuse-circus-are-coming-to-rome"
                                 "Steve Bannon and the Pope’s Sex-Abuse Circus Are Coming to Rome")
                             (small () "2019.2.19 The Daily Beast"))
                      (u (:- `(cite () "中文翻译: "
                                    ,(@ "https://spark.adobe.com/page/EKAehsv7vJgDm/"
                                        "红衣主教的罪 史蒂夫·班农和教皇的性虐待马戏团即将来到罗马")))))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/177432")
               '(q () (pre () "
2月19号！看看伟大的鲍彤鲍老和马云吴征这个流氓天地之差别……一切都是刚刚开始！"))
               (u (:- '(pre () "郭文视频: 战友捐款留言 ")
                      (u (:- '(pre () "马云说\"钱是世界上 最容易得到的事情\" XXXX  国贸大厦外哭"))
                         (:- `(cite () "鲍彤 Bao Tong @baotong1932 : 最强烈关注美国总统昨天的演说——论社会主义。 "
                                    ,(@ "https://twitter.com/baotong1932/status/1097852900317978624")
                                    (small () "2019.2.19 Twitter")))
                         (:- '(pre () "吴征 七星云 改名 Ideanomics  辞去 康州大学 West Hartford 校园 科技中心 The fintech ideanomics CEO 职务  亏损  洗钱")
                             (u (:- `(cite () "hotmoon @hotmoonliuye : "
                                           ,(@ "https://twitter.com/hotmoonliuye/status/1097724637419454464")
                                           " "
                                           ,(@ "https://twitter.com/hotmoonliuye/status/1097722236117561350")
                                           (small () "2019.2.18 Twitter")))))))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=Fn4nWc6idMQ"
                           "02.19.19")
               '(small () "Youtube")
               (u (:- '(pre () "听说 中南坑 里 突然欢呼雀跃  不是元宵节的原因 参加中美谈判的人大喝酒 庆贺 (我: 壮行吗? 赴美前 先喝点酒 壮壮胆 打打气  风萧萧兮 易水寒 壮士一去兮 不复还  探虎穴兮 入蛟宫 仰天呼气兮 成白虹  哈哈哈哈哈哈哈哈哈) "))
                  (:- '(pre () "日本 捐款 太多了 感谢"))
                  (:- '(pre () "棺材之说 共产主义  没准备 灵感就这么来了"))
                  (:- '(pre () "补看了视频 最震惊的就是Sara 战友之声的节目办的太好了 啸天点评 楚门看世界 墙头会  飞速提高 片头效果"))
                  (:- '(pre () "郭宝胜 放出的 郭先生接受律师庭外问话的视频")
                      (u (:- `(cite () "(我: 它放出的视频剪碎了 不在此列出 后面这个链接是完整版) "
                                    "文贵接受郭宝胜律师庭外问询视频（无删减版）"
                                    ,(@ "https://www.youtube.com/watch?v=mINxRPaiL0o"
                                        "-1")
                                    " "
                                    ,(@ "https://www.youtube.com/watch?v=qOQ_68KiDoQ"
                                        "-2")))
                         (:- `(cite () "假牧师郭宝胜被文贵律师庭外审问视频（无删减版）"
                                    ,(@ "https://www.youtube.com/watch?v=rlmCci0DncE"
                                        "-1")
                                    " "
                                    ,(@ "https://www.youtube.com/watch?v=aPrMytTUJgA"
                                        "-2")
                                    " "
                                    ,(@ "https://www.youtube.com/watch?v=vaaNspFTp6o"
                                        "-3")
                                    (small () "2019.2.19 Youtube")))))
                  (:- '(pre () "有五毛跟 信息就有价值"))
                  (:- '(pre () "有海外这些人 相关信息 请给郭先生  特别是它们 获取的美国身份 和 带到美国的钱 的合法性 相关的信息"))
                  (:- '(pre () "什么都是中国老百姓出钱 最可怜"))
                  (:- '(pre () "(33:50) 与董事的争执  法治基金 在7月1日前 如果给大家的目标 没有完成 谁动一分钱 谁就是郭先生的敌人  法治基金 有1块美金被任何人享受了 去吃喝了 天诛地灭"))
                  (:- '(pre () "老领导 \"好言相劝\"  朋友的好心相劝"))
                  (:- '(pre () "想想这两年发生太多事   纽约见刘彦平 孙立军在华盛顿 遣返  能相信中共?  骗贷罪 罚款130亿美元"))
                  (:- '(pre () "法治基金 戳痛 中共了"))
                  (:- '(pre () "昨天道歉 是 对 说话的方式和语气 特别是带了脏字  不包括 维护Sara和木兰的部分 这一点都不过 (我: Sara做了那么多事 一点错就被攻击 太过分了 纠正下不就完了  我们要去鼓励 去效仿 去做更多更多的事)"))
                  (:- '(pre () "路德 现在多棒啊"))
                  (:- '(pre () "老领导说 看你那些战友 要真把中南海的权力交给这些战友 那比这还烂 (我: 哇 老领导别光说啊 你们倒是交权啊 比比看 到底是更烂还是更好 不是说实践是检验真理的唯一标准嘛  无语啊 现在中国这样不就是你们滥权的结果吗 死守着权力 不被约束 享受着特权特供 无法无天)"))
                  (:- '(pre () "没人是完美的"))
                  (:- '(pre () "郭先生 夸人是非常真实的 真是不知道那些人是恶心人"))
                  (:- '(pre () "任何 法治基金 的信息 以官网为主 以及 被委托的郭先生的郭媒体账号  不接受任何人 代收代付捐款"))
                  (:- '(pre () "(1:02:00) 郑州 裕达国贸酒店  盘古 政泉  青峰看守所  吹牛也要看历史"))
                  (:- '(pre () "法庭 展示个人的最佳舞台 让中国人走向法治 最好的教科书"))
                  (:- `(cite () "比尔盖茨 当年(1998.8.27) 接受 律师庭外问话的视频: "
                             ,(@ "https://www.youtube.com/watch?v=m_2m1qdqieE"
                                 "United States v. Microsoft: Deposition by Bill Gates, part 1.")
                             (small () "2012.5.3 Youtube")))
                  (:- '(pre () "刘刚"))
                  (:- '(pre () "谢谢翻译的文件 省了不少钱"))
                  (:- '(pre () "玩假的必死无疑"))
                  (:- '(pre () "郑祺 赵丽珍 一车钱 海航  刘特佐 美国司法部腐败 (我: 哈哈哈 摩根 实际上郭先生之前就点到了(当年 老人家 摩根中心 1.14视频里) 只是没直说 大家都已经知道了)"))
                  (:- '(pre () "今天本来还有两个事要说"))
                  (:- '(pre () "看了两部电影 女主角  肖建华 安排 领导 香港 睡 女明星 800万  王岐山设局"))
                  (:- '(pre () "法治基金 法律上开始行动 "))
                  (:- '(pre () "七哥的故事说不完"))
                  (:- '(pre () "捐款 不要勉为其难 做你自己喜欢 又能做的事  不要做自己喜欢 不能做的事  不要做自己喜欢 做不到的事"))
                  (:- '(pre () "祈福 战友"))
                  (:- '(pre () "见过无数富豪 不就是白天打高尔夫 打地上的洞 晚上去玩女人 打人家身上的洞 喝点好酒 玩点好车 有啥呢 没啥了不起的"))
                  (:- '(pre () "什么让自己最快乐 ? 信仰 理想 还有拥有这样 彼此信任支持的 战友们 .. 活的不平凡 不庸俗"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/177407")
               '(q () (pre () "
2月19号：尊敬的战友们好！1小时内文贵在国媒体报平安直播，衷心感谢所有的留言和捐款的战友们！一切都是刚刚开始！"))
               (u (:- '(pre () "郭文图片: 捐款的留言")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.19")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/177292")
               '(q () (pre () "
2月18日：我们能在CCP在全球发起的媒体大封锁中．大外宣打击下．沉默的国家力量全力行动下．却活下来没有被闭上嘴……我们还能继续发声！这是爆料革命中最不容易的事情之一……没有战友们的支持是不可能做到的！感恩所有的战友们！一切都是刚刚开始！"))
               (u (:- `(cite () ,(@ "https://cn.nytimes.com/china/20190218/uighurs-china-internment-camps/"
                                    "“我也是维吾尔人”：海外维族人要求公开失踪亲属下落")
                             (small () "2019.2.18 纽约时报中文网"))
                      (u (:- `(cite () "MeTooUyghur 运动 (维吾尔语: MenmuUyghur) "
                                    ,(@ "https://twitter.com/hashtag/MeTooUyghur?src=hash")))))))
           (:- "郭文(短视频):" (@ "https://www.guo.media/posts/177261")
               '(q () (pre () "
2月18日：共产党对爆料革命的恐惧已经到了让他们快要崩溃的边缘了，看他们如何对安红女士家人的．就知道他们有多么的害怕爆料革命！他们又有多么的可耻……他们的恐惧就是我们的武器！一切都是刚刚开始！"))
               (u (:- `(cite () "安红橘绛轩/MaryAnBupa @maryann_3040 "
                             ,(@ "https://twitter.com/maryann_3040/status/1097623027494211584")
                             (small () "2019.2.18 Twitter")))))
           (:- "郭文(图片 短视频): "
               (@ "https://www.guo.media/posts/177240") " "
               (@ "https://www.guo.media/posts/177227")
               '(q () (pre () "
2月18日：衷心感谢每一位战友们的留言和对法治基金的支持！

2月18日：🙏🙏🙏🙏🙏🙏🙏🙏🙏万分感激所有的战友们！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/177225")
               '(q () (pre () "
2月18日：视频中的这个姑娘不简单．爆料革命最大的受益者将是80．90后……中国人的未来将由他们掌握……"))
               (u (:- '(pre () "郭文视频: 一个90后的演讲"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/177211")
               '(q () (pre () "
2月18号：万万分的感激这每天都有数以万计的战友们给法治基金的捐款！每一笔捐款与留言！对我来讲，是无穷无尽的力量．文贵，一定竭尽全力不惜代价，让中国人实现法治中国！信仰的自由！干倒共产党CCP！让中国老百姓不需要吃草，不需要过猪狗不如的日子！不再当那几个家族的奴隶……一切都是刚刚开始！"))
               (u (:- '(pre () "郭文图片: 法治基金 捐款 留言"))))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/177207")
               '(q () (pre () "2月18日：尊敬的战友得好！猜猜这是谁送的花？一切都是刚刚开始！")))
           (:- "郭文(保平安 照片): " (@ "https://www.guo.media/posts/177192")
               '(q () (pre () "2月18日：尊敬的战友们好，你们健身了吗？你们我身上泼水了吗？一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.18")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/177069")
               '(q () (pre () "
2月17号：章女士就是真正的中国人的样子，就是我们追求的喜马拉雅山上所有要聚集的中国人的样子，他这样的人我就是会佩服，我就是尊重，就像尊重鲍彤鲍老一样！她是我们中国人的骄傲，一切都是刚刚开始！"))
               (u (:- `(cite () "广西师大出版社——2012【理想国文化沙龙】系列讲座: "
                             ,(@ "https://www.youtube.com/watch?v=dH5s8rsdcIM"
                                 "【资中筠、章诒和、杨照谈】—（时代与人）")
                             (small () "2015.8.18 Youtube ")))
                  (:- '(pre () "(我: 这个视频 我以前看过)"))))
           (:- "郭文: "
               (@ "https://www.guo.media/posts/177058") " "
               (@ "https://www.guo.media/posts/177055")
               '(q () (pre () "
2月17日：赵丽贞的爹是安全部的副部长．曾经在海南安全厅厅长！所以她才和郑祺向那个金融老大说．她是王健陈峰海航的股东……所以才有动机几次要闯入我家……欲图不轨！这是大鱼……订住钱．钉住她们的爹和娘……五毛多的地方必有妖怪……文琥美女太厉害了👍一切都是刚刚开始！

二月十七号：有这样的战友．量子挖掘机水平的战友．是什么样的盗国贼我们灭不了不了啊！衷心心的以你们为荣！万分的感谢！看来找爹活动还没结束，就要开始找娘了C C P创造了世界上前无古人的最荒唐的故事！全民帮党找爹！全民帮党找娘！一切都是刚刚开始！
"))
               (u (:- `(cite () "@chenwz444 : "
                             ,(@ "https://twitter.com/chenwz444/status/1095164290246500353")
                             (small () "2019.2.11 Twitter")))))
           (:- "郭文: " (@ "https://www.guo.media/posts/177034")
               '(q () (pre () "
2月17日：这痘痘到底被政事小哥藏那了呢？✊✊✊☺️☺️☺️🥵🥵🥵"))
               (u (:- `(cite () 
                             ,(@ "https://www.youtube.com/watch?v=7s9BMIQdBHU"
                                 "🤘🏿:痘她叔有话说！")
                             (small () "2018.5.17 Youtube")))))
           (:- "郭文: " (@ "https://www.guo.media/posts/177016")
               '(q () (pre () "
太美了，太感人了！国内同胞为文貴先生和海外战友们所制作的视频，所奉献的歌曲,荡气回肠！您们才是最勇敢的！CCP必灭👍🌻🌹🤝✊🙏🙏🙏 youtu.be/U77kHYZWuow twitter.com/PingSereanRyan…
"))
               (u (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=U77kHYZWuow&feature=youtu.be"
                                 "祈祷 2019 2 8")
                             (small () "2019.2.14 Youtube")))))
           (:- "郭文: " (@ "https://www.guo.media/posts/176997")
               '(q () (pre () "
2月17号：这个视频可以看出什么叫以黑治国．中南坑的人玩女人，玩处女一完全家三代！那叫谈恋爱！他们可以去玩中央电视台的任何一个女人，他们可以玩儿任何一个明星．那叫性趣！而普通的老百姓的生殖器的这一基本人权……只要是两厢情愿……任何公权力无权干涉．但是CCP却要他们说了算，说白了就是敲诈勒索，就是为了钱，这和道德和法治没有任何关系，这就是真正的以警治国．以生殖器治国……我们必须砸烂这个邪恶的共产党体的体制……我们的身体．是由我们的上天．父母．赐予给我们的！最美好的礼物！我们生身体如何使用由我们按上天的美意和人间的法律！由我们自己说了算……一切都是刚刚开始！"))
               (u (:- '(pre () "郭文视频: 警察抓嫖 (我: 警察不是法官 不能直接说人家就是嫖娼 警察违法执法)"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/176960")
               '(q () (pre () "
2月17号：很高兴地看到台湾民视！能为台湾的人民！和台湾的未来！台湾的安全！说点良心话！干点人事！台湾在未来的两三年内会因C C P的倒台！国际形势的变化！今天站在台湾政坛上的人，绝大多数都会消声匿迹！台湾将迎来一个新的辉煌的未来！一切都是刚刚开始！"))
               (u (:- '(pre () "郭文视频: 台湾民视 报道 文贵看春晚 爆出的 中共渗透台湾的文件"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/176955")
               '(q () (pre () "
2月17日：万分感谢您谷张战友！🙏🙏🙏🙏🙏🙏🙏🙏🙏😘😘😘NSDD 75👍👍👍"))
               (u (:- `(cite () "谷張 8∞ @from8tolying8 : "
                             ,(@ "https://twitter.com/from8tolying8/status/1096984470673125376")))
                  (:- `(cite () "NSDD 75"
                            ,(@ "https://en.wikipedia.org/wiki/National_Security_Decision_Directive_77"
                                "National Security Decision Directive 77 - Wiki")))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=4RgMnSsJ_pw"
                           "2019年2月17日:文贵再谈法治基金的目的和中美之间即将发生的大事。")
               '(small () "Youtube")
               (u (:- '(pre () "老虎不在家 猴子称霸王 (我: 哈哈哈 随便长知识 中国的典故  山中无老虎 猴子称大王  查到对应英文: When the cat is away,the mice will play.  发现这些中国的典故 故事 寓言 等等 在网上 没看有一个靠谱的网站收录整理)"))
                  (:- '(pre () "昨天 失态 太情绪化 有些言语不当  在此道歉"))
                  (:- '(pre () "压力特别大  每一分捐款 都是血 都是依靠 是良知"))
                  (:- '(pre () "希望打到陪审团 以身说法 以身试法(我: 哈哈哈 以身试法 是贬义词) 让中国人能够看到真正的司法"))
                  (:- '(pre () "(19:00) 接昨天 班农先生 来时 的 话题"))
                  (:- '(pre () "美国 当年 对付 苏联的 3招: 1 经济制裁 监控钱  2 人才计划"))
                  (:- '(pre () "美国的养老基金 是 中共3F方案 核心的一点  中共国在美上市公司 基本上都有 美国养老的资金 教育基金 退休基金"))
                  (:- '(pre () "黑河 前苏联  18条牛仔裤 换 一拉达车  因制裁 吃老鼠肉 没油  亲身经历 当年到前苏联的国人 好多坏人 坑前苏联人"))
                  (:- '(pre () "普京一个手下 到中共国 都是 自带食物 不过夜 她说不相信中共国的食品"))
                  (:- '(pre () "中共国 在美上市公司 市值1.2万亿多 通过美国的基金 影子银行 其它渠道 拿走1万亿 其中好多是 养老基金 退休基金"))
                  (:- '(pre () "3个不可思议")
                      (u (:- '(pre () "美国纽约证监会 没有 要求 这700多家上市公司和几千家拿了基金钱的中共国公司(风投) 提供 股东 实际控制人 资金流向 项目的真实性 提交文件资料的透明度 等 "))
                         (:- '(pre () "有报表 没有审计"))
                         (:- '(pre () "股东 股权 的变化  和 在美国期间 所有合作签署的文件  没有审计"))))
                  (:- '(pre () "美国证监会 要是 现在查这些事 会怎么样 ?: 灾难 "))
                  (:- '(pre () "过去一年 中共国 国家借贷 1.2万亿美元 (我: 大撒币)"))
                  (:- '(pre () "过去一年 在欧美 非美元洗钱 1.3万亿美元 (我: 盗国贼)"))
                  (:- '(pre () "刘特佐 昨晚 在 日本嫖妓 被打了"))
                  (:- '(pre () "香港私人基金增加5倍 在瑞士德国等 非美元资产的国家 私人信托 家族信托 增加了1百多倍"))
                  (:- '(pre () "中共 信息战  渗透  苏斌  空客")
                      (u (:- `(cite () 
                                    ,(@ "https://www.bbc.com/zhongwen/simp/world/2016/07/160714_us_china_espionage"
                                        "涉盗取美国军机资料中国商人苏斌被判囚")
                                    (small () "2016.7.14 BBC 中文")))))
                  (:- '(pre () "西方 华人组织"))
                  (:- '(pre () "电影里 只有共产党才能 救地球  天底下 最大的 核武器 就是 不要脸 (我: 哈哈哈 烂地球)"))
                  (:- '(pre () "(59:30) 金正恩 见川普总统前 估计还要去中共国  他见川普总统 但却是中共国人买单"))
                  (:- '(pre () "中共 对 北朝鲜 的影响 是 0 (我: 中共你太牛了)"))
                  (:- '(pre () "郭先生 准备做一个视频 聊聊金家的事  不能老去中国弄老百姓的钱"))
                  (:- '(pre () "(1:04:36) 法治基金 责任"))
                  (:- '(pre () "(1:07:20) 梵蒂冈 开除 美国大主教")
                      (u (:- `(cite ()
                                    ,(@ "https://www.nytimes.com/2019/02/16/us/mccarrick-defrocked-vatican.html"
                                        "Pope Defrocks Theodore McCarrick, Ex-Cardinal Accused of Sexual Abuse")
                                    (small () "2019.2.16 The New York Times")))))
                  (:- '(pre () "上任教宗为什么请辞 ? 中共干的"))
                  (:- '(pre () "香港的陈主教 曾荫权"))
                  (:- '(pre () "7月以前 会发生 更大的事"))
                  (:- '(pre () "(1:13:50) 法治基金 行动前 一分钱都不能动  捐款 量力而为 数量第一 其次捐款额  必须干成事  用钱的责任"))
                  (:- '(pre () "(1:15:00) 牛人 说 台湾 绝不会允许 共产党踏进一步 香港必须兑现一国两制 这不只是美国的利益 这是人类共同的利益  只要不打开防火墙 跟共产党什么合同都不行"))
                  (:- '(pre () "(1:15:35) 中美贸易谈判 刘鹤 国债  刘鹤说 网络会开 但只针对美国 国人还是得控制"))
                  (:- '(pre () "防火墙 炸掉  光靠技术不行  美国"))
                  (:- '(pre () "爱华 爱中 救华 救中"))
                  (:- '(pre () "上天 敬天"))
                  (:- '(pre () "祈福")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.17")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/176793")
               '(q () (pre () "
2月16号：看来金正恩大侄子也学会打太极了……真是高手啊，看来大侄子又要去北京转一圈了……所有的骗局当中，惟一一个买单的就是中国老百姓，不管是北朝鲜，还是越南，还是美国．都是受益者！唯一受伤的．受害的．受骗的．掏腰包的．就是中国老百姓……我们中国老百姓是世界上最相信骗子和虚伪的民族！因为我们被剥夺了信仰的权利！宗教的自由！没有信仰，没有宗教．所以我们看不到真相，所以我们被人掌控了历史．被人操纵了现在！当然人家要决定我们的未来！我们才会一切皆输！因为我们心中无．神心中无神．便没有辩证．真．善．假．恶．的基本能力！大家拭目以待吧，一切都是刚刚开始！"))
               (u (:- '(pre () "川普总统与金正恩委员长 第二次会谈 2.27-28 河内 "))))
           (:- "郭文: " (@ "https://www.guo.media/posts/176765")
               '(q () (pre () "
2月16号：这是其中之一……我我见的人不是他……他也是曾经的非常非常厉害的关键人物之一……现在新成立的超级团队．要比1982年的力量强大的多……请大家高度关注，3月1号到7月1号发生的一系例的重大事件！大家会看到你在电影上从没有看过的……发生，并且与我们爆料革命和战友们息息相关……宗教．经济．文化．网络．军事……今天很多话没有说完……改日再向大家报告！一切都是刚刚开始！【1982年5月24日，羅納德 雷根總統告訴國家安全委員會，蘇聯的經濟已經套上了枷鎖，他們在市場上開始賣老鼠肉，“ 他認為，“現在是懲罰他們的時候了”。 Could the Soviet Union survive if rat meat was a growing food staple? 如果王岐山都準備讓14億人民做好吃草的準備，這看上去連老鼠肉都沒有啊！！】"))
               (u (:- `(cite () "谷張 8∞ @from8tolying8 : "
                             ,(@ "https://twitter.com/from8tolying8/status/1096927905760903168")))))
           (:- "郭文: " (@ "https://www.guo.media/posts/176764")
               '(q () (pre () "
2月16号：尊敬的战友们好！看到你们这些捐款下的留言！让我万分感动，万分感激．万分荣幸……不知该如何向你们表达我的感受！文贵一定不会辜负你们和家人的对我的期望！和支持！直播完毕后我与班农先生及法治基金的团队！一直开了十几个小时的会！法治基金将是我们14亿同胞真正的未来！我们会通过法治基金追求到我们想要的！我们的喜马拉雅目标！法治的！信仰自由的中国！一切都是刚刚开始！")))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=g2-J0fU5z-U"
                           "20190216 文贵和班农先生关于法治基金和法治公会基金的解读")
               '(small () "Youtube")
               (u (:- `(cite () "法治基金和法治公会基金常见问题: "
                        ,(@ "https://rolsociety.org/faq-chinese.php")))
                  (:- '(pre () "(26:00) 有种的来"))
                  (:- '(pre () "公益 与 慈善 不同 "))
                  (:- '(pre () "质疑的人"))
                  (:- '(pre () "法治基金 缘由 班农先生提出"))
                  (:- '(pre () "木兰 Sara"))
                  (:- '(pre () "法治基金 捐款 一切遵循自愿"))
                  (:- '(pre () "太多人捐钱了 难以想象的数字 压力特别大 责任太大"))
                  (:- '(pre () "任何捐款 现在不能动 动任何一分钱的时候 郭先生一定公告大家钱开始动了"))
                  (:- '(pre () "法治基金 使命 唯一的希望"))
                  (:- '(pre () "教宗 梵蒂冈 宗教界 正在巨变"))
                  (:- '(pre () "如何保护 受迫害的国人  庇护"))
                  (:- '(pre () "让中国人 受到 尊重"))
                  (:- '(pre () "不反华 不反中 反中共"))
                  (:- '(pre () "所有 法治基金 相关信息 以法治基金官网为准"))
                  (:- '(pre () "(1:14:00) 休息时间 视频: 法治基金捐款介绍  川普总统国情咨文:美国永不会成为社会主义国家 1120发布会:法治基金"))
                  (:- '(pre () "(1:26:15) 郭先生就是郭先生 真实 不接受领导 你做到了就听你的"))
                  (:- '(pre () "\"良言相劝\"  各扫门前雪 秦朝 商鞅"))
                  (:- '(pre () "棺材 共产主义  造的不喜欢 卖的不喜欢 买的不喜欢 用的也不喜欢"))
                  (:- '(pre () "(1:34:00) 前几天见的人 金融安全小组 12人  苏联 油气管道  制裁"))
                  (:- '(pre () "中共国 在 美国上市公司700多(总价值1.2万亿美元 从美国基金里拿到的钱是 ..) 日本4家"))
                  (:- '(pre () "(1:39:00) 班农先生来了 (我: 开心 但是 郭先生说到关键点上呢 我好纠结啊 虽然不是处女座  班哥哥来了 翻译奶奶也上线了)"))
                  (:- '(pre () "班农先生今天早上 和 纽约 的有影响力人士开会 给他们介绍 法治基金的愿景"))
                  (:- '(pre () "中共不让中国有法治  中国人只要在有法治的地方 就能获得成功 香港就是最好的案例"))
                  (:- '(pre () "法治基金 目标 : 调查 和 保护"))
                  (:- '(pre () "世界正在知道 真实的 中国  明白中共的谎言"))
                  (:- '(pre () "班农是向全世界 敲响警钟的第一人 关于中共对世界的威胁"))
                  (:- '(pre () "班农先生 会为世界带来更大贡献 我们很快就会看到"))
                  (:- '(pre () "郭先生 告诉 老领导 : 防火墙 只要打开6个月 中共就灰飞烟灭 (我: 用不了那么久 如果提前准备好 将相关的信息梳理 用简明的方式让人们快速传播了解 不到3个月就基本完了)"))
                  (:- '(pre () "加上 美国关闭金融外汇渠道 香港港币脱钩 取消自由贸易区 查封海外资产 它们连6个月都没有 "))
                  (:- '(pre () "更重要的是中国人自己争取自己的自由 现在国内所能做的 就是 把真实的信息 传递出来 让世界能够了解 关注"))
                  (:- '(pre () "纽约州 的 监管 是 最严格的"))
                  (:- '(pre () "捐款留言 能不能把郭媒体的bug修下 (我: 哈哈哈 我兔整理时 也深受虫虫之苦)"))
                  (:- '(pre () "影响 战友 生活 或 会给你带来压力 的 捐钱  求求你们 千万千万不要"))
                  (:- '(pre () "帮助法治基金 不仅仅是可以通过金钱的捐赠 也可以 看直播 传播真相"))
                  (:- '(pre () "消灭中共 不是一个人能做到的 是团体的力量 大家的力量"))
                  (:- '(pre () "捐款数量 难以想象  数量和质量一样重要  要通过 法治基金 给大家一个可以相信的家 一个希望 给大家一个未来 一个可以依靠的说话的 找出真相的 保护自己安全的 一个平台 此外才是捐款 等到那天举手的时候 共同行动 千万别搞错连"))
                  (:- '(pre () "需要战友 强烈的捐钱 但要力所能及 因为捐钱数量 在未来法治革命后 最大的国际影响力 合法的权力 有5亿人捐款 就是合法政府了"))
                  (:- '(pre () "没有捐不出去的钱 没有行不了的善"))
                  (:- '(pre () "我们的战友 不会像中共的外交官那样 永远不会说错话  Sara和木兰是好战友 我们不要只会吹牛的大咖"))
                  (:- '(pre () "不要清算所有人  大部分人都应继续工作"))
                  (:- '(pre () "中美贸易 就是扯淡 什么协议也解决不了 中共犯下的恶行"))
                  (:- '(pre () "现代化 超限战"))
                  (:- '(pre () "希望 未来 行动"))
                  (:- '(pre () "祈福")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.16")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/176557")
               '(q () (pre () "
2月14日：这是假的文贵推特号！任何关于文贵的信息全部以郭媒体本发出的信息为准！任何关于法治基金的的公告！以法治基金的官方公告和郭媒体上的法治基金名义！或文贵自己的郭文发出的信息为准，谢谢，一切都是刚刚开始！"))
               (u (:- `(cite () "假账号 : GUO.MEDIA(GUOWENGUI) @GGuowengui "
                             ,(@ "https://twitter.com/GGuowengui"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.15")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/176554")
               '(q () (pre () "
2月14号这才是真实的政客真实面目！……笑死我了！政客都太可怜了，一切都是刚刚开始！🤣🤣🤣🤣🤣🤣"))
               (u (:- '(pre () "郭文视频: 某政客 门口警卫问她 你今天要辞职了吗 她回家后 ..."))))
           (:- "郭文: " (@ "https://www.guo.media/posts/176438")
               '(q () (pre () "
2月14日：问题儿童问题的核心是什么？问题的核心就是这个体制？就是共产党！所以说．问题儿童问题青年．问题党员．中国就是个最大的问题社会！而问题的根本原因就是C CP！所以我们必须干倒CCP！抽烟、喝酒、动作娴熟，满脸的世俗沧桑！孩子，你的父母在哪儿？让人心碎，无法接受！一切都是刚刚开始！"))
               (u (:- '(pre () "郭文视频: 小孩抽烟喝酒"))))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/176417")
               '(q () (pre () "
2月14日：看看我与谁在一起过情人节！文贵在此衷心地祝所有的战友们情人节快乐，一切都是刚刚开始！"))
               (u (:- '(pre () "班农先生")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.14")
        (u (:- "郭文(照片): " (@ "https://www.guo.media/posts/176367")
               '(q () (pre () "
2月14号：尊敬的战友们好！你们往身上浇水了吗？你们健身了吗？今天中午将与一个当年干倒前苏联共产党，最关键人之一起吃午餐，老人家亲自跑来纽约要了解关于法治基金的事情，详情星期六向大家汇报。一切都是刚刚开始！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/176283")
               '(q () (pre () "
2月14号：尊敬的战友们好．本周六！文贵在纽约时间上午9点．北京晚上10点！（—）向战友们直播法治基金的运行模式和所有的战友们关心的问题！请大家需要我回答的问题给我留言！ （二）中间停止10分钟再次直播！ 关于文贵看春晚，国内的反应以及文贵在最近一些事情上的个人观点与感想！和与在线的战友们互动回答战友们的问题！！！ 文贵太想你们了，一星期不直播，有太多话要和大家说了！ 一切都是刚刚开始！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/176214")
               '(q () (pre () "
2月13号：尊敬的战友们一定要注意身体健康啊，美好的生活正在飞速地冲向我们！请务必注意健康使用手机！一切都是刚刚开始！"))
               (u (:- '(pre () "郭文视频: 手机在充电和未充电状态下的 电磁辐射量差别")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.13")
        (u (:- "郭文(图片): "
               (@ "https://www.guo.media/posts/176187") " "
               (@ "https://www.guo.media/posts/176186") 
               '(q () (pre () "
2月13号：这才是我们真实的中国人的内心世界！是真正的世界上最伟大的民族之一，看到这些留言，所有的人都感动万分。我们不是吃草的民族，也不是没有智慧民族！更不是缺乏勇气和牺牲精神的民族！这就是事实！在我们赢了✌️✌️✌️✌️✌️，衷心地万分的感激所有的战友们一切都是刚刚开始！（－）（二）
")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/176176") 
               '(q () (pre () "
2月13号：今天下午与基金的律师开会，当他们看到电脑上的这些数字的时候都是非常的震撼！这就是我们战友们追求法治中国！信仰自由的中国！不再受压迫的最真实的内心的反应！会开不下去了！看到一个个的这样的热血的伟大的同胞们的热情！对比王岐山的中国人可以吃草之说！中国人需要压迫！和百年都开不了智这种混蛋逻辑！我为我们的同胞和战友们感到无比的自豪！为大家而战！为我们喜马拉雅而奋斗的法治基金不会辜负！任何一个付出了努力．奉献的同胞们．和战友们！一切都是刚刚开始。")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/176115") 
               '(q () (pre () "
2月13号：尊敬的战友们好，你们健身了吗？你能往身上泼水了吗？昨天晚上我与凯尔巴斯．开会开得很晚，我们将对法治基金及下一步的行动，制定了详细的计划，昨天晚上，法制基金又收到超过200笔的捐款！这就是14亿中人的未来！大家想一想，这个捐款的数据力量会震撼世界！会让全世界的7O亿人民和我们站在一起，这是凝聚力。这是比投票还重要的行动！我们在告诉全世界，我们需要法治的中国！信仰自由的中国，我们不是猪狗，我们必须活在没有恐惧的生活中！我们将会一起走向我们的喜马拉雅！一切都是刚刚开始！")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/175973") " "
               (@ "https://www.guo.media/posts/175970")
               '(q () (pre () "
2月12日：这两个50万美元和另两个100万美元的朋友请看我在银行给你们留的信息！🙏🙏🙏🙏🙏🙏🙏🙏🙏……

2月12号衷心地感谢战友们给法治基金的资金支持，今天收到的一百多笔捐款，当中，像这样的捐款的实在是太多了！实在是让所有的法治基金的人的感到责任重大，深受鼓舞……这样下去还得了！！法治基金一定不会辜负所有的支持者！战友们！一定在干倒CCP的目标上！也给大家超出想象的结果！和回报， 法治基金将为14亿中国人的未来．和中国走向法治！与信仰自由！有更大的回报。我们不会忘掉一个！我们共同战斗的战友！和支持者！请留好你们捐款的信息！和票据！将有重大的意义！一切都是刚刚开始！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/175947")
               '(q () (pre () "
2月12日，路德先生的捐款不是这无数比捐款最大的数字！也不是最小的数字！但是它具有代表性！路德先生，天天在为中国的法治自由信仰而奋斗！从未在我文贵这里拿过一分钱……而是行动．行动！这就是真实的路德！任何质疑法治基金的人，你先问问你自己，你帮助过一个人吗？你了解法治基金吗？……你甚至连法治基金的章程都没看，你就开始质疑！基金将成为未来任何一个捐助者最重要的可信任依赖的家园！法治基金将给予你无法想象的支持和帮助，希望每个人都要留好自己的捐款的票据．她会是生命中的＂速效效心丸＂一切都是刚刚开始！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/175941")
               '(q () (pre () "
2月12日：赵丽贞．郑祺．海航．王岐山！在美国的网络太历害了！连这样的家族都想吃掉……太恐怖了！三F计划在美国无处不在！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/175923")
               '(q () (pre () "
2月12号：我刚刚的和法治基金的律师见面，我被这两天的捐款的数额和数量给震撼到了，我相信法治基金是共产党执政70年来将遇到的最大的经济力量的挑战，这就是人心，这就是天意，这就是力量，这就是真理，当我看到电脑上那个数字的时候，我真的无法相信，而且超过五分之三全都是外国和西方的公司及个人捐款，这就是无法改变的真相和真理的力量，我相信法治基金也是过去70年来受到世界上最多关注的真正的西方世界捐助的结构，这个数字和这个数量和这个资金来源。真是超出了所有法治基金董事会成员的想象！我们今天下午会和相关董事开会！共同及时将法治基金管理．标准化，专业化．并回答所有的关心法治基金战友们关心的问题，一切都是刚刚开始！"))
               (u (:- '(pre () "郭文图片: 椅子 游艇上的   画(带着军警帽子 抽着烟 的黑猩猩)  Dr. Lukas Brezak <Captain Smoke>"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/175903")
               '(q () (pre () "这是什么情况？"))
               (u (:- '(pre () "郭文图片内容: USC-CIF Corp 4个股东 : Li Zhen Zhao, Keneth Cheng, Xin Zheng, Chinese Funding Entity"))))
           (:- "郭文(报平安 照片): " (@ "https://www.guo.media/posts/175901")
               '(q () (pre () "2月12号：尊敬的战友们好，你们健身了吗？你们往身上泼水了吗？一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.12")
        (u (:- "郭文: "
               (@ "https://www.guo.media/posts/175843") " "
               (@ "https://www.guo.media/posts/175766") " "
               (@ "https://www.guo.media/posts/175753") " "
               (@ "https://www.guo.media/posts/175663") " "
               '(q () (pre () "
2月12日：尊敬的战友们好．感谢战友们对赵丽贞的挖掘！太厉害了！你们就是正义的护法！赵丽珍这个女人不简单，大家可能又要开始猜爹的游戏了！她爹和呈成杰！贯军的爹似的鬼秘……都是盗国贼的重要成员！一切皆开之时，大家会发现很多不可思议的事情．一切都是刚刚开始！

2月11号：郑祺．这个黑白两道的玩家还真和王岐山．海航．关系不浅，大家查查，这个公司！这个〈赵丽珍〉Li zhao．zhen……大家会发现另一个大鱼！一切都是刚刚开始

2月11日： 可能是郑祺干掉的又一个律师……这个就是带着郑祺……拉一车现金买房的其中一个人！ 长https://www.christopherfountain.com/blog/2017/8/11/stamford-attorney-burt-hoffman-arrested


2月11日：原来郑祺这个混子！黑社会！是白道黑道通吃！看着他抱着这个女人的样子一脸的淫荡！还拍了美国之音张晶他爹的电视剧．这是真的吗？请大家提供一下郑祺这个家伙一车一车的暂新的美金现钞！应该是哪里来的？美国政府相关部门的如果能提供在美国销售或！提供毒品！芬太尼销售渠道！和供应商的各种信息的所有证据将有重大奖励，请战友们高度关注对美国进行毒害的毒丸计划之一，也就是芬太尼相关的任何证据！这是CCP、3F计划的重要环节之一，美国人民和美国政府还没有看到这件事情的威胁的严重性！我们应该提供更有力的相关证据，那就是在美国的销售渠道！分销商！和洗钱当事人的证据！不能让这些人毁了我们华人的形象！和我们华人在世界的未来！那将是更大的灭顶之灾！如果任何海外华人或国内朋友能提供郑祺．梁贯军等……他们的犯罪证据，文贵将马上根据信息价值！给予1百万美元和1千万美元不等的现金奖励！有意者，请直接和我联系！或路德先生，sara女士联系！我将用一切方式保证你们提供信息的安全，并且会协调当地政府（除中国外）给予你们特别的保护！我的律师会马上和信息提供者签署相关保密及安全支付的协议！一切都是刚刚开始【人物串聯：張晶—》鄭棋 記錄張晶父親張彥的紀錄片《飞虎奇缘》主办单位:美中影视文化传媒集团的總裁赵丽贞(jenny zhao)女士,协办单位:美国侨商联合会的主席鄭棋】"))
               (u (:- '(pre () "郭文图片内容: ")
                      (u (:- `(cite () "@DTinLosAngeles : 对美国自杀律师Gabriel Macconaill 加布里.马克康奈尔 与Sidley Austin LLP 盛德.奥斯汀律所和海航集团(HNA)案例的挖掘 "
                                    ,(@ "https://twitter.com/DTinLosAngeles/status/1094156610736410624")
                                    (small () "2019.2.9 Twitter")))
                         (:- '(pre () "赵丽珍 USC-CIF,CORP."))
                         (:- `(cite () ,(@ "https://www.christopherfountain.com/blog/2018/10/12/just-caught-up-with-this-news-stamford-real-estate-attorney-burt-hoffman-crook-committed-suicide-on-june-8-2018"
                                           "Just caught up with this news: Stamford real estate attorney Burt Hoffman, crook, committed suicide on June 8, 2018")
                                    (small () "2018.10.12 Christopher Fountain")))
                         (:- `(cite () ,(@ "https://www.christopherfountain.com/blog/2017/8/11/stamford-attorney-burt-hoffman-arrested"
                                           "Stamford attorney Burt Hoffman arrested")
                                    (small () "2017.8.11 Christopher Fountain")))))))
           (:- "郭文: " (@ "https://www.guo.media/posts/175767")
               '(q () (pre () "
2月11号：看看法治基金对盗国贼．欺民贼造成的恐惧！看看他们用这种卑鄙的手段！制造虚假的文贵声明！来阻止捐款！这就是法制基金未来的价值！因为C C P和欺民贼最恐惧！这就是我们这几天看到的一系列的谣言！怀疑！和根本不存在的所谓的问题！根本原因，这些流氓！低级下流，他们的恐惧就是我们的武器！所以法治基金必须接受任何方式！任何货币．任何数额的捐款，而且法冶基金将因为他们的制造的谣言！会采取一系列的措施来让他们所有过去造的谣的目的！我们没钱革命！没钱干C C P的谣言破产！这才是法治基金的重要价值之一！ 【这是在微信各群传播的一个文件，不知道是谁做的。用的视频看题目是2月7号的春晚视频，但是我打不开，需要有Telegram。这就是让大家不要捐款，许多原本要捐的也改成了观望态度。】"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.11")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/175640")
               '(q () (pre () "
2月10号：尊敬的战友们好！今天去耐克！还有阿迪达斯！去给自己置办了三个月的运动的新运动鞋！加在一起的费用还没有打官司一个小时的律师费贵呢……但是非常喜欢今年的款式！分享图片给战友们！一切都是刚刚开始！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/175570")
               '(q () (pre () "
2月10号：刚刚到St. Patrick's Cathedral大教堂为14亿同胞！和战友们祈福！一切都是刚刚开始！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/175551")
               '(q () (pre () "
亲爱的支持者们：法治基金官网更多功能正在上线中，目前借助“郭媒体置顶”及时发布信息。一切请以法治基金官网（英文版）、“郭媒体置顶”协助发布的信息为准，感谢关注！ ❤ 法制基金官网如下： https://rolsociety.org https://rolfoundation.org ❤ 法治基金接受捐款的PayPal账户两个如下： https://www.paypal.com/donate/?token=-SedWTxv01s4rpmj9XWi8BHIPDpO57OHMhvfonemzeYHjQoo12Wii1kSyRzcIYxIz3W_Wm&country.x=US&locale.x=US&Z3JncnB0= https://www.paypal.com/donate/?token=1KDMnJmAh9PVcphSs9VZhbP4-7FvQztwYuKA1rNRFZgX18N-NMJ0vHp2h0P5XLca0F_L3W&country.x=US&locale.x=US ❤ 法制基金接受捐款的银行账户信息两个如图！"))
               (u (:- `(cite () ,(@ "https://rolsociety.org")))
                  (:- `(cite () ,(@ "https://rolfoundation.org")))))
           (:- "郭文: " (@ "https://www.guo.media/posts/175544")
               '(q () (pre () "
2月10号，这是世界上第一架交付的全球快车7500型．可以从纽约飞到北京．香港不用停！7500空里直飞……非常非常的棒，我的林宝坚尼SUV已经重新喷漆完毕，相当的漂亮！一切都是刚刚开始！"))
               (u (:- `(cite () "庞巴迪 全球快车7500型 : "
                             ,(@ "https://businessaircraft.bombardier.com/en/aircraft/global-7500#!#bba-pdp-section-1"
                                 "Global 7500")
                             (small () "Bombardier")))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/175533") " "
               (@ "https://www.guo.media/posts/175407") " "
               (@ "https://www.guo.media/posts/175406") " "
               (@ "https://www.guo.media/posts/175400")
               '(q () (pre () "
2月10日：一切都会查清楚：并受到美国法律的严惩😡！ Kenneth Chen(中美贸易协会)买通一位美国大银行家的律师Gabe MacConaill 哄骗银行家想办法以海航的名义购买美国的金融牌照！目的是让银行家变成海航股东及实际控制人！王岐山是他老板等等 律师Gabe帮助王，海航用巨额现金贿赂美银行家 Gabe和Chen涉嫌洗钱被抓,保释期在停车场莫名其妙自杀了

2月9号：这是郑祺这孙子，2017年来我楼下！还带着一个女的！试图杀害我的最好的证据！与刘延平到纽约我家！和我见面，几乎同一个时间！这就当时的三招之一！其中的一招！黑社会杀掉文贵！感恩上天的帮助！我们一个都不会放过！害我们的郑祺孙子，还有梁贯军孙子！一定要为他们在美国的所有一切付出代价！到了买单的时候了！一切都是刚刚开始！

2月9号：伟大的战友们好！衷心地感谢你们！短短的几分钟，你们就查到了这个孙子！真没想到原来就是郑祺！这孙子！绝对是杀手！这是为什么某些有关部门一直在问我知不知道郑祺和梁冠君的真实背景！现在更加明白了！没想到他竟然．敢对美国最伟大的金融家下手！而且是2017年九月份拉了一整车的全新的美元去贿很美国最伟大的金融家！足可见这个孙子！多么的无知！美国不会放过这些狗东西！咱们走着看！王岐山！孟建柱！孙立军！养的这样的走狗！你可见他他们的以黑治国黑遍国际的这些不可思议的犯罪行为！这样的中共的反腐更是实在可笑！你信吗！一切都是刚刚开始！

2月9号：尊敬的战友们．这两张手机的截屏．就是几天前与我一起吃晚餐的美国最伟大的银行家XX，他提供给我的这个人的通信信息与名称！就是这个人买通了他的律师！欺骗他想办法以海航的名义购买美国具有百年以上历史的金融牌照！并说他是海航的股东及实际控制人！王岐山是他老板等等……后来他的律师因为与这个人一起涉嫌洗钱被抓，后来被自杀！也是这个人带着一整车的美元现金去要买他家的房子．一个私人岛屿……被这位银行家轟了出去！请战友们Google去查这个人到底是谁！伟大的战友们会找到答案的！海航的疯狂！和在世界的骗抢杀偷！远远超出了人们的想象……一切都是刚刚开始！"))
               (u (:- '(pre () "Kenneth Cheng"))))
           (:- "郭文(报平安 照片): " (@ "https://www.guo.media/posts/175520")
               '(q () (pre () "
2月10号．尊敬的战友们好：你们健身了吗！往身上泼水了吗！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.10")
        (u (:- "郭文(短视频): " (@ "https://www.guo.media/posts/175380")
               '(q () (pre () "
2月9号：衷心地感谢文鸡战友做的这个视频！文贵不敢当！文贵将不惜一切的努力实现我们喜马拉雅目标来回报所有战友的关心和关爱！一切都是刚刚开始！")))
           (:- "郭文(报平安 照片): " (@ "https://www.guo.media/posts/175332")
               '(q () (pre () "
2月9号：尊敬的战友们好．你们健身了吗！今天的纽约晴空万里！非常非常的冷！但是特别特别的舒服，一切都是刚刚开始！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/175259")
               '(q () (pre () "
2月9日：这就是法治基金未来的目标！ 【Kyle Bass: 美国必须制裁王岐山和所有负责新疆集中营的中国ccp成员。 为什么其他美国参议员和国会议员不像卢比奥那样有力地提出这个问题？问题来了，其它参议员和国会议员你们有什么痛点吗？】"))
               (u (:- `(cite () "@Jkylebass : " ,(@ "https://twitter.com/Jkylebass/status/1094111121189920769")
                             (small () "2019.2.8 Twitter"))
                      '(q () (pre () "
The United States must sanction wang qishan and all chinese ccp members responsible for The Xinjiang concentration camps. Why aren’t other US Senators and Members of Congress raising the issue as forcefully as Rubio? #china @SecPompeo @SenatorRubio"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.9")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/175215")
               '(q () (pre () "
2月8日：金正恩．金与正兄妹是极端聪明人……是务实的年轻人！知道我给他们料的份量！也会知道那意味着什么🤔接下来他们的郭叔叔还会给他们什么！＂喝了人家的绿豆面．就要还这个情＂ 【估计朝鲜金正恩被艾力博迪给总检察长塞申斯的邮件，关于中共出卖朝鲜金正恩以换取遣返郭文贵的行为，给气懵蹬了，索性一边倒向美国了，所以川普总统大悦……】"))
               (u (:- '(pre () "相关推文: @realDonaldTrump ")
                      (u (:- (@ "https://twitter.com/realDonaldTrump/status/1094035813820784640")
                             '(q () (pre () "
North Korea, under the leadership of Kim Jong Un, will become a great Economic Powerhouse. He may surprise some but he won’t surprise me, because I have gotten to know him & fully understand how capable he is. North Korea will become a different kind of Rocket - an Economic one!"))) 
                         (:- (@ "https://twitter.com/realDonaldTrump/status/1094031561861881856")
                             '(q () (pre () "
My representatives have just left North Korea after a very productive meeting and an agreed upon time and date for the second Summit with Kim Jong Un. It will take place in Hanoi, Vietnam, on February 27 & 28. I look forward to seeing Chairman Kim & advancing the cause of peace!")))))))
           (:- "郭文: " (@ "https://www.guo.media/posts/175199")
               '(q () (pre () "
2月8日：衷心地感谢老朋友送来发为非商业的红酒！虽然过了中国春节！晚了几天！但是看到我最喜欢的2000年和2005年的拉菲还是特别的兴奋！衷心的感谢英国这位银行家老朋友每年送给我的红酒！我以他已经没有任何商业往来金融业务了，还是每年给我送酒，而且今年上面写道，希望这是我干倒C C P的动力让我很感动😹我讲这些大部分保留给有重大贡献及对C C P造成重大打击的战友们！在今年我们的法制基金的总部一起来喝！一切都是刚刚开始！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/175183")
               '(q () (pre () "
2月8号：这是郭媒体的网络版的最近的网络信息数据！包括了C C P在不同的国家时时刻刻在骇我们的郭媒体的部分信息！既是如此郭媒体的关注和点击量还是非常惊人……我们的App在中国受欢迎程度排第24位．国际上的网络评估综合结果郭媒体的广告价值潜力排前十名！我们郭媒体的电脑板没有一次被他们骇断！一切都是刚刚开始！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/175119")
               '(q () (pre () "
2月8号：尊敬的战友们太伟大了……就我一句话，你们就能挖出这个自杀的律师！太厉害了，是的，就是这个律师，因为帮助王岐山和海航和非法的用巨额现金贿赂，美国最伟大的银行家！和出卖威胁他的客户……在保释期在停车场莫名其妙的轻轻的轻轻的自杀了……这是王岐山和海航在美国的另外一个犯罪案件……一切都还在司法调查中！中谢谢伟大的战友！一切都是刚刚开始！"))
               (u (:- '(pre () "郭文图片内容: ")
                      (u (:- `(cite () ,(@ "https://www.law.com/americanlawyer/2018/10/18/gunshot-killed-sidley-partner-la-medical-examiner-rules/?slreturn=20190109011410"
                                           "Gunshot Killed Sidley Austin Partner, LA Medical Examiner Rules")
                                    (small () "2018.10.18 The American Lawyer")))))))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/175116")
               '(q () (pre () "
2月8号．尊敬的战友们好：你们健身了吗！你们往身上浇水了吗！从今日起文贵一周内不做直播！让大家休息一下！同时消化文贵看春晚三天的视频的信息！一切都是刚刚开始！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/175104")
               '(q () (pre () "
2月8号．尊敬的战友们好：下面这个推号是个骗子，请大家不要上当！近日来已经收到了很多笔对法治基金的捐款……这是对帮助我们国内需要帮助的人非常重要！法治基金可以接受任何数额不限大小！任何货币！包括虚拟货币的所有的一切货币！将用在推翻CCP！帮助我们国内外需要帮助的人！一切都是刚刚开始！"))
               (u (:- '(pre () "骗子推号: @GGuowengui")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.8")
        (u (:- "郭文(照片): " (@ "https://www.guo.media/posts/174996")
               '(q () (pre () "
2月7号：第一章照片这是我刚刚从监狱出来后来到美国时的一张照片！第二张是和我的两位导师贺龄乐乐先生，建筑．禅宗大师李祖原的照片！ 第三张张是和军队的一位首长在他家里聊天的照片！第四张是我在香港的合伙人家里的一个照片！第五张是裕达国贸酒店开业时的照片．那位混血的外国人是我裕达公司的总栽．陈捷照先生！他是日本青木建设：威斯汀酒店的集团总裁！他的故事很多．末来我会告诉你们！今天看到这些照片的时候！我感慨万千！没有他们就没有我文贵的第二次生命！他们是我精神上的导师！也是政治．与走向商界和国际的带路人！他们都是上天安排的带我走向西马拉雅之路的关键的恩人！终身感激！！！无以回报！！！只有干到C C P是对他们最大的回报！人生不过如此！看到这些我心情激动……动力无限！必须完成上天赋予我的使命！一切都是刚刚开始。")))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/174991")
               '(q () (pre () "
2月7号：感谢这位战友亲身往洛杉矶王岐山的豪宅去拍了这个视频，这只是王岐山百座豪宅，其中的一部分，这也是在896 时买的，接下来会有很多人去拍摄王岐山的各地住宅，也会有很多王岐山的新住宅信息被公布！一切都是刚刚开始！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/174982")
               '(q () (pre () "
法治基金账户信息（可以接收任何货币） Bank Info - Rule of Law Foundation & Rule of Law Society (All Currency Accepted)"))
               (u (:- '(pre () "郭文图片: 法治基金账户信息"))))
           (:- "郭文(短视频 Snow): " (@ "https://www.guo.media/posts/174969")
               '(q () (pre () "Snow 在咬王妓山．孟建柱．孙力军的蛋蛋！")))
           (:- "郭文(短视频 Snow): " (@ "https://www.guo.media/posts/174959")
               '(q () (pre () "
2月7号：感谢所有关心snow 的战友们！一切都是刚刚开始！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/174948")
               '(q () (pre () "
2月7日：哎呦呦，哎呦呦，这也忒戏剧化了吧，让人怎么受得了呢？王岐山应该出场了！鬼子六不出场此事难灭！此时不救火，还叫救火队长吗……海口的高尔夫球场演练！包括表演准备花了那么多钱，如果取消了这个会面让鬼子六王岐山太没面子了！精心的一场布置又泡汤了……这不叫救火队长🤣🤣🤣这是魔鬼魔长……【突发：一個白宮官員表示，由於貿易緊張施压股市，特朗普總統“非常不可能”在3月1日截止日期前與中國國家主席習近平會面！ twitter.com/WSJ/status/109… U.S. Trump Said to Be ‘Highly Unlikely’ to Meet With Xi Before March 1 Deadline】"))
               (u (:- `(cite () ,(@ "https://www.wsj.com/articles/trump-said-to-be-highly-unlikely-to-meet-with-xi-before-march-1-deadline-11549561576"
                                    "Trump Said to Be ‘Highly Unlikely’ to Meet With Xi Before March 1 Deadline")
                             (small () "2019.2.7 WSJ")))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=Fhw-04myTes"
                           "2月7日文贵、班农、凯琳 回答战友们对春晚爆料的问题")
               '(small () "Youtube")
               (u (:- '(pre () "问 班农先生 对 美国之音 阿曼达 的 控制言论的做法(419断播 拒播班农先生的采访) 美国方面有什么法律和行动能做吗 ?")
                      (u (:- '(pre () "媒体要报道这些事  国会议员检查美国之音  美国之音没有承担自由广播的责任"))
                         (:- '(pre () "美国之音 使用着美国纳税人的钱 却没有履行它的责任 向中共国人民传达真相 传递自由的声音"))
                         (:- '(pre () "法治基金 任务之一 就是去调查 美国之音 这些行为"))
                         (:- '(pre () "美国媒体 每天都有对总统各种诉讼的报道 但是 那些涉及到中共的 司法部的腐败 美国之音断播 等等丑闻 却没有受到广泛关注  这是为什么 ? "))
                         (:- '(pre () "(我: 西方媒体对中共蓝金黄的报道基本没有 是不明白 还是说他们被蓝金黄了呢?  中共对西方的媒体的影响方式 也是一个关注点)"))))
                  (:- '(pre () "法治基金 如何救援 国内受迫害但不能出国的人们 以及 他们出来后 各国如何能够为他们提供庇护 ?")
                      (u (:- '(pre () "让他们受到关注 被媒体报道 被世界所了解   政治庇护受到很大争议 但仍然希望能让各国能够在公平和正义的情况下 为他们提供庇护"))))
                  (:- '(pre () "问 班农先生 华为之外 哪一家企业会受到美国司法部诉讼?")
                      (u (:- '(pre () "班农先生 不知道 但 预测今年规模将会更大 更多的调查  调查很复杂"))))
                  (:- '(pre () "法治基金 是否能够做到 直接让被害人 到 领事馆 去申请庇护 ?: 班农先生在2018时 就已经在做 有多个国家是可以做到的(如 意大利 西班牙 比利时 巴西)  也希望 形成一个联盟"))
                  (:- '(pre () "法治基金 除了要调查中共国在海外上市公司 盗取的中国人民的钱 同时 还有 盗国贼们在海外的非法财富  提供信息的 按美国法律 是会有 分成或奖励的"))
                  (:- '(pre () "法治基金 会对 中共倒台 有关键作用  看看 委内瑞拉 查韦斯马杜罗 喂养多年的军队和警察 在人民上街后没有行动 为什么 ?: 很多民间组织 给他们们 以及他们家人 传达了很正确的信息 给予了保护"))
                  (:- '(pre () "面对中共的压力 用 真相现实 还击 "))
                  (:- '(pre () "去年 11.20时 一位将军 要捐10亿美元 发来了美金金条的视频 王岐山腐败的证据 "))
                  (:- '(pre () "台湾一位富豪 愿意捐遗产的一部分 其中一部分钱 就是要拯救新疆受迫害的人事"))
                  (:- '(pre () "新加坡一个家族 要捐很多钱 和 古董车"))
                  (:- '(pre () "法治基金 如何调查 中共国在美上市公司 以及 盗国贼的海外资产 ? ")
                      (u (:- '(pre () "它们如何把钱弄到海外的 如何在海外洗钱的 这些企业的实际所有人是谁  它们是有系统的  我们也要有系统的调查这些"))
                         (:- '(pre () "海航 就是一个好例子"))
                         (:- '(pre () "它们 和 华尔街 联合盗取了中国人民的财富"))))
                  (:- '(pre () "自己都没饭吃的 强烈建议 不要捐款   你有闲钱 认为这么做能够让自己舒服 也要关注这些钱什么使用"))
                  (:- '(pre () "(46:30) 班农先生 是否了解海外民运吗 ?")
                      (u (:- '(pre () "知道很多  但他们的影响力有限 受到太多压制 "))
                         (:- '(pre () "班农先生 在美国高层 对 海外民运圈实际的状况不太了解"))
                         (:- '(pre () "干什么都募捐 离婚也募捐 天天在网上互相撕咬"))
                         (:- '(pre () "希望 法治基金 调查 在海外所谓的民族命运人事 到底干了什么 究竟在干嘛 是否是打着民主民运旗帜骗钱"))))
                  (:- '(pre () "(1:08:00) 美国一个大家族  海航 百万现金  \"自杀\"律师"))
                  (:- '(pre () "班农先生的网站也在直播  郭先生说他相信川普总统也在看 不能说 秘密秘密"))
                  (:- '(pre () "罗斯柴尔德家族 也要参与"))
                  (:- '(pre () "王健之死  花工jack 目击证人   凯琳她们 去现场 调查采访    将有更重大信息发布 会开一个新的发布会  (我: 太过分了 死了还要侮辱人家 说人家拍照死 跳墙死  把人家搞笑死 居然能如此对待这些帮它们在海外活动的人 死的尊严都没有)"))
                  (:- '(pre () "(1:25:00) 问 班农先生 法治基金 怎么对付 孟建柱 和 孙立军 ? ")
                      (u (:- '(pre () "法律 搜证 提供真相 证实它们的违法行为"))
                         (:- '(pre () "把 被迫害 被抓 被喝茶 等等 信息公布出来  让媒体关注 形成浪潮 让更多人能够选择站出来"))))
                  (:- '(pre () "(1:33:00) 休息时间 插播视频: 2017年爆料以来 针对中共 西方经济政策的 改变"))
                  (:- '(pre () "(1:53:00) 凯琳女士的爱情观   中国父母要求太多了 催婚  (我: 管太多了 人就死板了 老催婚 你多谈几个 他们就以为你玩呢 你挑剔 见好就收吧 老是这种态度 又不是配对 生辰八字家庭背景工作房子财产一符合 就适合 脾气性格想法都凑不到一块 难道要让双方强忍几十年 了解彼此需要很长时间的 谈恋爱是看到彼此真实的一面 不是为了把彼此骗到手 就互相取悦)")
                      (u (:- '(pre () "(我: 哈哈哈 很臭(丑) 郭先生要不纠正 我都还没反应过来呢)"))
                         (:- '(pre () "中共国 现在的社会 太势利了 不快乐"))))
                  (:- '(pre () "(2:02:00) 班农先生谈 爱情 家庭  减肥"))
                  (:- '(pre () "越来越多的 声音和信息 传递出 中共真的可能会打台湾  "))
                  (:- '(pre () "(2:08:00) 问 班农先生 中共会打台湾吗 若打 美国会怎么办 ?")
                      (u (:- '(pre () "台湾人民自己要站起来"))
                         (:- '(pre () "台湾 保留了 中国文化 不能让中共毁了"))
                         (:- '(pre () "拿下台湾就结束了吗? 不会 下一个会是 南亚 日本"))))
                  (:- '(pre () "(2:16:00) 凯琳女士如何看待 中共国官员 ?"))
                  (:- '(pre () "(2:19:00) 问 班农先生 中共国内受迫害的人 逃到海外 能够获得政治庇护吗 ?"))
                  (:- '(pre () "(2:23:00) 问 凯琳女士 为什么 选择为 郭先生工作 ? "))
                  (:- '(pre () "和 郭先生在一起很难 和妻子34年 但优点真实善良"))
                  (:- '(pre () "(2:28:00) 请 班农先生 评价 川普总统的 国情咨文  特别是 永远不会成为社会主义国家 ?")
                      (u (:- '(pre () "白衣 民主社会主义  抬头  大政府"))))
                  (:- '(pre () "(2:33:00) 问 班农先生 美国政府 能够对 中共国内对宗教和信仰的迫害 能够做什么 ?")
                      (u (:- '(pre () "结构性改革 全面的改革 工人权益 "))
                         (:- '(pre () "更加关注宗教迫害"))
                         (:- '(pre () "告诉 梵蒂冈 不要成为CCP的傀儡"))))
                  (:- '(pre () "(2:37:00) 问 班农先生 美国要求的结构性改革 是什么 ?")
                      (u (:- '(pre () "国富民弱民穷 变为 民强民富 改变资源的分配方式 将权力和财富还给人民 (我: 改变社会主义制度 让权力不再集中在少数几个人手中 垄断资源和财富 为所欲为)"))))
                  (:- '(pre () "(2:40:00) 问 班农先生 中共不履行承诺和协议 怎么办 ? ")
                      (u (:- '(pre () "真相 通过事实让人们知道 它们在做什么"))
                         (:- '(pre () "(我: 越多的人能够明白中共在什么 它们没有履行承诺 那就更容易说服人们 对中共施以惩罚 更有理据 也会有更多更有力量的人能够 做出正确的选择 站在一起)"))
                         (:- '(pre () "(我: 让川普总统 美国人民 能够明白 what happened(发生了什么?) 你们的钱被用来做什么 是在帮助中国人民 同时 获得正当利益 还是被用来伤害人民 破坏宗教信仰 发展军事 甚至 渗透美国和西方 用你们自己钱 来 伤害美国人民 世界人民 ?  了解你们的钱 并 对你们对钱负责) "))))
                  (:- '(pre () "(2:42:00) 问 凯琳女士 在中共国最不开心的事 是什么 ?: 空气污染 雾霾"))
                  (:- '(pre () "(2:46:00) 问 班农先生 3.20 中共与梵蒂冈交易 怎么办 会发生吗 ? ")
                      (u (:- '(pre () "让人们 看到 中共在国内迫害宗教信仰的 事实  梵蒂冈 会明白 他们是在与魔鬼做交易"))))
                  (:- '(pre () "(2:55:00) 问 班农先生 对香港 乱来的官员和警察 有什么办法和行动 ?  中共利用 香港洗钱 用港币 欲打击美国经济 怎么办 ? ")
                      (u (:- '(pre () "香港的现在的情况 缺少国际关注"))
                         (:- '(pre () "一国两制 50年不变 邓小平的这一承诺 要指出"))
                         (:- '(pre () "香港的一些富豪 不要再出卖香港的利益"))))
                  (:- '(pre () "(3:00:00) 问 凯琳女士 怎么看 在网络上出卖肉体的女性 ?"))
                  (:- '(pre () "(3:03:00) 请 班农先生 评价一下 王岐山 以及 王岐山会不会受到美国法律的惩罚 ?")
                      (u (:- '(pre () "要用真相 摘下这些人的面具 让西方媒体和全世界人看看 他们极力推崇的这些中共领导 到底是什么样的人"))
                         (:- '(pre () "推崇它们的人 是 收了它们钱 被它们利用"))
                         (:- '(pre () "王岐山 看着吧 一定控告你"))))
                  (:- '(pre () "感谢 班农先生 凯琳女士 感谢团队成员  班农先生要注意安全"))
                  (:- '(pre () "行动 行动 行动"))
                  (:- '(pre () "握手"))
                  (:- '(pre () "谢谢所有战友")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.7")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/174855")
               '(q () (pre () "
2月7日：这纯属巧合！郭骗子蒙对了而已……【蓬佩奥在回答记者采访时说了很多关于中美之间的情况，重点是蓬偑奥的最后一句――他说，他坚信川普总统会在接下来的一年内打败中国（显然，他这里所说的中国应该指的是中共国。）这与文贵爆料革命的既定的喜马拉雅时间不谋而合啊！ 是真的不谋而合还是根本就是有谋而合？这是一个问题，亦是一个天机！】")))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=IU63W9OCPLs"
                           "2月6日文贵、班农、凯琳 回答战友们对春晚爆料的问题")
               '(small () "Youtube")
               (u (:- '(pre () "孙立军 每年春节 都给 孟建柱 找处女  吃阴枣 开处  无知 愚蠢 对人类对摧残 (我: 别说班农和凯琳匪夷所思 我都崩溃啊 不是对事惊奇 国内吃胎盘 各种以形补形 多了去了 我崩溃的是它们人 你党这么有权有势也有钱的人 也受过良好教育的人 怎么都这样啊 要玩你也玩点高级的啊 干嘛老做这种禽兽不如的事呢)"))
                  (:- '(pre () "(14:45) 白宫 遣返郭文贵的信 有没有习的亲笔签名 ? "))
                  (:- '(pre () "网友 赞 香港翻译姐姐 太厉害了"))
                  (:- '(pre () "(24:55) 川普总统在昨天 国情咨文中提到的 结构性改革 班农先生是如何理解的 ?")
                      (u (:- `(cite () "美国总统 川普 美国时间2月五日晚 在国会 发表 国情咨文演说 : "
                                    ,(@ "https://www.youtube.com/watch?v=RwrnbSC32sw"
                                        "美国总统特朗普国情咨文特别节目")
                                    (small () "2019.2.5 Youtube (美国之音 中文同声传译)")))
                         (:- '(pre () "川普总统 希望 美国 和 中国 的经济都能够向好 这对世界是最好的 要中共国发生结构性改革 才能真正让中国经济变好"))))
                  (:- '(pre () "(31:30) 能够为 法治基金做什么 以及 如何 捐款 ?")
                      (u (:- '(pre () "提供中共国内的信息 把正在发生的事通过媒体爆出来 联合起来 获得关注"))
                         (:- '(pre () "(33:35) 法治基金 捐款账号"))))
                  (:- '(pre () "不是翻译姐姐 是翻译奶奶"))
                  (:- '(pre () "(40:00) 中共在海外的渗透 盗国 腐败  以及 是否可以使用 RICO法案 对付 中共 ?"))
                  (:- '(pre () "(1:08:40) 休息时间  插播视频: 选择  中共宗教迫害  诉讼进展 "))
                  (:- '(pre () "(1:28:00) 凯琳女士 参与到爆料革命来 感到危险吗 以及 未来要从政的话 先生支持吗 ?"))
                  (:- '(pre () "(1:40:00) 文贵看春晚 在中共国的反应 ? ")
                      (u (:- '(pre () "两个核心问题 : 中共十大罪恶  文贵看春晚十大贡献"))
                         (:- '(pre () "十罪: 不敬天 不敬大地 不孝敬(背叛父母 爹亲娘亲不如党亲) 不忠诚爱情 不忠于兄弟姐妹(不重手足之情) 不忠于自己的国家(共产主义 马克思 列宁) 不诚实 不相信上天(无信仰) 不重仁义 不遵守承诺(失信于天下)"))
                         (:- '(pre () "仁义礼智信 忠孝廉耻勇"))
                         (:- '(pre () "输出到西方"))
                         (:- '(pre () "不反中国人 反中共"))
                         (:- '(pre () "班农先生 让西方能够知道中共的邪恶"))
                         (:- '(pre () "十大贡献:  打开了西方 国际大门 把战场拉到国际上来 让西方强烈的认识到 中共对西方的 政治 经济 文化 军事 宗教信仰 是最大的威胁  然后 西方要什么呢 要 行动 团结 彻底反对中共而不是中国 让全世界 有良知的政治家们知道 反共才是未来 只有反共 只有没掉中共 中国才是世界和平的力量"))))
                  (:- '(pre () "(2:00:00) 中共国 是否可用 委内瑞拉的这种模式革命 ?")
                      (u (:- '(pre () "为什么 中共的一些领导 如 王岐山  在世界上受到推崇 为什么没人说它们盗国贼 ? "))
                         (:- '(pre () "班农先生 是第一个西方政要 公开批评 王岐山 的人 赞班农先生"))))
                  (:- '(pre () "一个欧洲领导人打电话 说 退休领导人俱乐部 都看了 文贵看春晚  还有 梵蒂冈教宗的组织人也看了"))
                  (:- '(pre () "班农先生 来自草根 关心草根 才不关心 什么政要精英喜不喜欢自己"))
                  (:- '(pre () "(2:25:25) 是否会调查起诉 美国之音 以及 台长 阿曼达 ?")
                      (u (:- '(pre () "司法部官员腐败 为中共 为什么没有大肆报道 ?"))
                         (:- '(pre () "班农先生 接受 美国之音的采访 但没有播出  因为说太多中共的压迫百姓的事 谈太多 王岐山 习近平"))))
                  (:- '(pre () "(2:44:50) 为什么 美国的精英 奉承王岐山 不谈论中共的问题 ? ")
                      (u (:- '(pre () "精英们 帮助了 中共   帮凶   要说出来 让人们知道 负起责任 不要再帮助中共"))))
                  (:- '(pre () "法治基金 需要帮助的请联系"))
                  (:- '(pre () "翻译奶奶 实际上 很年轻 特别漂亮 但为了保证她的私生活不受打扰 故不让她出镜 特会穿衣打扮  特善良 特勇敢"))
                  (:- '(pre () "凯琳最美 翻译奶奶最棒 班哥哥最帅 郭先生最调皮"))
                  (:- '(pre () "平民运动"))
                  (:- '(pre () "以人为本"))
                  (:- '(pre () "谢谢")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.6")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/174617")
               '(q () (pre () "
2月5日．尊敬的战友们好！明天2月6日紐約時間上午9點，文贵班農先生．凱琳女士．sara女士．路德先生！共同三方同时直播答戰友提問有关文贵看春晚节目中的有关问题！一切都是刚刚开始！")))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=WOMxXzKuy7A"
                           "2/5/2019 文贵先生、SARA、路德大年初一给大家拜年直播")
               '(small () "Youtube")
               (u (:- '(pre () ""))))
           (:- "郭文: " (@ "https://www.guo.media/posts/174571")
               '(q () (pre () "
2月5号：尊敬的战友们好！稍后我会在郭媒体试直播，因为我们已经购买了昨天借用的全部的福克斯专用的视频设备！和翻译系统！现在我们将试用新设备！为了不浪费大家时间！请不要观看，谢谢！！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/174552")
               '(q () (pre () "
2月5日：这是文贵看春晚刚刚开始直播一小时后的数据……这也是美国数据流量统计中显示中国的部分数据……仅仅一小时就到了3千多万……这就是真相的历量！爆料革命的价值！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.5")
        (u (:- "郭文(照片): " (@ "https://www.guo.media/posts/174443")
               '(q () (pre () "
2月5号：文贵在刚刚在跨过了纽约的农历新年的这一刻！衷心地祝福14亿中国同胞！和所有的战友们及家人！2019年平安健康！🥰🥰🥰一切都是刚刚开始！🙏🙏🙏🙏🙏🙏🙏🙏🙏❤️❤️❤️❤️❤️❤️❤️❤️❤️😍😍😍😍😍😍😍😍😍😘😘😘😘😘😘😘😘😘✊✊✊✊✊✊✊✊✊😻😻😻😻😻😻😻😻😻😻😻🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏")))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/174405")
               '(q () (pre () "2月4日：赶饺子🥟皮！感恩美国感恩战友！感恩上天！🙏🙏🙏🙏🙏🙏🙏🙏🙏"))
               (u (:- '(pre () "围裙 : 秋田犬"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/174379")
               '(q () (pre () "
2月4日：登喜录的196几年的古董雪茄！奖励自己的反共卓越贡献……猜猜我与谁一起享受呢！一切都是刚刚开始！"))
               (u (:- '(pre () "郭文图片: Wifi FBICyberCrimeVan"))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=qBsUEkLhXNc"
                           "2019 文贵看春晚 Miles Guo & Stephen K. Bannon view 2019 Chinese New Year")
               '(small () "Youtube")
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=VS3y9V4mddc"
                                    "主持人登场")
                             (small () "Youtube")))
                  (:- '(pre () "央视春晚 洗脑 欺骗 (我: 蠢完了)"))
                  (:- '(pre () "班农先生 凯琳女士  握手"))
                  (:- '(pre () "班农先生讲述细节 : 白宫遣返郭文贵  吴征 杨澜  王岐山"))
                  (:- '(pre () "民族主义"))
                  (:- '(pre () "凯琳女士  天主教徒  去中共国的经历 天津 河南男朋友(分手了) "))
                  (:- '(pre () "班农先生 : 香港 自由法治的丧失"))
                  (:- '(pre () "香港 经济 文化 交流分享 自由法治"))
                  (:- '(pre () "一国两制50年不变 过去式"))
                  (:- '(pre () "凯琳女士 : 中英联合声明 渗透香港 没有落实承诺"))
                  (:- '(pre () "班农先生 : 香港没有法治 没有司法保障 谁还敢投资 创业  香港面临的问题不可容忍 全世界应该联合起来做一些事情"))
                  (:- '(pre () "(58:30) 尊者 达赖喇嘛 视频  2013.12")
                      (u (:- '(pre () "郭先生 按 孟建柱 马健 以及 最高领导习近平 的要求 在东京 安排了此次采访"))
                         (:- '(pre () "采访者(中共海外情报机构 外派的间谍): 郑浩(主持) 王继言(台长) 李淼(驻东京记者站记者) 等 凤凰卫视成员"))
                         (:- '(pre () "(1:09:30) 尊者 达赖喇嘛 给习近平的亲笔信"))
                         (:- '(pre () "原件在郭先生那 (我: 郭先生太英明了 保留下了原件)"))
                         (:- '(pre () "大西藏 中间道路 自治 驱赶汉人 转世 自焚 等问题"))
                         (:- '(pre () "郭先生说 当把这些交给孟建柱后 孟说要杀了达赖喇嘛 (我:脏字自己看视频 不再此记录) (我: 如果达赖喇嘛死了 那这份信的内容 就将让西藏人民遵从达赖喇嘛的意思 中共扶植自己的达赖喇嘛成为西藏的新的宗教领袖 西藏人民将不再反抗 完全控制西藏)"))))
                  (:- '(pre () "中共骗了 达赖喇嘛 60年"))
                  (:- '(pre () "郭先生 也被它们 玩了 以为是帮助 达赖喇嘛 回到西藏 让西藏恢复信仰 让中国人有信仰 但却被中共给利用了"))
                  (:- '(pre () "西藏人民已经做出了最大的最诚实的承诺 任何人再反对西藏 再侮辱西藏 都是我们的敌人 世界上有信仰的人的敌人  必须看清除共产党的本质 欺骗欺骗 永远不兑现 "))
                  (:- '(pre () "班农先生 和 凯琳女士 对这封信和视频的感受"))
                  (:- '(pre () "梵蒂冈 教皇 还会相信中共? (我: 与其说中共是给梵蒂冈送钱去了 我觉得 是送了个新神去了)"))
                  (:- '(pre () "美国还能和中共签协议吗 ?: 班农先生 : 中共一小撮人 奴隶一个国家人民 相信美国政府能够认识到这一切 能够醒悟 来帮助14亿人 看明白这封信 中共的欺骗  梵蒂冈也要了解真相"))
                  (:- '(pre () "郭先生 当时问 孟建柱 是否 习近平会正式表态 让达赖喇嘛回国 ?: 孟回答说 : 如果习让他回来 那他就不叫习近平了 习近平将会创造一个最伟大的历史 他将名照千古  孟绝不希望会达到这封信和视频原来的目的 让尊者回国 孟不希望习这么做 "))
                  (:- `(cite () "(2:29:00) 视频: "
                             ,(@ "https://www.youtube.com/watch?v=qOUG3CwGr60"
                                 "宗教信徒是我们的敌人么")
                             (small () "Youtube"))
                      (u (:- '(pre () "凯琳女士 和 班农先生 的感受  信仰自由"))
                         (:- '(pre () "(我: 外交部说 \"中共国有信仰自由 人们想信什么信什么\" 太不要脸了 睁着眼睛说瞎话 这就是中共 用善言掩恶信 掩耳盗铃 我们真蠢 骗的这么直白 我们居然这都信)"))
                         (:- '(pre () "世界的所有信徒 都和 国内的教徒们 在一起 我们不会放弃你们 不会抛弃你们 也不会忘记你们  是我们的信友 教友 也是战友"))))
                  (:- '(pre () "(2:40:00) 香港 绝密文件")
                      (u (:- `(cite () "赴港秘密执法" ,(@ "https://www.youtube.com/watch?v=NtfIYMaWxI0"
                                                          "秘密执法")
                                    (small () "Youtube")))
                         (:- '(pre  () " 合伙人 曲国姣   肖建华"))
                         (:- `(cite () "干预香港司法" ,(@ "https://www.youtube.com/watch?v=Dh2QXVRTwJg"
                                                          "干预司法")
                                    (small () "Youtube")))
                         (:- '(pre  () "曾荫权"))
                         (:- `(cite () "支持香港中资企业 政商双轨制" ,(@ "https://www.youtube.com/watch?v=emwYwzQZAQk"
                                                                         "支持香港中资企业")
                                    (small () "Youtube")))
                         (:- '(pre  () "人民币国际化 党支部 国企化 通过香港企业渗透国外"))
                         (:- '(pre  () "班农先生和凯琳女士 的感受  钱没有真正用到国内 都撒币了"))))
                  (:- '(pre () "(3:0:00) 台湾 绝密文件")
                      (u (:- `(cite () "涉台文件" ,(@ "https://www.youtube.com/watch?v=HT_p-JJ4yug"
                                                      "涉台")
                                    (small () "Youtube")))
                         (:- '(pre  () "中共 担心 蔡英文不承认92共识"))
                         (:- '(pre  () "另外两个文件 暂时不播 给刚刚发信息来的人面子  文件中 涉及到 台湾一些具体的家族 收受中共利益 "))
                         (:- '(pre  () "班农先生和凯琳女士 的感受 "))))
                  (:- '(pre () "(3:08:40) 向 金正恩和金与正 发出的警告")
                      (u (:- '(pre  () "文件的很多附件 会直接发给 北朝鲜当时接待郭先生的朋友"))
                         (:- '(pre  () "文件: 埃利奥特·布洛伊迪(Elliott Broidy) 发给 司法部长的邮件"))
                         (:- '(pre  () "中共高层 5月用 金家 在澳门的账户资产信息给了美国  7月把 金正恩的指纹 生理信息 交给了 美国  用来交换 郭文贵"))
                         (:- '(pre  () "班农先生和凯琳女士 的感受 "))))
                  (:- '(pre () "刘特佐 孟建柱 高盛"))
                  (:- '(pre () "(3:34:00) 恭贺新年"))
                  (:- '(pre () "上天一定灭掉共产党 灭掉共产党 灭掉共产党 灭掉共产党 灭掉共产党 灭掉共产党 灭掉共产党 灭掉共产党 灭掉共产党 灭掉共产党  共产党会消失 绝对同意"))
                  (:- '(pre () "过去的文贵已经死了 我不会再为金钱活着 我见过钱什么样 我也不会让共产党把我吓倒 我必须为我死去的八弟负责任 29年前向弟弟的骨灰发过誓 一定干掉共产党 我永不妥协 永不改变 无论发生什么事情 都无法改变 过去29年 每时每刻 我都在问自己 我能做到吗 29年的努力 用我的实力 和 我听从上天的召唤 我有绝对的信心 干掉中国共产党 .."))
                  (:- '(pre () "(4:0:40) 失踪的人们")
                      (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=opHH0BmuPvQ"
                                           "失踪的人们")
                                    (small () "Youtube")))
                         (:- '(pre  () "被抓 被失踪 被自杀 "))
                         (:- '(pre  () "网传 王岐山言论 20万被枪毙 (我: 没你党 有法治 哪用得着20万就枪毙 腐败哪有那么猖獗 要用如此极刑)"))
                         (:- '(pre  () "班农先生和凯琳女士 的感受和想法  法治基金  为什么中共国那么多名人死或失踪 却没有任何世界媒体关注? 帮凶 责任  家人 "))
                         (:- '(pre  () "电视认罪"))
                         (:- '(pre  () "钱去哪了"))
                         (:- '(pre  () "王岐山 领导反腐 干掉一千万家庭  魔鬼 灭绝人性  以贪反贪"))
                         (:- '(pre  () "刘鹤父亲 受文革迫害跳楼自杀"))
                         (:- '(pre  () "强烈怀疑 这些文化大革命脑子受过伤的人 是不是 在报复全中国人民 全世界"))))
                  (:- '(pre () "(4:24:20) 人民群众是敌人吗?")
                      (u (:- '(pre  () "王岐山 强拆")
                             (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=yWJWCoVYF_Q"
                                                  "王歧山内部讲话完整版 党内新左王 惊悚建议官员回归原教旨")
                                           (small () "2015.4.13 王岐山书记 在加强 中央纪委派驻机构建设工作培训班 开幕式上 的辅导报告 ")
                                           (small () "2016.2.24 Youtube ")))))
                         (:- '(pre  () "岐山跟郭先生说过 中国人民就是傻X 根本就没有什么文化 一百年都开不了智 对中国人就得虐待 高压维稳"))
                         (:- '(pre  () "王岐山老婆 89年就是美国绿卡 在美国持有大量房产"))
                         (:- '(pre  () "它用事实证明 中国人该打不开智 抓你100万人 千万家庭破灭 500精英死或失踪 没一个敢放屁的 "))
                         (:- '(pre  () "法治基金 RICO法案 保护 立法"))
                         (:- '(pre  () "班农先生和凯琳女士 的感受和想法  对待中国人民 猪狗不如  帮凶 负责  不分享权力 凌驾法律"))))
                  (:- '(pre () "感谢 很早就进入社会"))
                  (:- '(pre () "(4:42:00) 班农先生 介绍 法治基金未来要做什么  继续深入调查 那些失踪死亡的人 海航  让中国能够法治"))
                  (:- '(pre () "法治基金")
                      (u (:- `(cite () ,(@ "https://rolfoundation.org/index.html"
                                           "Rule of Law Foundation")))
                         (:- `(cite () ,(@ "https://rolsociety.org"
                                           "Rule of Law Society")))))
                  (:- '(pre () "..."))
                  (:- '(pre () "祈福"))
                  (:- '(pre () "..."))
                  (:- '(pre () "必须行动"))
                  (:- '(pre () "感谢大家 一切都是刚刚开始"))
                  (:- '(pre () "(未播放视频)")
                      (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=bcfvCSdj5Ls"
                                           "底层商贩是我们敌人么")
                                    (small () "Youtube")))
                         (:- `(cite () ,(@ "https://www.youtube.com/watch?v=It-HvxmPpNo"
                                           "案子进展")
                                    (small () "Youtube"))))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.4")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/174132")
               '(q () (pre () "
2月3号．按着鬼仔六王岐山的这个说法，他本人应该被枪毙10兆次……鬼子六王岐山……永远用这种似是而非的吃草逻辑！和这种骗人的鬼学！厚黑思想蒙蔽9千万党员！玩弄14亿人民！视他人如猪狗！这是天下最大的恶魔！此人必将遭受上天最大的惩罚…")))
           (:- "郭文: " (@ "https://www.guo.media/posts/174126")
               '(q () (pre () "
2月3号明天直播的站桩已经配套完毕，真是万分感谢！【不尿你】【劳瑞奇】所有的员工们！和意大利总部的鼎力支持！加班加点的完成每套8件套装！一切都是刚刚开始！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/174095")
               '(q () (pre () "
尊敬的战友们好：法治基金所有手续已经注册完毕！即日起全面运行！稍后有关系细节文贵会为大家做视频专门解释！这是官网相关信息，请大家多提意见！一切都是刚刚开始！"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=nIAHNCucCkM"
                                    "法制基金网站介绍 - Rule of Law Foundation & Rule of Law Society")
                             (small () "Youtube")))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=MbxAsQ271SQ"
                           "2019 文贵看春晚中英文双语频道收看方式/ 2019 Miles Guo & Steve Bannon's Chinese New Year Broadcasting Bilingual")
               '(small () "Youtube")
               (u (:- `(cite () "直播链接: " ,(@ "https://www.guo.media/broadcasts")))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=NhyQ0fSdJzU" "2月3号尊敬的战友们好：文贵在2018年的农历年的最后一天，向大家报平安直播。")
               '(small () "Youtube")
               (u (:- '(pre () "2018 经历 意义  说很容易 做真是太难"))
                  (:- '(pre () "文贵看春晚 排演 8小时"))
                  (:- '(pre () "重点: 圣者达赖喇嘛的视频 向北朝鲜金家传递的信息 王孟的新料"))
                  (:- '(pre () "纽约时间 7pm  今夜无人入眠"))
                  (:- '(pre () "防骇客 防攻击"))
                  (:- '(pre () "郭战服 已寄出"))
                  (:- '(pre () "王健之死"))
                  (:- '(pre () "国内\"劝说\"的又来了 郭先生: 要觉得文贵还有恐惧和幻想 那就太不是郭文贵了 幻想不会再有 恐惧从来没有也不会有"))
                  (:- '(pre () "祈福"))
                  (:- '(pre () "全共皆兵 应对文贵爆料"))
                  (:- '(pre () "用真相让全世界人 看到中共的威胁 用真善狠 对它们的假丑恶")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.3")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/173924")
               '(q () (pre () "
2月2号．文贵衷心的感谢所有的战友发给文贵的各种信息－这些七律诗词！万分感激！一切都是刚刚开始！
")))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=BtYvR4MW8U8"
                           "2月2号尊敬的战友们好：你们健身了吗？文贵正在准备着文贵看春晚的节！正在高度关注委内瑞拉的局势变化！和3月20号习近平先生的访问梵蒂冈！川金会川习会！一切都是刚刚开始！")
               '(small () "Youtube")
               (u (:- '(pre () "2,3月 是 大日子  川金会  川习会(会不会发生呢?)"))
                  (:- '(pre () "宗教 3.20 习近平访问梵蒂冈"))
                  (:- '(pre () "欧洲某国总理 说 以个人担保 政府担保 要接郭先生去 他们国家和梵蒂冈演讲"))
                  (:- '(pre () "美国某地的天主教聚会 想让郭先生去 2月底 连续3,4天"))
                  (:- '(pre () "委内瑞拉 变化 内部在讲数 勾兑  值得借鉴的经验"))
                  (:- '(pre () "中美贸易 原来预测的戏剧性 但还没结束"))
                  (:- '(pre () "每逢佳节倍思亲  保重身体")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.2")
        (u (:- "郭文(图片): "
               (@ "https://www.guo.media/posts/173796")
               (@ "https://www.guo.media/posts/173795")
               '(q () (pre () "
前美国司法部员工George Higginbotham 因腐败被公诉书

DOJ George Higginbotham Indictment"))
               (u (:- '(pre () ""))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=DpoaPWqlXz4"
                           "2月1号尊敬的战友们好。你们健身了吗！一切都是刚刚开始！文贵来谈谈海航王建被自己的生殖器戳死的法国解放报的报道……和昨天刘鹤．被羞辱后的自己的感受！")
               '(small () "Youtube")
               (u (:- '(pre () "开会 研究RICO法案  法治基金英文名"))
                  (:- '(pre () "文贵看春晚 团队彩排"))
                  (:- '(pre () "刘鹤 个人是不错的 但它效忠了魔鬼集团"))
                  (:- '(pre () "刘鹤 昨天在 总统办公室的情景  郭先生 感觉不舒服 心情不好  可怜 但美国没必要这么做 大国要有大国的风范  可悲 这样的人才落得如此下场  可恨 它们的骗和中共的厚黑学"))
                  (:- '(pre () "法国 解放报的报道 王健死 (我: 不懂法文 不知道是否翻译有误 关于生殖器插入腹腔  我看这报道时 是下身 是早先翻译错 还是理解错?) :")
                      (u (:- `(cite () 
                                    ,(@ "https://www.liberation.fr/france/2019/01/30/wang-et-la-chute-du-mur-de-bonnieux_1706487"
                                        "Wang et la chute du mur de Bonnieux")
                                    (small () "2019.1.30 Libération")))
                         (:- `(cite () 
                                    ,(@ "http://cn.rfi.fr/中国/20190131-海航前董事长王健死于意外还是谋杀"
                                        "海航前董事长王健死于意外还是谋杀？")
                                    (small () "2019.1.31 (2.1修改) 法广")))))
                  (:- '(pre () "郭先生 还没有亮王健死的证据 让它们先玩 先演"))
                  (:- '(pre () "祈福")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.1")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/173713")
               '(q () (pre () "
2月1日：好消息又来啦…… 美国司法部今天宣布，美国DC地方法院提起民事没收诉讼，要求没收和追回超过7300万美元的资金，这些资金与国际阴谋欺诈美国金融机构以及通过金融机构洗钱有关。 刘特佐．孟建柱的私生子……Jho Low，与孟建柱及孙立军还有吴征这个畜生都是一回事儿的搞事者……对爆料革命而言！这好事儿实在都应接不暇了！太搞笑了！共产党的政法委书记……还有他的秘书．搞政治保护的情报高官！公安部副部长孙力军！和一个天天带着老婆找钥匙的娱乐骗子吴征！搞了这么大一个国际腐败案件！这是对14亿中国人和中国450万政法战线的侮辱！"))
               (u (:- `(cite () "郭文图片: "
                             ,(@ "https://www.justice.gov/opa/pr/us-seeks-recover-over-73-million-proceeds-traceable-bank-fraud-conceal-involvement-jho-taek"
                                 "U.S. Seeks to Recover over $73 Million in Proceeds Traceable to Bank Fraud to Conceal the Involvement of Jho Taek Low")
                             (small () "2018.11.30 DOJ")))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/173638")
               '(q () (pre () "
1月31号：尊敬的战友们．这是美国司法部！第一例涉及外国人的內部人员．乔治．辛吉波萨姆的腐败案件起诉书！美国的参与腐败者！就是共和党的筹款委员会成员之一．公关公司．艾立．搏一迪．外国人就是中国的孟建柱孙立军吴征！马来西亚的刘特佐！这是一个极其罕见震惊了美国司法界的具有代表性的案例！来自中共的蓝金黄的真实案例！很多细节和犯罪都和文贵及爆料有关！通过这个案件！可以看到共产党对文贵的打压迫害，恐惧到了什么程度！稍后我会将英文原版的起诉书也挂出来！这个案件是打开孟建柱孙立军．吴征！在美国及其他国家犯罪，洗钱，找钥匙🔑！😂😂😂行贿外国官员的证据之一！这其中的部分钱就有投资到了明镜媒体！及博讯媒体！和在西方的很多砸锅的所谓自媒体！以及支付缠讼文贵的律师费……所有的这些钱的去向都将会被一一．查清．这是天赐的礼物！一切都是刚刚开始！"))
               (u (:- '(pre () "郭文图片: 起诉书(中文版)"))))
           (:- "郭文(报平安 短视频): " (@ "https://www.guo.media/posts/173556")
               '(q () (pre () "
1月3 11号尊敬的战友们好：你们健身了吗？你们往身上泼水了吗！今天的纽约刚刚下过雪！阳光明媚！非常非常特别！非常非常的舒服！一切都是刚刚开始！"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=_hwPBCM0Edc&feature=youtu.be"
                                    "1月31日郭文贵详解美中談判 华盛頓的早餐相當不平靜")))
                  (:- '(pre () "华盛顿 都要求整出几张纸来 不要把话说绝了 互相欺骗 打太极"))
                  (:- '(pre () "战友的那些不能公开的话和信息 将成为追求法治自由信仰的中国 最最伟大的信息和资料  郭先生将永久保存"))
                  (:- '(pre () "春节 别大吃大喝 烂醉 太滥俗  珍惜自己和他人的生命健康"))
                  (:- '(pre () "收到 很多 韩文的信息 尽量明白 谢谢"))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/173435")
               '(q () (pre () "
1月30日：文贵衷心感谢战友之声和战友麦子！做的这个文贵看春晚的视频！万分感激！一切都是刚刚开始！"))
               (u (:- `(cite () "郭文视频: "
                             ,(@ "https://www.youtube.com/watch?v=_Km8rIQ4hg8"
                                 "喜迎文贵看春晚，战友们的春晚，中国人的春晚！战友之声视频剪辑组义工们太棒了！")
                             (small () "Youtube"))))))))
 *news-topics-guo*)

(push
 (u (:- (@ "/testwebsite/articles/2019/1/guo-news-201901.html" "2019.1")))
 *news-topics-guo*)

(push
 (u (:- (@ "/testwebsite/articles/2018/12/guo-news-201812.html" "2018.12")))
 *news-topics-guo*)

(push
 (u (:- (@ "/testwebsite/articles/2018/11/guo-news-201811.html" "2018.11")))
 *news-topics-guo*)

(push
 (u (:- (@ "/testwebsite/articles/2018/10/guo-news-201810.html" "2018.10")))
 *news-topics-guo*)

(news-to-topic
 "郭文贵"   ;; (twb::human-date (get-universal-time))
 "2019.02.26 23:37:56"
 (u (:- "信息源"
        (u (:- "郭媒体 : " (@ "https://www.guo.media/milesguo" "@milesguo"))
           (:- "Youtube : " (@ "https://www.youtube.com/channel/UCO3pO3ykAUybrjv3RBbXEHw/featured" "郭文贵"))
           (:- "Instagram : " (@ "https://www.instagram.com/guowengui/" "guowengui"))))
    (:- "郭七条"
        (u (:- "反对 以黑治国 以警治国 以贪反贪 以黑反贪")
           (:- "不反国家 不反民族 不反习主席")
           (:- '(span (:class "badge badge-secondary") "修改增加: ") "反对以假治国")))
    (:- "蓝金黄 3F计划")
    (:- "海航王健事件"
        (u (:- "王健之死 与 海航集团背后的真相 发布会"
               (u (:- "时间: 2018年11月20日 美国东部时间 早上10-12点")
                  (:- "地点: 纽约"
                      (@ "https://www.thepierreny.com" "The Pierre Hotel")
                      `(small () (span (:class "badge badge-light" :style "position: absolute;")
                                       ,(@ "https://en.wikipedia.org/wiki/The_Pierre" "Wiki"))))))
           (:- '(small () "2018.11.19")
               (u (:- "郭文: " (@ "https://www.guo.media/posts/147483")
                      '(q () (pre () "
11月18日：律师又要求修改文件．全部加班呢……以法治国．的确让人很累．很花钱．但是我感觉很幸福很开心！因为能让我感觉我是在一个安全的公平的环境里生存！一切都是刚刚开始！")))))
           (:- '(small () "2018.11.18")
               (u (:- "视频: " (@ "https://www.youtube.com/watch?v=D9ggVuylclY"
                                  "2018年11月17日：11月20号的新闻发布会进展报告，遇到了巨大的困难，但是一定会照常进行。"))
                  (:- "郭文(照片和视频): "
                      (@ "https://www.guo.media/posts/147013")
                      ".."
                      (@ "https://www.guo.media/posts/147016")
                      '(q () (pre () "
11月17日：凯琳在为她们翻译．她们说王健百分之百的是没有自拍．不是……警察封锁了一切真相！威胁人们不要讲话……

11月17日：他来了．她也来了．太不容易了！凯琳正在翻译！")))))
           (:- '(small () "2018.11.16")
               (u (:- "视频: " (@ "https://www.youtube.com/watch?v=cqjWOczCby0" "2018．11月15日：11月20日在纽约举行巜王健之死．海航背后的真相发布会》的正式公告！"))))
           (:- '(small () "2018.11.15")
               (u (:- "郭文: " (@ "https://www.guo.media/posts/145989")
                      '(q () (pre () "
11月14日：尊敬的战友们好！我刚刚收到律师团队的通知！明天中午前才能得到法院最后的批准！ 所以会议是19号还是20号．要等到明天中午12点前才能决定！文贵再次致以万分的歉意！")))
                  (:- "视频: " (@ "https://www.youtube.com/watch?v=0VE05drVdz8"
			                      "2018．11月19号的王健之死的发布会．可能导致股市波动．及其他重大政治事件！要从19号改至20号！"))))
           (:- '(small () "2018.11.6")
               (u (:- "郭文(多条 照片): " (@ "https://www.guo.media/posts/143276")
                      '(q () (pre () "
11月5日：11月19日．将是一个什么样的结果！什么样的情况！一个又一个的威胁向我冲来……我现在收到的劝说！利诱……前所没有！我现在正在向有关人介绍发布会的情况！")))))
           (:- '(small () "2018.11.1")
               (u (:- "郭文: " (@ "https://www.guo.media/posts/141318")
                      '(q () (pre () "
我们是王健先生被杀案的独立调查者．花钱．时间．人力．承担风险最大的调查团队！这个荒唐的王健一人独立的爬墙死！是对全世界人民的智商的侮辱 ... 上神．不会放过一个做恶欺天的人！")))))
           (:- '(small () "2018.10.30")
               "最新法国官方调查结果"
               (u (:- (@ "https://freebeacon.com/national-security/french-court-rules-chinese-tycoon-died-accident/" 
                         "French Court Rules Chinese Tycoon Died in Accident")
                      '(small () "2018.10.30 FreeBeacon"))
                  (:- "中文翻译: " (@ "https://littleantvoice.blogspot.com/2018/10/bill.html?m=1"
                                      "翻译：自由灯塔Bill 法国法院裁定中国大亨死于意外 海航联合创始人王建的死亡之谜")
                      '(small () "2018.10.30 战友之声") )))
           (:- '(small () "2018.10.29")
               (u (:- "郭文: " (@ "https://www.guo.media/posts/140349")
                      '(q () (pre () "
10月28日：关于王健被谋杀……法国阿尼翁地方法法院的判决近日将公布……然后…… 他们一个一个的公布！ 为的就是挑战我们的发布会！ 他们将为他们无知付出巨大代价！ 他们要先下手为强！ 但是他们不了解我们拥有什么样的力量！ 我要的就是这个结果！ 按这样一剧情发展！ 我们将会将发布会变成王岐山的送葬会！天助我也……一切都是刚刚开始！ 我们的新闻发布会将是一场空前的法律大战！反黑反谋杀的大战！目前为止已经有223家世界级的媒体要求参加……我们可能只能允许30家媒体到现场了！有关部门已经正式告知我们！已经获得准确信息！CCP将不惜一切代价！阻止新闻发布会举行！但是我告诉他们！我们即使付出生命的代价都不会放弃！天塌地陷我们也不会放弃！✊️✊️✊️")))
                  (:- "郭文(短视频): " (@ "https://www.guo.media/posts/140293")
                      '(q () (pre () "
10月28日：法国司法部决定．高院和普罗旺死法院里昂法院联合做出一个判决．王健被杀案很多关键的事实否定．并通过法院来坐实建属于自己杀自己．自己找死……法院判决结果！并没有任何证人和杀手在现场！法国版的大连法院审判！一切都是刚刚开始！")))
                  (:- "视频: " (@ "https://www.youtube.com/watch?v=1O8D-gWQD7o"
                                  "战友之声 20181028 郭文贵直播（完整版） 中美将进入全面金融贸易战 新疆集中营问题将得到国际社会的关注，法国内政部被绿了？")
                      (u (:- '(pre () "(32:00) 王健之死的进展 法国新的调查报告 中共为掩盖事实的无耻行径 法国蓝金黄的程度可见一斑"))
                         (:- '(pre () "(46:50) 官方人说: 孟宏伟被抓 很大程度上与王健之死有关 因为孟被抓 好几人中共国人也在法国消失"))
                         (:- '(pre () "(52:00) 王健之死新闻发布会 会 异常的精彩 异常的平淡 也会..."))))))
           (:- '(small () "2018.10.28")
               "郭文: " (@ "https://www.guo.media/posts/140047")
               '(q () (pre () "
10月27日：当我今天看到法国内政部．及关于王健之死调查小组的调查报告．更新版时！我极为的兴奋与激动．似乎我所有担心的事情都发生了！更加印证了．我获得的情报的准确性😹关于王健之死与裴楠楠．王岐山和以及法国的华镔等沉默的力量的勾结！的细节！以及在法国蓝金黄力量的强大！例如其中的很多细节的陈述和前几个月前的调查报告完全相反！我不能一一在此列举！如报告中……（王建之死没有任何人在场……是他自己跳下去的！更不存在助跑．自拍……)😇😇😇这和前几版调查总结和报告．及中国官方．海航的公告……完全相反！这更加坐实了是他们一起谋杀了王健先生！而且对王建先生所见的人名单很多人被剔除……资产转让协议的事情这次报告更详细了！……虽然他们想再一次的瞒天过海……但我深信这又是上天赐给我们的一个大礼物．一切都是刚刚开始！🙏🙏🙏🙏🙏🙏
")))
           (:- '(small () "2018.10.9")
               "郭文: " (@ "https://www.guo.media/posts/134471")
               '(q () (pre () "王岐山已经做了放弃陈峰．和＂必须搞回王健夫人儿子．弟弟王伟的决定！＂而且是要求不惜一切代价不限任何方式！")))))
    (apply #':- "主要内容跟踪" (nreverse *news-topics-guo*))))

(news-to-topic
 "中美" ;; (human-date (get-universal-time))
 "2018.12.04 20:10:20"
 (u (:- '(small () "2018.11.30-12.1")
        "G20 (2018 G20 Buenos Aires summit)")
    (:- '(small () "2018.11.14")
        (@ "https://www.washingtontimes.com/news/2018/nov/14/inside-the-ring-remove-chinese-missiles/"
           "Trump demands China remove missiles in the South China Sea")
        '(small () "The Washington Times")
        '(q () (pre () "
The Trump administration is demanding that China remove all advanced missiles deployed on disputed islands in the South China Sea, the first time such a demand has been made public.")))
    (:- '(small () "2018.11.9")
        (@ "https://youtu.be/g3rxjaOPQD4"
           "Economic Security as National Security: A Discussion with Dr. Peter Navarro")
        '(small () "Youtube"))
    (:- '(small () "2018.11.7")
        (@ "https://cn.wsj.com/articles/CN-BGH-20181105071808"
           "美国正式重启对伊制裁 中国入豁免名单")
        '(small () "华尔街日报")
        '(q  () (pre () "周一美国实施了对伊朗石油的禁令，同时对700多家伊朗银行、公司和个人进行了制裁，正式启动了其最大施压行动的第二阶段。但中国、印度、意大利、希腊、日本、韩国、台湾和土耳其得到豁免，可暂时继续进口伊朗原油。"))
        (u (:- '(pre () "(我: 我还以为要豁免中共犯下的一切罪行呢 😝)"))))
    (:- '(small () "2018.11.1")
        "Attorney General Jeff Sessions Announces New Initiative to Combat Chinese Economic Espionage"
        '(small () " -U.S. DOJ : ")
        (@ "https://www.youtube.com/watch?v=zHi1iTjQ_FQ&feature=youtu.be"
           "视频")
        " "
        (@ "https://www.justice.gov/opa/speech/attorney-general-jeff-sessions-announces-new-initiative-combat-chinese-economic-espionage"
           "文本")
        '(q () (pre () "
As the cases I’ve discussed have shown, Chinese economic espionage against the United States has been increasing—and it has been increasing rapidly.

We are here today to say: enough is enough.  We’re not going to take it anymore.

It is unacceptable.  It is time for China to join the community of lawful nations.  International trade has been good for China, but the cheating must stop. And we must have more law enforcement cooperation; China cannot be a safe haven for criminals who run to China when they are in trouble, never to be extradited. China must accept the repatriation of Chinese citizens who break U.S. immigration law and are awaiting return.
...
This Department of Justice—and the Trump administration—have already made our decision: we will not allow our sovereignty to be disrespected, our intellectual property to be stolen, or our people to be robbed of their hard-earned prosperity.  We want fair trade and good relationships based on honest dealing.  We will enforce our laws—and we will protect America’s national interests."))
        (u (:- `(cite () "中文参考: "
                      ,(@ "https://www.voachinese.com/a/chinese-criminal-20181101/4638912.html?utm_source=dlvr.it&utm_medium=twitter"
                          "针对中国经济间谍活动美司法部长宣布新行动")))))
    (:- '(small () "2018.10.26")
        (@ "https://www.state.gov/secretary/remarks/2018/10/286926.htm"
           "Interview With Hugh Hewitt of the Hugh Hewitt Show")
        (u (:- "中文参考: " (@ "https://www.voachinese.com/a/pompeo-china-2018-10-26/4631048.html"
                               "蓬佩奥：中国的每一个挑衅都会得到美国强有力的回应")
               '(small () "2018.10.27 VOA"))))
    (:- '(small () "2018.10.22")
        (@ "https://freebeacon.com/national-security/u-s-warships-transit-taiwan-strait/"
           "U.S. Warships Transit Taiwan Strait")
        '(p () (small () "Two Navy warships transited the Taiwan Strait on Monday in a show of force in Pentagon efforts to push back against China's expansive claims to control waters near the communist mainland.")))
    (:- '(small () "2018.10.12")
        (@ "https://freebeacon.com/national-security/bolton-warns-chinese-military-halt-dangerous-naval-encounters/"
           "Bolton Warns Chinese Military to Halt Dangerous Naval Encounters")
        '(p () (small () "White House National Security Adviser John Bolton says Navy rules allow response to threatening Chinese actions")))
    (:- '(small () "2018.10.11")
        "首次 中共国 情报官员 被引渡至 美国 公开受审"
        (u (:- "源自: "
               (@ "https://www.justice.gov/opa/pr/chinese-intelligence-officer-charged-economic-espionage-involving-theft-trade-secrets-leading"
                  "DOJ: Chinese Intelligence Officer Charged with Economic Espionage Involving Theft of Trade Secrets from Leading U.S. Aviation Companies"))
           (:- "中文参考: " (@ "https://www.bbc.com/zhongwen/simp/world-45819520"
                               "BBC: 涉嫌盗取美国航空业机密　中国籍男子面临“间谍”检控"))
           (:- '(pre () "美司法部: 以经济间谍罪起诉 涉嫌窃取美国航空和航天公司商业机密的 中国情报官员 Xu Yanjun"))
           (:- '(pre () "4.1 在比利时被捕"))
           (:- '(pre () "10.9 被引渡至美国"))
           (:- '(pre () "10.10 起诉书被正式公开"))))
    (:- '(small () "2018.10.8")
        "美国国务卿 蓬佩奥 访问中共国")
    (:- '(small () "2018.10.4")
        "美国副总统 彭斯 哈德逊研究所演讲"
        (u (:- "全文"
               (u (:- "英:" (@ "https://www.whitehouse.gov/briefings-statements/remarks-vice-president-pence-administrations-policy-toward-china/"
                               "Remarks by Vice President Pence on the Administration’s Policy Toward China"))
                  (:- "中:" (@ "https://www.voachinese.com/a/pence-speech-20181004/4600329.html"
                               "彭斯副总统有关美国政府中国政策讲话全文翻译"))))
           (:- "视频(中文同传):" (@ "https://youtu.be/i8DtP3PB-gc"
                                    "彭斯副总统有关美国政府中国政策讲话(中文同传)"))
           (:- "重点 (由于全文 基本上都可以说是重点 所以我只列出一些大意)"
               (u (:- "中共 对外"
                      (u (:- "前所未有的 使用各种手段 影响 美国制度和政策 来获利")
                         (:- "偷盗美国的技术 强迫美企技术转让 利用美国的技术壮大其军事力量")
                         (:- "违背承诺 将南海军事化 同时 侵犯美自由航行的舰只")
                         (:- "债务外交 通过烂贷 获取 经济和军事利益 (我: 最后都肥了各国盗国贼)")
                         (:- "威胁台湾")
                         (:- "干预美国中期选举 影响舆论")
                         (:- "要求某美国大公司公开反对美国关税政策 否则取消其营业执照")
                         (:- "要求合资公司 设立党支部 对决策进行影响 甚至否决")
                         (:- "影响 广播等媒体 记者 大学 研究机构 智库 好莱坞 等等 为其唱赞歌 或 消除负面报道"
                             '(q () (pre () "
说的就是 郭文贵先生去年在 哈德逊的演讲被取消
After you offered to host a speaker Beijing didn’t like, your website suffered a major cyberattack, originating from Shanghai. The Hudson Institute knows better than most that the Chinese Communist Party is trying to undermine academic freedom and the freedom of speech in America today.")))))
                  (:- "中共 对内"
                      (u (:- "人权问题恶化 压迫自己的人民")
                         (:- "成为监视型的国度 监视方法更具侵略性 且 是使用美国的技术做到的")
                         (:- "防火长城 阻碍信息自由交流")
                         (:- "信用评分 将严重的干预和限制人们的生活 (我: 这种超乎法律之上的系统 对于中共国这种国家 极易并滥用)"
                             '(q () (pre () "
And by 2020, China’s rulers aim to implement an Orwellian system premised on controlling virtually every facet of human life — the so-called “Social Credit Score.” In the words of that program’s official blueprint, it will “allow the trustworthy to roam everywhere under heaven, while making it hard for the discredited to take a single step.”")))
                         (:- "限制 宗教发展 下架圣经 烧十字架 打压西藏佛教徒 在新疆监禁百万伊斯兰教信众进行洗脑 (我: 中共打击一切它们不允许的信仰 更限制任何组织的发展 尤其是具有极大凝聚力的宗教)")))
                  (:- "美国 态度"
                      (u (:- "过去几十年 美国帮助中国发展壮大 并期许其走向自由文明 但现在 美国意识到 中共对 民主自由等等承诺 都是空谈")
                         (:- "通过相应行动做出了回应 并 寻求 公平 互惠 尊重主权 关系")
                         (:- "美国优先")
                         (:- "会继续奉行一个中国的政策 但相信台湾对民主的拥抱 为所有的中国人 提供了一条更好的道路 ")
                         (:- "并不希望中共国经济受损 而是希望其繁荣 但希望中共的贸易政策是 自由 互惠 公平  并且 不仅仅停留在嘴上")
                         (:- "应对外国媒体宣传 要求注册外国代理人")
                         (:- "让其停止强迫技术转让 保护美国企业的私人财产的利益")
                         (:- "简化国际开发和融资计划 为外国提供 更透明公正的另一个选择 而不用依赖中共国")
                         (:- "相信会看到 更多的 企业 学者 媒体 等 会在 价钱和价值 间做出更好的选择")
                         (:- "在中共真正改变 而不是打口炮 并对美国表示尊重之前 美国不会放弃或松懈 ")
                         (:- "平等对待"
                             '(q () (pre () "
The great Chinese storyteller Lu Xun often lamented that his country, and he wrote, “has either looked down at foreigners as brutes, or up to them as saints,” but never “as equals.” ")))
                         (:- "长远 (我: 只看自己 认为人不会死 故作死, 你看 要死了吧)"
                             '(q () (pre () "
“Men see only the present, but heaven sees the future.”")))))))))))

(news-to-topic
 "中共国" ;; (human-date (get-universal-time) )
 "2018.10.30 12:02:11"
 (u (:- "事件"
        (u (:- '(small () "2018.10.20")
               "澳门中联办主任 郑晓松 死亡"
               (u (:- '(pre () "郭文贵: 是被杀 他与孟宏伟是好哥们"))
                  (:- '(pre () "中共官方: 中央人民政府驻澳门特别行政区联络办公室主任 郑晓松同志 因患抑郁症 于2018年10月20日晚 在其澳门住所 坠楼身亡")))))
        (u (:- "孟宏伟")))
    (:- "国外"
        (u (:- '(small () "2018.10.26")
               (@ "https://www.cbc.ca/news/politics/mcccallum-china-trade-human-rights-1.4878455"
                  "Canada prepared to stall trade deal with China until its behaviour is 'more reasonable'")
               '(small () "CBC"))))))

(news-to-topic
 "美国" ;; (human-date (get-universal-time))
 "2019.02.09 19:45:51"
 (u (:- '(small () "2019.2.7") "美国总统 川普 美国时间2月五日晚 在国会 发表 国情咨文演说"
        (u (:- `(cite ()
                      ,(@ "https://www.youtube.com/watch?v=fpf1IYU0poY"
                          "President Trump Delivers the State of the Union Address")
                      (small () "2019.2.5 Youtube : The White House")))
           (:- `(cite ()
                      ,(@ "https://www.youtube.com/watch?v=RwrnbSC32sw"
                          "美国总统特朗普国情咨文特别节目")
                      (small () "2019.2.5 Youtube : 美国之音 (中文同声传译)")))))
    (:- '(small () "2018.11.7") "Midterm elections 2018 美国中期选举"
        '(q () (pre () "
    结果      | Republican 共和党 | Democratic 民主党 |
Senate 参议院 |  Win:  51        |         43       |
House  众议院 |       193        |   Win: 219       |
")))
    (:- '(small () "2018.10.23")
        "德州大学基金 引领 新规则 将从被美国制裁的实体中撤资"
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=aCdDjXTrgTQ"
                           "Watch CNBC's full interview with Hayman Capital's Kyle Bass"))
           (u (:- `(pre () "中文跟译: " ,(@ "https://www.youtube.com/watch?v=sQ4Yrj6tISw"
                                            "啸天英语读报点评第21期 20181023--郭式隔山打牛亮招CNBC;同步翻译解读Kyle Bass（德州大学基金 UTIMCO)如何带头打击中共并隔空取钱-期限180天！")))))
        (u (:- "相关"
               (u (:- '(samll () "2018.10.23")
                      (@ "https://www.zerohedge.com/news/2018-10-23/kyle-bass-trump-has-strongest-negotiating-position-weve-ever-had-against-china"
                         "Kyle Bass: Trump Has \"Strongest Negotiating Position We've Ever Had\" Against China")
                      (u (:- "中文翻译: " (@ "https://littleantvoice.blogspot.com/2018/10/kyle-bass-trump-has-strongest.html?m=1"
                                             "翻译：凯尔巴斯：特朗普有和中国谈判的最强“筹 码”")))))
               (u (:- '(samll () "2018.10.23")
                      (@ "https://www.bloombergquint.com/markets/university-of-texas-to-impose-new-rules-as-iran-sanctions-loom#gs.cQuj904"
                         "University of Texas Endowment to Impose New Rules for Iran Ties")))))
        (u (:- "补充"
               (u (:- "Kyle Bass"))
               (u (:- "UTIMCO 德州大学基金")))))
    (:- '(small () "2018.10.19")
        (@ "https://www.dni.gov/index.php/newsroom/press-releases/item/1915-joint-statement-from-the-odni-doj-fbi-and-dhs-combating-foreign-influence-in-u-s-elections"
           "Joint Statement from the ODNI, DOJ, FBI and DHS: Combating Foreign Influence in U.S. Elections")
        (u (:- "中文参考: " (@ "https://www.voachinese.com/a/joint-statement-from-odni-doj-fbi-dhs-us-election-20181019/4621623.html?utm_source=dlvr.it&utm_medium=twitter"
                               "美执法部门联合声明 共同对抗外国渗透美国选举"))))
    (:- '(small () "2018.9.26")
        "美国 川普总统 联合国大会演讲"
        (u
         (:- "全文(英文): "
             (@ "https://www.vox.com/2018/9/25/17901082/trump-un-2018-speech-full-text"
                "Read Trump’s speech to the UN General Assembly"))
         (:- "视频(中文字幕): "
             (@ "https://www.youtube.com/watch?v=xm6BnLaFD3I"
                "特朗普在联合国大会的演讲|全程字幕"))
         (:- "视频(VOA中文同传): "
             (@ "https://youtu.be/aw-lwGoeH4A"
                "特朗普总统在73届联合国大会发表讲话"))
         (:- "重点 (我的主观判断 主要是与中美未来相关的): "
             '(q () (pre () "
独立 自主 协作 捍卫自己国民的利益(人民为主人) 尊重各自的文化
We believe that when nations respect the rights of their neighbors, and defend the interests of their people, they can better work together to secure the blessings of safety, prosperity, and peace.
...
I honor the right of every nation in this room to pursue its own customs, beliefs, and traditions. The United States will not tell you how to live or work or worship.
We only ask that you honor our sovereignty in return.


贸易需要公平对等 中共国破坏了规则(倾销 补助 操纵汇率 强迫技术转让 盗窃知识产权 等) 滥用了美国的开放政策 以及当下世贸体制 不能再被容忍 这需要改变
America’s policy of principled realism means we will not be held hostage to old dogmas, discredited ideologies, and so-called experts who have been proven wrong over the years, time and time again.
...
We will no longer tolerate such abuse.
...
America will never apologize for protecting its citizens.
...
I have great respect and affection for my friend, President Xi, but I have made clear our trade imbalance is just not acceptable. China’s market distortions and the way they deal cannot be tolerated.


拒绝全球主义 拥抱爱国主义 (注意 这里并不同于 全球化 globalization, 对爱国主义的概念 中共国人有不同的认知 不能先入为主 )
.. We will never surrender America’s sovereignty to an unelected, unaccountable, global bureaucracy.

America is governed by Americans. We reject the ideology of globalism, and we embrace the doctrine of patriotism.

Around the world, responsible nations must defend against threats to sovereignty not just from global governance, but also from other, new forms of coercion and domination.


外国想再继续干涉美国内政 没门
Here in the Western Hemisphere, we are committed to maintaining our independence from the encroachment of expansionist foreign powers.

It has been the formal policy of our country since President Monroe that we reject the interference of foreign nations in this hemisphere and in our own affairs. The United States has recently strengthened our laws to better screen foreign investments in our country for national security threats, and we welcome cooperation with countries in this region and around the world that wish to do the same. You need to do it for your own protection.


社会主义和共产主义悲剧 主要提到的是委内瑞拉 但是 你懂的
Ultimately, the only long-term solution to the migration crisis is to help people build more hopeful futures in their home countries. Make their countries great again.
...
Virtually everywhere socialism or communism has been tried, it has produced suffering, corruption, and decay. Socialism’s thirst for power leads to expansion, incursion, and oppression. All nations of the world should resist socialism and the misery that it brings to everyone.


对外援助政策转变 非诚勿扰
The United States is the world’s largest giver in the world, by far, of foreign aid. But few give anything to us. That is why we are taking a hard look at U.S. foreign assistance. That will be headed up by Secretary of State Mike Pompeo. We will examine what is working, what is not working, and whether the countries who receive our dollars and our protection also have our interests at heart.

Moving forward, we are only going to give foreign aid to those who respect us and, frankly, are our friends. And we expect other countries to pay their fair share for the cost of their defense.


促进联合国改革 各尽其能 (至少美国暂时不会直接退出了)
The United States is committed to making the United Nations more effective and accountable.
...
Only when each of us does our part and contributes our share can we realize the U.N.’s highest aspirations. We must pursue peace without fear, hope without despair, and security without apology.


同一个世界 同一个问题: 我们想要的的未来是?
It is the question of what kind of world will we leave for our children and what kind of nations they will inherit.
...
Many countries are pursuing their own unique visions, building their own hopeful futures, and chasing their own wonderful dreams of destiny, of legacy, and of a home.

The whole world is richer, humanity is better, because of this beautiful constellation of nations, each very special, each very unique, and each shining brightly in its part of the world.

In each one, we see awesome promise of a people bound together by a shared past and working toward a common future.


美国想要的未来: 坚持一种 自由 独立 法治 家庭 信仰 传统 爱国 和平 安全 的文化, 并捍卫它
As for Americans, we know what kind of future we want for ourselves. We know what kind of a nation America must always be.
...
So together, let us choose a future of patriotism, prosperity, and pride. Let us choose peace and freedom over domination and defeat. And let us come here to this place to stand for our people and their nations, forever strong, forever sovereign, forever just, and forever thankful for the grace and the goodness and the glory of God.
(我: 这段很鼓舞 建议自己去看看)


谢谢 (我: 同时也希望 中国不用再 CCP bless us)
Thank you. God bless you. And God bless the nations of the world.")))))))

(news-to-topic
 "中共国 供应链 恶意芯片植入 事件" ;; (human-date (get-universal-time))
 "2018.10.24 12:51:54"
 (u (:- "主"
        (u (:- '(small () "2018.10.22")
               (@ "https://www.reuters.com/article/us-china-cyber-super-micro-comp/super-micro-to-review-hardware-for-malicious-chips-idUSKCN1MW1GK?feedType=RSS&feedName=technologyNews&utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+reuters%2FtechnologyNews+%28Reuters+Technology+News%29"
                  "Super Micro to review hardware for malicious chips")
               '(q () (pre () "
“Despite the lack of any proof that a malicious hardware chip exists, we are undertaking a complicated and time-consuming review to further address the article,” the server and storage manufacturer said in a letter to its customers, dated Oct. 18.
...
Super Micro denied the allegations made in the report.

The company said the design complexity makes it practically impossible to insert a functional, unauthorized component onto a motherboard without it being caught by the checks in its manufacturing and assembly process.
"))))
        (u (:- '(small () "2018.10.19")
               (@ "https://www.buzzfeednews.com/article/johnpaczkowski/apple-tim-cook-bloomberg-retraction"
                  "Apple CEO Tim Cook Is Calling For Bloomberg To Retract Its Chinese Spy Chip Story")
               '(q () (pre () "
“There is no truth in their story about Apple,” Cook told BuzzFeed News in a phone interview. \"They need to do that right thing and retract it.\"
...
“We turned the company upside down,” Cook said. “Email searches, data center records, financial records, shipment records. We really forensically whipped through the company to dig very deep and each time we came back to the same conclusion: This did not happen. There’s no truth to this.”
"))))
        (u (:- '(small () "2018.10.9")
               (@ "https://www.bloomberg.com/news/articles/2018-10-09/new-evidence-of-hacked-supermicro-hardware-found-in-u-s-telecom?srnd=premium"
                  "New Evidence of Hacked Supermicro Hardware Found in U.S. Telecom")
               '(q () (pre () "
The security expert, Yossi Appleboum, provided documents, analysis and other evidence ...
...
Unusual communications from a Supermicro server and a subsequent physical inspection revealed an implant built into the server’s Ethernet connector, a component that's used to attach network cables to the computer, Appleboum said.
") )))
        (u (:- '(small () "2018.10.4")
               (@ "https://aws.amazon.com/blogs/security/setting-the-record-straight-on-bloomberg-businessweeks-erroneous-article/"
                  "Setting the Record Straight on Bloomberg BusinessWeek’s Erroneous Article")
               '(q () (pre () "
At no time, past or present, have we ever found any issues relating to modified hardware or malicious chips in SuperMicro motherboards in any Elemental or Amazon systems. Nor have we engaged in an investigation with the government.
"))))
        (u (:- '(small () "2018.10.4")
               (@ "https://www.apple.com/newsroom/2018/10/what-businessweek-got-wrong-about-apple/"
                  "What Businessweek got wrong about Apple")
               '(q () (pre () "
Apple has never found malicious chips \“hardware manipulations\” or vulnerabilities purposely planted in any server. Apple never had any contact with the FBI or any other agency about such an incident. We are not aware of any investigation by the FBI, nor are our contacts in law enforcement."))))
        (u (:- '(small () "2018.10.4")
               (@ "https://www.bloomberg.com/news/features/2018-10-04/the-big-hack-how-china-used-a-tiny-chip-to-infiltrate-america-s-top-companies"
                  "The Big Hack: How China Used a Tiny Chip to Infiltrate U.S. Companies")
               '(q () (img (:class "zoom" :src "/testwebsite/articles/resource/thebighack.jpg" :width "50px")) "The Big Hack!"))))
    (:- "相关"
        (u (:- '(small () "2018.10.22")
               (@ "https://www.servethehome.com/investigating-implausible-bloomberg-supermicro-stories/"
                  "Investigating Implausible Bloomberg Supermicro Stories")))
        (u (:- '(small () "2018.10.11")
               (@ "https://www.macrumors.com/2018/10/11/kaspersky-lab-questions-supermicro-allegations/"
                  "Kaspersky Lab Says Report Claiming China Hacked Apple's Former Server Supplier is Likely 'Untrue'")
               '(q () (pre () "
The stories published by Bloomberg in October 2018 had a significant impact. For Supermicro, it meant a 40% stock valuation loss. For businesses owning Supermicro hardware, this can be translated into a lot of frustration, wasted time, and resources. Considering the strong denials from Apple and Amazon, the history of inaccurate articles published by Bloomberg, including but not limited to the usage of Heartbleed by U.S. intelligence prior to the public disclosure, as well as other facts from these stories, we believe they should be taken with a grain of salt."))))
        (u (:- '(small () "2018.10.8")
               (@ "https://9to5mac.com/2018/10/08/chinese-spy-chip-2/"
                  "Comment: Four more reasons it’s now inconceivable Apple lied about Chinese spy chips")
               (u (:- "Reasons:"
                      (u (:- "1. " (@ "https://9to5mac.com/2018/10/05/spy-chip/" "GCHQ statement"))
                         (:- "2. " (@ "https://9to5mac.com/2018/10/07/department-of-homeland-security-apple-spy-chip/"
                                      "Department Homeland Security echoed"))
                         (:- "3. " (@ "https://www.reuters.com/article/us-china-cyber-apple/apple-tells-congress-it-found-no-signs-of-hacking-attack-idUSKCN1MH0YQ"
                                      "Reuters reports"))
                         (:- "4. " (@ "https://krebsonsecurity.com/2018/10/supply-chain-security-is-the-whole-enchilada-but-whos-willing-to-pay-for-it/"
                                      "security researcher Brian Krebs said")))))))
        (u (:- '(small () "2017.2.23")
               (@ "https://www.theinformation.com/articles/apple-severed-ties-with-server-supplier-after-security-concern?jwt=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiYWR4dDNAZ21haWwuY29tIiwiZXhwIjoxNTcwMjIwNzkyLCJuIjoiR3Vlc3QiLCJzY29wZSI6WyJzaGFyZSJdfQ.ls8yD0SpK1SYLoC7TAaPBL8GPEu9Nd8mutWz0EEdU6o&unlock=ac889c2a9c7ed1fa"
                  "Apple Severed Ties with Server Supplier After Security Concern"))))
    (:- "补充"
        (u (:- '(small () "事件相关的 硬件骇客技术的 可能性和方法:")
               `(p ()
                   ,(@ "https://www.servethehome.com/investigating-implausible-bloomberg-supermicro-stories/"
                      "Investigating Implausible Bloomberg Supermicro Stories")
                   (small () "2018.10.22"))
               `(p ()
                   ,(@ "https://www.lawfareblog.com/china-supermicro-hack-about-bloomberg-report"
                       "The China SuperMicro Hack: About That Bloomberg Report")
                   (small () "2018.10.4")))))))

(news-to-topic
 "当前关注自媒体" ;; (human-date (get-universal-time) )
 "2018.11.21 13:29:22"
 '(p () "这只是部分 我将 增量补充 未来我看了新的视频时 再加入" )
 (u (:- "Youtube"
        (u (:- (@ "https://www.youtube.com/channel/UCm3Ysfy0iXhGbIDTNNwLqbQ/featured"
                  "路德社"))
           (:- (@ "https://www.youtube.com/channel/UCNKpqIqrErG1a-ydQ0D5dcA/featured"
                  "战友之声"))
           (:- (@ "https://www.youtube.com/channel/UCQT2Ai7hQMnnvVTGd6GdrOQ"
                  "政事直播(政事小哥)"))
           (:- (@ "https://www.youtube.com/channel/UCkU5hWnORzZMZf9SkFmjF6g"
                  "木蘭訪談"))
           (:- (@ "https://www.youtube.com/channel/UCF8iFfXnkbYIUqykN_xpy8g"
                  "南十字星"))
           (:- (@ "https://www.youtube.com/channel/UCyDCC5CcIqMqBbzMVENoKVQ"
                  "赵岩"))
           (:- (@ "https://www.youtube.com/channel/UCA3-DEkClR3G1DG1cq8YbeQ"
                  "Inty"))))))
