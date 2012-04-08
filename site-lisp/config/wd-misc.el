;; -----
;; misc
;; -----

(load "~/.pwds")

;;
;; default browser
;; 
;; (setq browse-url-browser-function 'browse-url-generic
;;       browse-url-generic-program "google-chrome")
(if (eq system-type 'darwin)
    (setq browse-url-browser-function 'browse-url-default-macosx-browser)
  (setq browse-url-browser-function 'browse-url-firefox
        browse-url-new-window-flag  t
        browse-url-firefox-new-window-is-tab t)
  )

;;
;; fonts
;;
;; (defun qiang-font-existsp (font)
;;   (if (null (x-list-fonts font))
;;       nil t))
;; 
;; (defun qiang-make-font-string (font-name font-size)
;;   (if (and (stringp font-size) 
;;            (equal ":" (string (elt font-size 0))))
;;       (format "%s%s" font-name font-size)
;;     (format "%s %s" font-name font-size)))
;; 
;; (defun qiang-set-font (english-fonts
;;                        english-font-size
;;                        chinese-fonts
;;                        &optional chinese-font-size)
;;   "english-font-size could be set to \":pixelsize=18\" or a integer.
;; If set/leave chinese-font-size to nil, it will follow english-font-size"
;;   (require 'cl)                         ; for find if
;;   (let ((en-font (qiang-make-font-string
;;                   (find-if #'qiang-font-existsp english-fonts)
;;                   english-font-size))
;;         (zh-font (font-spec :family (find-if #'qiang-font-existsp chinese-fonts)
;;                             :size chinese-font-size)))
;;  
;;     ;; Set the default English font
;;     ;; 
;;     ;; The following 2 method cannot make the font settig work in new frames.
;;     ;; (set-default-font "Consolas:pixelsize=18")
;;     ;; (add-to-list 'default-frame-alist '(font . "Consolas:pixelsize=18"))
;;     ;; We have to use set-face-attribute
;;     (message "Set English Font to %s" en-font)
;;     (set-face-attribute
;;      'default nil :font en-font)
;;  
;;     ;; Set Chinese font 
;;     ;; Do not use 'unicode charset, it will cause the english font setting invalid
;;     (message "Set Chinese Font to %s" zh-font)
;;     (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;       (set-fontset-font (frame-parameter nil 'font)
;;                         charset
;;                         zh-font))))
;; 
;; (qiang-set-font
;;  '("Monaco" "Monospace") ":pixelsize=13"
;;  '("STHeiti" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体") 13.5)


;; http://jff.googlecode.com/svn/trunk/XDE/xde/emacs/dot_emacs.d/site-start.d/01_font.el
;; Way 1
(let ((zh-font "STHeiTi:pixelsize=13")
;; (let ((zh-font "WenQuanYi Zen Hei Mono:pixelsize=14")
      (fontset "fontset-my"))
  (create-fontset-from-fontset-spec
    (concat
      ;; "-unknown-monofur-*-*-*-*-13-*-*-*-*-*-" fontset
      "-unknown-Monaco-*-*-*-*-12-*-*-*-*-*-" fontset
      ",kana:"          zh-font
      ",han:"           zh-font
      ",symbol:"        zh-font
      ",cjk-misc:"      zh-font
      ",bopomofo:"      zh-font))
  (set-default-font fontset)
  (add-to-list 'default-frame-alist `(font . ,fontset)))

;; https://groups.google.com/group/cn.bbs.comp.emacs/browse_thread/thread/d0595a07685a956c
;; (setq sl/x-font-en "Monaco:pixelsize=12"
;;       sl/x-font-zh "STHeiTi"
;;       sl/x-font-zh-size 13)

;; (defun sl/set-x-font ()
;;   (let ((fontset "fontset-default")
;;         (zh-font (font-spec :family sl/x-font-zh :size sl/x-font-zh-size)))
;;     (set-default-font sl/x-font-en)
;;     (set-fontset-font fontset
;;                       'nil '("Courier New" . "unicode-bmp"))
;;     (set-fontset-font fontset
;;                       'nil '("Baekmuk Dotum" . "unicode-bmp"))
;;     (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;       (set-fontset-font fontset charset zh-font))))
;; (sl/set-x-font)


;; (setq sl/font-config
;;       '((x ("Monaco" 12)
;;            ("STHeiTi" 13))
;;         (w32 ("Courier New" 12)
;;              ("NSimSun" 13))
;;         (ns ("Monaco" 12)
;;             ("STHeiTi" 13))))

;; (defun sl-set-gui-font ()
;;   (let ((cfg (cdr
;;               (assq window-system
;;                      sl/font-config))))
;;     (if cfg
;;         (sl-set-gui-font-internal cfg)
;;       (message "not in gui mode or cannot get proper font"))))

;; ;http://jff.googlecode.com/svn/trunk/XDE/xde/emacs/dot_emacs.d/site-start.d/01_font.el
;; (defun sl-set-gui-font-internal (font-config)
;;   (let ((fontset "fontset-default")
;;         (font-def
;;          (format "%s-%d"
;;                  (car (car font-config))
;;                  (cadr (car font-config))))
;;         (font-zh
;;          (font-spec
;;           :family (car (cadr font-config))
;;           :size (cadr (cadr font-config)))))

;;     (set-frame-font font-def)
;;     (set-fontset-font fontset
;;                       'nil '("Courier New" . "unicode-bmp"))
;;     (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;       (set-fontset-font fontset charset font-zh))))

;; (sl-set-gui-font)
;; ;; (add-hook 'sl/after-make-gui-frame-hook 'sl-set-gui-font)



;;
;; for mac only
;; 
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  )


;;
;; misc settings
;; 
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(mouse-wheel-mode 1)

(global-auto-revert-mode 1)

;; 和x公用剪贴板
(setq x-select-enable-clipboard t)
;; (setq x-select-enable-primary t)

;;'y' for 'yes', 'n' for 'no'
(fset 'yes-or-no-p 'y-or-n-p)

;;禁用启动信息
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
;; 显示列号
(setq column-number-mode t) 

;; 防止页面滚动时跳动， scroll-margin 3 可以在靠近屏幕边沿3行时就开始滚动，可以很好的看到上下文。
;; (setq scroll-margin 3
;;       scroll-conservatively 2)

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

;; 翻页后再回来的时候，光标到原来的位置
(setq scroll-preserve-screen-position t)

;;下面的这个设置可以让光标指到某个括号的时候显示与它匹配的括号
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;设置缺省模式是text，而不是基本模式
(setq default-major-mode 'text-mode)
;; (setq fill-column 80)
;; (setq-default fill-column 80)
;; (setq longlines-show-hard-newlines t)
;; (setq longlines-auto-wrap t)
;; (add-hook 'text-mode-hook 'longlines-mode)
;; (add-hook 'text-mode-hook 'turn-on-auto-fill)

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

;; ----
;; ido
;; -----
(require 'ido)
(ido-mode t)
(global-set-key (kbd "C-x C-f") 'ido-find-file)
(global-set-key (kbd "C-x C-d") 'ido-dired)
(setq ido-max-directory-size 100000)


(require 'uniquify)
(setq
 uniquify-buffer-name-style 'post-forward
 uniquify-separator ":")

;;
;; python-mode
;;
;; (require 'ipython)
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
;; perl-mode
;;
(defalias 'perl-mode 'cperl-mode)
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))
(setq cperl-electric-keywords t)

;; (global-set-key (kbd "C-;") 'comment-dwim)
(add-hook 'cperl-mode-hook (lambda () (abbrev-mode -1)))

(add-hook 'cperl-mode-hook 'sl-highlight-todo)


;;
;; high light tail
;; 
;; (require 'highlight-tail)
;; (setq highlight-tail-colors  '(("#bc2525" . 0)))
;; ;(setq highlight-tail-colors  '(("#ffd700" . 0)))
;; ;(setq highlight-tail-colors  '(("#ffefa6" . 0)))
;; (highlight-tail-mode)

;; 
;; tramp
;; 

(require 'tramp)
(setq tramp-default-method "ssh")

(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))

;; 使用 TRAMP 把当前文件以 sudo 方式打开
(defun kid-find-alternative-file-with-sudo ()
  (interactive)
  (when buffer-file-name
    (let ((point (point)))
      (find-alternate-file
       (concat "/sudo::"
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
;; woman
;;

(setq woman-use-own-frame nil)

;; 
;; smart compile, buffer-action
;;
(require 'wcy-smart-compile)
(global-set-key (kbd "<f7>") 'smart-compile)

;; 
;; ibuffer
;; 

(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("dired" (mode . dired-mode))
               ("perl" (mode . cperl-mode))
               ("erc" (mode . erc-mode))
               ("javascript" (mode . js2-mode))
               ("twmode" (mode . twittering-mode))
               ("Org" ;; all org-related buffers
                (mode . org-mode))
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")))
               ("gnus" (or
                        (mode . message-mode)
                        (mode . bbdb-mode)
                        (mode . mail-mode)
                        (mode . gnus-group-mode)
                        (mode . gnus-summary-mode)
                        (mode . gnus-article-mode)
                        (name . "^\\.bbdb$")
                        (name . "^\\.newsrc-dribble")))))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

(global-set-key (kbd "C-x C-b") 'ibuffer)

;; 
;; eshell
;; 

;; (add-hook 'eshell-load-hook
;;           (lambda ()
;;             (highlight-tail-mode -1)
;;             ))

;; add command 'e' to open files
(defun eshell/e (&rest args)
  "Open a file in emacs. Some habits die hard."
  (if (null args)
      ;; If I just ran "emacs", I probably expect to be launching
      ;; Emacs, which is rather silly since I'm already in Emacs.
      ;; So just pretend to do what I ask.
      (bury-buffer)
    ;; We have to expand the file names or else naming a directory in an
    ;; argument causes later arguments to be looked for in that directory,
    ;; not the starting directory
    (mapc #'find-file (mapcar #'expand-file-name (eshell-flatten-list (reverse args))))))

;; made eshell scroll smoothly
(defun eshell-scroll-to-bottom (window display-start)
  (if (and window (window-live-p window))
      (let ((resize-mini-windows nil))
        (save-selected-window
          (select-window window)
          (save-restriction
            (widen)
            (when (> (point) eshell-last-output-start) ; we're editing a line. Scroll.
              (save-excursion
                (recenter -1)
                (sit-for 0))))))))

(defun eshell-add-scroll-to-bottom ()
  (interactive)
  (make-local-hook 'window-scroll-functions)
  (add-hook 'window-scroll-functions 'eshell-scroll-to-bottom nil t))

(add-hook 'eshell-mode-hook 'eshell-add-scroll-to-bottom)

;; 
;; highlight trailing space
;; (require 'show-wspace)
;; ;; (add-hook 'font-lock-mode-hook 'show-ws-highlight-tabs)
;; ;; (add-hook 'font-lock-mode-hook 'show-ws-highlight-hard-spaces)
;; (add-hook 'font-lock-mode-hook 'show-ws-highlight-trailing-whitespace)
(require 'whitespace)
(setq whitespace-style '(trailing tabs))
(global-whitespace-mode)


;; 
;;  confluence
;; 
;; (require 'confluence)
;; (add-to-list 'auto-mode-alist
;;              '("\\wiki.corp.qunar.com.*\\'" . confluence-mode))


;; 
;; pde
;; 
;; (load "pde-load")
;; (setq perldoc-cache-el "~/.emacs.d/perldoc_cache.el")

;; (defalias 'perl-mode 'cperl-mode)
;; (defun pde-perl-mode-hook ()
;;   (add-to-list 'cperl-style-alist
;;                '("PDE"
;;                  (cperl-auto-newline                         . nil)
;;                  (cperl-brace-offset                         . 0)
;;                  (cperl-close-paren-offset                   . -4)
;;                  (cperl-continued-brace-offset               . 0)
;;                  (cperl-continued-statement-offset           . 4)
;;                  (cperl-extra-newline-before-brace           . nil)
;;                  (cperl-extra-newline-before-brace-multiline . nil)
;;                  (cperl-indent-level                         . 4)
;;                  (cperl-indent-parens-as-block               . t)
;;                  (cperl-label-offset                         . -4)
;;                  (cperl-merge-trailing-else                  . t)
;;                  (cperl-tab-always-indent                    . t)))
;;   (cperl-set-style "PDE"))

;;
;; rainbow-mode
;;

(require 'rainbow-mode)

;;
;; smart mark
;;

(require 'smart-mark)
;; type C-M-m and then following the prompt.


;;
;; edit chrome textarea in emacs
;;
(require 'edit-server)
(edit-server-start)

;;
;; flyspell
;;


;; (dolist (hook '(text-mode-hook
;;                 twittering-edit-mode
;;                 message-mode
;;                 ))
;;   (add-hook hook (lambda () (flyspell-mode 1))))

;;
;; register key binding
;;

(define-prefix-command 'ctl-x-r-map-alias)
(global-set-key (kbd "<f6>") 'ctl-x-r-map-alias)
;; (define-key ctl-x-r-map-alias "\C-@" 'point-to-register)
;; (define-key ctl-x-r-map-alias [?\C-\ ] 'point-to-register)
;; (define-key ctl-x-r-map-alias " " 'point-to-register)
(define-key ctl-x-r-map-alias "j" 'jump-to-register)
;; (define-key ctl-x-r-map-alias "s" 'copy-to-register)
;; (define-key ctl-x-r-map-alias "x" 'copy-to-register)
;; (define-key ctl-x-r-map-alias "i" 'insert-register)
;; (define-key ctl-x-r-map-alias "g" 'insert-register)
;; (define-key ctl-x-r-map-alias "r" 'copy-rectangle-to-register)
;; (define-key ctl-x-r-map-alias "n" 'number-to-register)
;; (define-key ctl-x-r-map-alias "+" 'increment-register)
(define-key ctl-x-r-map-alias "w" 'window-configuration-to-register)
;; (define-key ctl-x-r-map-alias "f" 'frame-configuration-to-register)


;; 
;; winner-mode
;; 
(winner-mode 1)
(global-set-key (kbd "s-j") `winner-undo)
(global-set-key (kbd "s-k") `winner-redo)


;; 
;; narrowing
;; 
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)


;;
;; window move
;; 
(require 'windmove)
(windmove-default-keybindings 'meta)

;; 
;; multi term
;; 
(require 'multi-term)

;; (global-set-key term-send-reverse-search-history)
(global-set-key (kbd "C-c n t") `multi-term)
(setq multi-term-buffer-name "term")
;; (setq term-term-name "xterm-color")


;; 
;; org-confluence
;; 
(require 'org-confluence)
;; https://github.com/hgschmie/org-confluence

;; 
;; xwl-paste
;; 
(require 'xwl-paste)

(provide 'wd-misc)
