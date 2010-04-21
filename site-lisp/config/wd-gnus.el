;(setq gnus-default-charset 'cn-gb-2312)

;; (setq gnus-secondary-select-methods                  ;次要选择方法
;;       '(
;;         (nnmaildir "Alibaba"                        ;nnmaildir后端, 从本地文件中读邮件 (getmail 抓取)
;;                    (directory "~/Mail/alibaba/")) ;读取目录
;;         ))


;; (setq mail-sources                                 ;邮件源设置
;;       '((maildir :path "~/Mail/alibaba/"           ;本地邮件存储位置
;;                  :subdirs ("cur" "new" "tmp"))))   ;本地邮件子目录划分

(setq
	gnus-select-method '(nnmaildir "Alibaba" (directory "~/Mail/"))
 	mail-sources '((maildir :path "~/Mail/" :subdirs ("cur" "new" "tmp")))
	mail-source-delete-incoming t
 )
 (setq gnus-secondary-select-methods nil)
 (setq gnus-message-archive-group "nnmaildir+mymailbox:outbox")


(setq mm-inline-large-images t)                       ;显示内置图片
(auto-image-file-mode)                                ;自动加载图片
(add-to-list 'mm-attachment-override-types "image/*") ;附件显示图片

(setq gnus-user-date-format-alist             ;用户的格式列表 `user-date'
      '(((gnus-seconds-today) . "TD %H:%M")   ;当天
        (604800 . "W%w %H:%M")                ;七天之内
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


(require 'w3m)
(setq
 mm-inline-text-html-renderer 'mm-inline-text-html-render-with-w3m
 w3m-display-inline-image t
 gnus-article-wash-function 'gnus-article-wash-html-with-w3m)

;; ;; SMTP
;; (setq message-send-mail-function 'smtpmail-send-it)
;; (setq smtpmail-default-smtp-server "smtp.gmail.com")
;; (setq smtpmail-smtp-service 587)
;; (setq smtpmail-starttls-credentials
;;       '(("smtp.gmail.com"
;;          587
;;          nil
;;          nil)))
;; (setq smtpmail-auth-credentials
;;       '(("smtp.gmail.com"
;;          587
;;          "wd@wdicc.com"
;;          nil)))

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
;; (setq gnus-default-charset 'chinese-iso-8bit
;;       gnus-group-name-charset-group-alist '((".*" . chinese-iso-8bit))
;;       gnus-summary-show-article-charset-alist
;;       '((1 . chinese-iso-8bit)
;;         (2 . gbk)
;;         (3 . big5)
;;         (4 . utf-8))
;;       gnus-newsgroup-ignored-charsets
;;       '(unknown-8bit x-unknown iso-8859-1))

(provide 'wd-gnus)