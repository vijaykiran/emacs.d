;; -----
;; misc
;; -----

(load "~/.pwds")

(setq compilation-environment (list "LZ_HOST=t.api.linezing.com:9999"))
;; (setq wd-make-env "LZ_HOST=t.api.linezing.com:9999 ")

(require 'color-theme-hober2)
(color-theme-hober2)

(menu-bar-mode -1)
(tool-bar-mode -1)
;(scroll-bar-mode -1)
(mouse-wheel-mode 1)

(global-auto-revert-mode 1)

;; 和x公用剪贴板
(setq x-select-enable-clipboard t)

;;'y' for 'yes', 'n' for 'no'
(fset 'yes-or-no-p 'y-or-n-p)

;;禁用启动信息
(setq inhibit-startup-message t)
;; 显示列号
(setq column-number-mode t) 

;; 防止页面滚动时跳动， scroll-margin 3 可以在靠近屏幕边沿3行时就开始滚动，可以很好的看到上下文。
(setq scroll-margin 3
            scroll-conservatively 10000)

;;关闭烦人的出错时的提示声
;;(setq visible-bell t)

;;把title设置为“文件名@LC's Emacs"
(setq frame-title-format
        '("GNU Emacs - [ "(buffer-file-name "%f \]"
                (dired-directory dired-directory "%b \]"))))

;; 语法高亮
(global-font-lock-mode t)

;; 个人信息
(setq user-full-name "Wang Dong")
(setq user-mail-address "wd@wdicc.com")

;;光标靠近鼠标的时候，让鼠标自动让开，别挡住视线
(mouse-avoidance-mode 'animate)

;;下面的这个设置可以让光标指到某个括号的时候显示与它匹配的括号
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;设置缺省模式是text，而不是基本模式
(setq default-major-mode 'text-mode)
;;(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; 所有的备份文件转移到~/backups目录下
(setq auto-save-default nil)
(setq make-backup-files t)
(setq backup-by-copying t)
(setq version-control t)
(setq kept-old-versions 2)
(setq kept-new-versions 5)
(setq delete-old-versions t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
;; Emacs 中，改变文件时，默认都会产生备份文件(以 ~ 结尾的文件)。可以完全去掉
;; (并不可取)，也可以制定备份的方式。这里采用的是，把所有的文件备份都放在一
;; 个固定的地方("~/var/tmp")。对于每个备份文件，保留最原始的两个版本和最新的
;; 五个版本。并且备份的时候，备份文件是复本，而不是原件。

;;不产生备份文件
;(setq make-backup-files nil)

;;设置kill-ring-max(我不知道怎么翻译这个词：)为200，以防不测：）
(setq kill-ring-max 200)

;; 设置mark， C-x <SPC>
(global-set-key (kbd "C-x <SPC>") 'set-mark-command)
(global-set-key (kbd "C-t") 'set-mark-command)

;; Make Emacs UTF-8 compatible for both display and editing:
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; 打开 quick-calc
(global-set-key (kbd "M-#") 'quick-calc)

;; 高量当前行 // 会造成滚动的时候抖动，不是很爽。。
;; (require 'hl-line)
;; (global-hl-line-mode 1)

;; 查找打开当前光标所在的文件
(global-set-key (kbd "C-x f") 'find-file-at-point)

;;
;; indent
;;
;; 不用 TAB 字符来indent
(setq-default indent-tabs-mode nil)
;;设置tab为4个空格的宽度，而不是原来的2
(setq-default tab-width 4)
(setq tab-width 4)
(setq cperl-indent-level 4)
(setq tab-stop-list ())
(loop for x downfrom 40 to 1 do
            (setq tab-stop-list (cons (* x 4) tab-stop-list)))
(add-hook 'html-mode-hook
              (lambda ()
                (setq indent-line-function 'indent-relative)))
(add-hook 'php-mode-hook
              (lambda ()
                (setq php-mode-force-pear 1)
                (setq c-basic-offset 4)
            ))
;; auto indent
;; (setq indent-line-function 'indent-relative-maybe)
;; (global-set-key (kbd "RET") 'align-newline-and-indent)

;;
;; font
;;
;;(set-default-font "Monaco-10")
;;(set-fontset-font (frame-parameter nil 'font)
;;    'han '("WenQuanYi Zen Hei Mono" . "unicode-bmp"))
;;(defun my-default-font()
;;  (interactive)
;;  (set-default-font "Monaco-9")
;;  (set-fontset-font "fontset-default"
;;                        'han '("WenQuanYi Zen Hei Mono" . "unicode-bmp"))
;;  )
;;;; (my-default-font)
;;(add-to-list 'after-make-frame-functions
;;                  (lambda (new-frame)
;;                          (select-frame new-frame)
;;                           (my-default-font)
;;                   )) 

;; ----
;; ido
;; -----
(require 'ido)
(ido-mode t)

(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(require 'uniquify)
(setq
 uniquify-buffer-name-style 'post-forward
 uniquify-separator ":")

;;
;; twiki
;;
(require 'erin)
(add-to-list 'auto-mode-alist
'("\\twiki.*\\'" . erin-mode))

;;
;; python-mode
;;
(require 'ipython)
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(add-hook 'python-mode-hook
       (lambda ()
         (set (make-variable-buffer-local 'beginning-of-defun-function)
               'py-beginning-of-def-or-class)
           (setq outline-regexp "def\\|class ")))

(setq pdb-path '/usr/lib/python2.6/pdb.py
      gud-pdb-command-name (symbol-name pdb-path))	

(defadvice pdb (before gud-query-cmdline activate)
  "Provide a better default command line when called interactively."
  (interactive
   (list (gud-query-cmdline pdb-path
			    (file-name-nondirectory buffer-file-name)))))

;;
;; weblogger mode
;;

(require 'weblogger)

(custom-set-variables
 '(weblogger-config-alist (quote (("default" ("user" . "admin") ("server-url" . "http://wdicc.com/xmlrpc.php") ("weblog" . "1"))))))

(setq weblogger-server-password weblogger-pass)

(add-hook 'weblogger-start-edit-entry-hook (lambda()
    (auto-fill-mode -1)
    (abbrev-mode -1)
    (auto-complete-mode 1)
    ))

;;
;; org-mode
;;

;; (setq org-agenda-files '("~/org"))
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; (define-key global-map "\C-cl" 'org-store-link)
;; (define-key global-map "\C-ca" 'org-agenda)
;; (setq org-log-done 'time)
;; turn on soft wrapping mode for org mode
;; (add-hook 'org-mode-hook
;;  (lambda () (setq truncate-lines nil)))
;; (setq org-log-done 'note)

;;
;; muse
;;

;;(require 'muse-html)

;;
;; sql-mode
;;
(autoload 'Sql-mode "sql-mode" "SQL Mode." t)
(add-to-list 'auto-mode-alist '("\\.sql\\'" . sql-mode))

(eval-after-load "sql"
   (load-library "sql-indent"))

;;
;; perl-mode
;;
(defalias 'perl-mode 'cperl-mode)
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))
(setq cperl-electric-keywords t)

(global-set-key (kbd "C-;") 'comment-dwim)
(add-hook 'cperl-mode-hook (lambda () (abbrev-mode -1)))

;;
;; snippet
;;
(require 'yasnippet)
(yas/initialize)
;(yas/load-directory "/usr/share/emacs/etc/yasnippet/snippets")
(yas/load-directory "~/.emacs.d/site-lisp/yasnippets/text-mode")

;;
;; auto complete
;;

(require 'auto-complete)
(require 'auto-complete-yasnippet)

(set-default 'ac-sources
             '(;ac-source-semantic
               ac-source-yasnippet
               ;ac-source-abbrev
               ac-source-words-in-buffer
               ac-source-words-in-all-buffer
               ;ac-source-imenu
               ac-source-files-in-current-dir
               ac-source-filename))

(global-auto-complete-mode t)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
(setq ac-auto-start 3)
;; (define-key ac-complete-mode-map "\t" 'ac-complete)
;; (define-key ac-complete-mode-map "\r" nil)
(setq ac-dwim t)

;;
;; high light tail
;; 
(require 'highlight-tail)
(setq highlight-tail-colors  '(("#bc2525" . 0)))
;(setq highlight-tail-colors  '(("#ffd700" . 0)))
;(setq highlight-tail-colors  '(("#ffefa6" . 0)))
(highlight-tail-mode)

;; 
;; emms
;;
;(add-to-list 'load-path "~/.emacs.d/site-lisp/emms/")
;(require 'emms-setup)
; (require 'xwl-emms)
;(emms-standard)
;(emms-default-players)

;;
;; view mode
;;

;; use view mode when press C-x C-q
(setq view-read-only t)

(add-hook 'find-file-hook
      (lambda ()
        (view-mode t)))

(defun view-mode-keybinding-hook ()
  (define-key view-mode-map "h" 'backward-char)
  (define-key view-mode-map "l" 'forward-char)
  (define-key view-mode-map "j" 'next-line)
  (define-key view-mode-map "k" 'previous-line)
  (define-key view-mode-map "b" 'scroll-down)
  (define-key view-mode-map "f" 'scroll-up))

(add-hook 'view-mode-hook 'view-mode-keybinding-hook)

;; 
;; tramp
;; 

(require 'tramp)
(setq tramp-default-method "ssh")
(setq tramp-default-user "stefdong")

(add-to-list 'tramp-default-user-alist '(nil "\\`test\\'" "wd"))

;; 使用 TRAMP 把当前文件以 sudo 方式打开
(defun kid-find-alternative-file-with-sudo ()
  (interactive)
  (when buffer-file-name
    (let ((point (point)))
      (find-alternate-file
       (concat "/sudo:root@localhost:"
               buffer-file-name))
      (goto-char point))))
(global-set-key (kbd "C-x C-r") 'kid-find-alternative-file-with-sudo)

;; revert buffer with sudo
(defun xwl-revert-buffer-with-sudo ()
  "Revert buffer using tramp sudo.
This will also reserve changes already made by a non-root user."
  (interactive)
  (let ((f (buffer-file-name)))
    (when f
      (let ((content (when (buffer-modified-p)
                       (widen)
                       (buffer-string))))
        (if (file-writable-p f)
            (revert-buffer)
          (kill-buffer (current-buffer))
          (if (file-remote-p f)
              (find-file
               (replace-regexp-in-string "^\\\\/[^:]+:" "/sudo:" f))
            (find-file (concat "/sudo::" f)))
          (when content
            (let ((buffer-read-only nil))
              (erase-buffer)
              (insert content))))))))

(global-set-key (kbd "C-c m R") 'xwl-revert-buffer-with-sudo)

;;
;; php mode
;;
(add-to-list 'auto-mode-alist '("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.module\\'"                 . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'"                    . php-mode))
(add-hook 'php-mode-hook (lambda () (abbrev-mode -1)))

;;
;; tt mode
;;
(require 'tt-mode)
(setq auto-mode-alist
      ( append '(("\\.tt$" . tt-mode)) auto-mode-alist) )

;; 
;; twittering-mode
;; 
(require 'twittering-mode)
(setq twittering-host-url "wdtwitter.appspot.com")
(setq twittering-api-url  "wdtwitter.appspot.com/api/")
(setq twittering-search-url "wdtwitter.appspot.com/search/")
(setq twittering-username "wd"
    twittering-password twittering-pass)

(setq global-mode-string (list ""
              twittering-unread-mode-line-string ))
(twittering-icon-mode 1)
;(setq twittering-use-ssl nil)
(setq twittering-fill-column 40)

;; 
;; sl-mode
;; 
(load "sl-term")

;; 
;; Track cahnges for some buffer
;; 
;; (defadvice switch-to-buffer (before
;;                              highlight-changes-for-some-buffer
;;                              activate)
;;   (when (memq major-mode (list 'erc-mode 'twittering-mode))
;;     (let ((buffer-read-only nil)
;;           (inhibit-read-only t))
;;       (highlight-changes-mode -1)
;;       (highlight-changes-mode 1))))

;; 
;; javascript
;;

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; (add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
;; (autoload 'javascript-mode "javascript" nil t)


;; 
;; window mode
;;

;; (autoload 'window-number-meta-mode "window-number"
;;   "A global minor mode that enables use of the M- prefix to select
;; windows, use `window-number-mode' to display the window numbers in
;; the mode-line . "
;;   t)
;; ;; 使用 M-up, M-down 等来切换 window
;; (windmove-default-keybindings 'meta)

;;
;; woman
;;

(setq woman-use-own-frame nil)

;; 
;; smart compile, buffer-action
;;
(require 'wcy-smart-compile)
(global-set-key (kbd "<f7>") 'smart-compile)


(provide 'wd-misc)
