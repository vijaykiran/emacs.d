(require 'sendmail)

(setq gnus-startup-file "~/.emacs.d/.newsrc")

(setq gnus-select-method '(nnimap "gmail"
				  (nnimap-address "imap.gmail.com")
				  (nnimap-server-port 993)
				  (nnimap-stream ssl)))

;; (setq gnus-secondary-select-methods '((nntp "nntp.aioe.org")))
(setq gnus-secondary-select-methods '((nntp "localhost")))

(setq gnus-message-archive-group                   ;设置消息归档的组
      '((if (message-news-p)
            "nnfolder+archive:nnfolder"             ;新闻归档
          "nnmaildir+Company:sent")))                ;邮件归档

(setq gnus-inhibit-startup-message t)               ;关闭启动时的画面
(setq message-confirm-send t)                       ;防止误发邮件, 发邮件前需要确认
(setq message-kill-buffer-on-exit t)                ;设置发送邮件后删除buffer
(setq message-from-style 'angles)                   ;`From' 头的显示风格
(setq message-syntax-checks '((sender . disabled))) ;语法检查

;; 窗口布局
(gnus-add-configuration
 '(article
   (vertical 1.0
             (summary .35 point)
             (article 1.0))))

(setq gnus-use-full-window t)

;; 显示设置
(setq  mm-text-html-renderer 'w3m
       mm-inline-text-html-with-images t
       mm-inline-large-images nil
       mm-verify-option 'always
       mm-decrypt-option nil
       mm-discouraged-alternatives '("text/html" "text/richtext")
       mm-automatic-display '("text/html")
       mm-attachment-override-types '("image/.*")
       mm-external-terminal-program (quote urxvt)
       gnus-ignored-mime-types '("text/x-vcard")
       w3m-key-binding 'info
       w3m-cookie-accept-bad-cookies (quote ask)
       w3m-use-cookies t
       w3m-safe-url-regexp nil
       mm-w3m-safe-url-regexp nil
       )

;; 设置 article buffer 的颜色
(setq gnus-cite-minimum-match-count 1)

(setq gnus-cite-face-list
      (mapcar (lambda (n) (intern (format "gnus-cite-%s" n)))
              '(3 7 2 6 4 5 8 9 10 11 1)))

;; 概要显示设置
(setq gnus-summary-gather-subject-limit 'fuzzy) ;聚集题目用模糊算法
(setq gnus-summary-line-format "%4P %U%R%z%O %{%5k%} %{%14&user-date;%}   %{%-20,20n%} %{%ua%} %B %(%I%-60,60s%)\n")
(defun gnus-user-format-function-a (header) ;用户的格式函数 `%ua'
  (let ((myself (concat "<wd@wdicc.com>"))
        (references (mail-header-references header))
        (message-id (mail-header-id header)))
    (if (or (and (stringp references)
                 (string-match myself references))
            (and (stringp message-id)
                 (string-match myself message-id)))
        "X" "│")))

;; (setq gnus-summary-user-date-format-alist
(setq gnus-user-date-format-alist             ;用户的格式列表 `user-date'
      '(((gnus-seconds-today) . "Today %H:%M")   ;当天
        (604800 . "W %w %H:%M")                ;七天之内
        ((gnus-seconds-month) . "%d %H:%M")   ;当月
        ((gnus-seconds-year) . "%m-%d %H:%M") ;今年
        (t . "%y-%m-%d %H:%M")))              ;其他

;; 线程的可视化外观, `%B'
(setq gnus-summary-same-subject "")
(setq gnus-sum-thread-tree-indent "    ")
(setq gnus-sum-thread-tree-single-indent "◎ ")
(setq gnus-sum-thread-tree-root "● ")
(setq gnus-sum-thread-tree-false-root "☆")
(setq gnus-sum-thread-tree-vertical "│")
(setq gnus-sum-thread-tree-leaf-with-other "├─► ")
(setq gnus-sum-thread-tree-single-leaf "╰─► ")
;; 时间显示
(add-hook 'gnus-article-prepare-hook 'gnus-article-date-local) ;将邮件的发出时间转换为本地时间
(add-hook 'gnus-select-group-hook 'gnus-group-set-timestamp)   ;跟踪组的时间轴
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)              ;新闻组分组
;; 设置邮件报头显示的信息
(setq gnus-visible-headers
      (mapconcat 'regexp-quote
                 '("From:" "Newsgroups:" "Subject:" "Date:"
                   "Organization:" "To:" "Cc:" "Followup-To" "Gnus-Warnings:"
                   "X-Sent:" "X-URL:" "User-Agent:" "X-Newsreader:"
                   "X-Mailer:" "Reply-To:" "X-Spam:" "X-Spam-Status:" "X-Now-Playing"
                   "X-Attachments" "X-Diagnostic")
                 "\\|"))
;; 用 Supercite 显示多种多样的引文形式
(setq sc-attrib-selection-list nil
      sc-auto-fill-region-p nil
      sc-blank-lines-after-headers 1
      sc-citation-delimiter-regexp "[>]+\\|\\(: \\)+"
      sc-cite-blank-lines-p nil
      sc-confirm-always-p nil
      sc-electric-references-p nil
      sc-fixup-whitespace-p t
      sc-nested-citation-p nil
      sc-preferred-header-style 4
      sc-use-only-preference-p nil)
;; 线程设置
(setq
 gnus-use-trees t                                                       ;联系老的标题
 gnus-tree-minimize-window nil                                          ;用最小窗口显示
 gnus-fetch-old-headers 'some                                           ;抓取老的标题以联系线程
 gnus-generate-tree-function 'gnus-generate-horizontal-tree             ;生成水平树
 gnus-summary-thread-gathering-function 'gnus-gather-threads-by-subject ;聚集函数根据标题聚集
 )

;; 排序
(setq gnus-thread-sort-functions
      '(
        (not gnus-thread-sort-by-date)                               ;时间的逆序
        (not gnus-thread-sort-by-number)))                           ;跟踪的数量的逆序

;; 自动跳到第一个没有阅读的组
(add-hook 'gnus-switch-on-after-hook 'gnus-group-first-unread-group) ;gnus切换时
(add-hook 'gnus-summary-exit-hook 'gnus-group-first-unread-group)    ;退出Summary时

;; 自动更新新消息
;;(require 'gnus-notify+)
;;(add-hook 'gnus-summary-exit-hook 'gnus-notify+)        ;退出summary模式后
;;(add-hook 'gnus-group-catchup-group-hook 'gnus-notify+) ;当清理当前组后
;;(add-hook 'mail-notify-pre-hook 'gnus-notify+)          ;更新邮件时
;;(add-hook 'gnus-after-getting-new-news-hook 'gnus-notify+)
;;
;; (require 'binjo-gnus-notify)
;; (binjo-gnus-enable-unread-notify)
;; (eval-after-load 'binjo-gnus-notify
;;     '(setq binjo-gnus-notify-groups
;;         '("inbox"
;;           "search"
;;           "all"
;;           "ticket")))

;; 斑纹化
(setq gnus-summary-stripe-regexp        ;设置斑纹化匹配的正则表达式
      (concat "^[^"
              gnus-sum-thread-tree-vertical
              "]*"))
;; 最后设置
;; (gnus-compile)                          ;编译一些选项, 加快速度

;; SMTP
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "wd@wdicc.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-local-domain "wdicc.com")


;; ;; IMAP
;; (setq gnus-select-method
;;       '(nnimap "imap.gmail.com"
;;                (nnimap-address "imap.gmail.com")
;;                (nnimap-server-port 993)
;;                (nnimap-authinfo-file "~/.authinfo")
;;                (nnimap-stream ssl)))
;; (setq nnimap-split-inbox '("INBOX"))
;; (setq nnimap-split-rule 'nnmail-split-fancy)
;; (setq gnus-parameters
;;       '(("nnimap+imap.gmail.com.*" (gcc-self . t))))

;; (setq gnus-fetch-old-headers t)
;; (setq gnus-permanently-visible-groups "gmail")

;; ;; ENCODING
;; (setq gnus-group-name-charset-method-alist
;;       '(((nntp "news.cn99.com") . cn-gb-2312)))
(setq gnus-default-charset 'utf-8
      gnus-summary-show-article-charset-alist
      '((1 . chinese-iso-8bit)
        (2 . gbk)
        (3 . big5)
        (4 . utf-8))
      gnus-newsgroup-ignored-charsets
      '(unknown-8bit x-unknown iso-8859-1))

;; auto update mail status
(add-hook 'gnus-started-hook
          (lambda ()
            (require 'gnus-demon)
            (setq gnus-use-demon t)
            ;; (gnus-demon-add-handler 'gnus-group-get-new-news 3 1)
            (gnus-demon-add-handler 'gnus-group-get-new-news 3 nil)
            (gnus-demon-init)))

;; gnus-posting-styles and some specific settings
;; (load "~/Mail/.gnus-posting-style")

;; Disable CC: to self in wide replies and stuff
;; (setq message-dont-reply-to-names gnus-ignored-from-addresses)

;; top post
;; (setq message-cite-reply-above 't)
;;
;; view url in article mode
(define-key gnus-article-mode-map "v" 'browse-url-at-point)

;; to view the fucking 'winmail.dat'

;; (defun mime-display-application/ms-tnef (entity situation)
;;   (save-restriction
;;     (narrow-to-region (point-max)(point-max))
;;     (mime-insert-entity-content entity)
;;     (shell-command-on-region (point-min) (point-max)
;;                              "tnef --list" nil t)))

;; (defun mime-extract-application/ms-tnef (entity situation)
;;   (let ((dir (if (eq t mime-save-directory)
;;                  default-directory
;;                mime-save-directory))
;;         (tmpfile (make-temp-name (expand-file-name "mime-tnef"
;;                                                    (temp-directory)))))
;;     (setq dir (read-directory-name
;;                (format "Extract contents into: (default %s) " dir) dir))
;;     (unless (file-exists-p dir)
;;       (if (yes-or-no-p (format "Directory %s does not exist. Create? " dir))
;;           (make-directory dir t)
;;         (error 'file-error)))
;;     (mime-write-entity-content entity tmpfile)
;;     (shell-command (format "tnef --interactive --directory %s --file %s"
;;                           dir tmpfile))
;;     (delete-file tmpfile)))

;; (mime-add-condition
;;  'preview
;;  '((type . application)(subtype . ms-tnef)
;;    (body . visible)
;;    (body-presentation-method . mime-display-application/ms-tnef)))

;; (mime-add-condition
;;  'action
;;  '((type . application)(subtype . ms-tnef)
;;    (mode . "view")
;;    (method . mime-extract-application/ms-tnef)))

;; 可以保留同主体中已读邮件，把 'some 改为t可以下载所有文章（注意：当
;; 你进入某个组的时候，这两个设置，都会增大从服务器读取的数据量，从而
;; 使得这个过程变慢）。
(setq gnus-fetch-old-headers 'some)


;; ask only once when saving articles
(setq gnus-prompt-before-saving t)

;; 回复邮件的时候的 citation prefix
;; (setq message-yank-prefix "  > "
;; message-yank-cited-prefix "  > "
;; message-yank-empty-prefix "  > ")
;; (setq message-indentation-spaces 5)

(setq gnus-newsgroup-maximum-articles 100)

;; 回复邮件的时候，光标定位到第一行
(setq message-citation-line-function
      '(lambda()
         (newline-and-indent)
         (message-insert-citation-line)
         (message-goto-body)
         )
      )

;; (setq message-cite-style 'top-post)
;; (setq message-cite-style message-cite-style-thunderbird)


(setq gnus-read-active-file nil)

(provide 'wd-gnus)
