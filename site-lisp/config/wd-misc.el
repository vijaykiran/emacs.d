;; -----
;; misc
;; -----

(load "~/.pwds")

;; (setq browse-url-browser-function 'browse-url-generic
;;       browse-url-generic-program "google-chrome")

(if (eq system-type 'darwin)
    (setq browse-url-browser-function 'browse-url-default-macosx-browser)
  (setq browse-url-browser-function 'browse-url-firefox
        browse-url-new-window-flag  t
        browse-url-firefox-new-window-is-tab t)
  )

;; (setq compilation-environment (list "LZ_HOST=t.api.linezing.com"))

;; http://jff.googlecode.com/svn/trunk/XDE/xde/emacs/dot_emacs.d/site-start.d/01_font.el
;; Way 1
(let ((zh-font "STHeiTi:pixelsize=14")
;; (let ((zh-font "WenQuanYi Zen Hei Mono:pixelsize=14")
      (fontset "fontset-my"))
  (create-fontset-from-fontset-spec
    (concat
      ;; "-unknown-monofur-*-*-*-*-15-*-*-*-*-*-" fontset
      "-unknown-Monaco-*-*-*-*-12-*-*-*-*-*-" fontset
      ",kana:"          zh-font
      ",han:"           zh-font
      ",symbol:"        zh-font
      ",cjk-misc:"      zh-font
      ",bopomofo:"      zh-font))
  (set-default-font fontset)
  (add-to-list 'default-frame-alist `(font . ,fontset)))

(require 'color-theme-hober2)
(color-theme-hober2)

(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  )

;; (require 'color-theme-humane)
;; (color-theme-humane)

;; (require 'color-theme-solarized)
;; (color-theme-solarized-dark)
;; (require 'zenburn)
;; (color-theme-zenburn)
;; I use this key for input method
(global-unset-key (kbd "C-SPC"))

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
(setq scroll-margin 3
      scroll-conservatively 2)
;; highlight-parentness-mode

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
;; twiki
;;
;; (require 'erin)
;; (add-to-list 'auto-mode-alist
;; '("\\twiki.*\\'" . erin-mode))

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
;; weblogger mode
;;

;; (require 'weblogger)

;; (setq weblogger-server-password weblogger-pass)

;; (add-hook 'weblogger-start-edit-entry-hook (lambda()
;;     (auto-fill-mode -1)
;;     (abbrev-mode -1)
;;     (auto-complete-mode 1)
;;     ))

;;
;; muse
;;

;;(require 'muse-html)

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

(add-hook 'cperl-mode-hook 'sl-highlight-todo)


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


(require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/ac-dict")
(require 'auto-complete-yasnippet)

;; (ac-config-default)

(defun wd-ac-config ()
;;  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
  (set-default 'ac-sources
               '(;ac-source-semantic
                 ac-source-yasnippet
                 ac-source-abbrev
                 ac-source-words-in-buffer
                 ac-source-words-in-all-buffer
                                        ;ac-source-imenu
                 ac-source-files-in-current-dir
                 ac-source-dictionary
                 ac-source-filename))
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
  (add-hook 'css-mode-hook 'ac-css-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))

(wd-ac-config)

(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
(setq ac-auto-start 3)
(define-key ac-complete-mode-map "\t" 'ac-complete)
(define-key ac-complete-mode-map "\r" nil)
;;(add-to-list 'ac-trigger-commands 'org-self-insert-command)
(setq ac-dwim t)


;;
;; high light tail
;; 
;; (require 'highlight-tail)
;; (setq highlight-tail-colors  '(("#bc2525" . 0)))
;; ;(setq highlight-tail-colors  '(("#ffd700" . 0)))
;; ;(setq highlight-tail-colors  '(("#ffefa6" . 0)))
;; (highlight-tail-mode)

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
;; (setq view-read-only t)

;; (add-hook 'find-file-hook
;;       (lambda ()
;;         (view-mode t)))

;; (defun view-mode-keybinding-hook ()
;;   (define-key view-mode-map "h" 'backward-char)
;;   (define-key view-mode-map "l" 'forward-char)
;;   (define-key view-mode-map "j" 'next-line)
;;   (define-key view-mode-map "k" 'previous-line)
;;   (define-key view-mode-map "b" 'scroll-down)
;;   (define-key view-mode-map "f" 'scroll-up))

;; (add-hook 'view-mode-hook 'view-mode-keybinding-hook)

;; 
;; tramp
;; 

(require 'tramp)
(setq tramp-default-method "ssh")
(setq tramp-default-user "dong.wang")

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

;; 
;; ibuffer
;; 

(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("dired" (mode . dired-mode))
               ("perl" (mode . cperl-mode))
               ("erc" (mode . erc-mode))
               ("javascript" (mode . js2-mode))
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
;; portage mode
;; 
;; (require 'portage)
;; (global-set-key (kbd "\C-c p") 'portage-search)

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
;; 
;; (require 'drkm-fav)

;; (setq drkm-fav:favourite-directories-alist
;;   '(("home"  . "/bood@remote.host.com:~")
;;     ("kernow-src" . "")))
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
;; git
;; 

(require 'magit)

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
;; muse-html-slidy
;;

;; (require 'muse-mode)
;; (require 'muse-html)
;; (setq muse-html-slidy-style-dir "/home/wd/work/html-slidy/")
;; (require 'muse-html-slidy)


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


(require 'tiling)
;; ;;; Windows related operations
;; ;; Split & Resize
;; (define-key global-map (kbd "C-x |") 'split-window-horizontally)
;; (define-key global-map (kbd "C-x _") 'split-window-vertically)
;; (define-key global-map (kbd "C-{") 'shrink-window-horizontally)
;; (define-key global-map (kbd "C-}") 'enlarge-window-horizontally)
;; (define-key global-map (kbd "C-^") 'enlarge-window)
;; Navgating: Windmove uses C-<up> etc.
(define-key global-map (kbd "C-<up>"   ) 'windmove-up)
(define-key global-map (kbd "C-<down>" ) 'windmove-down)
(define-key global-map (kbd "C-<left>" ) 'windmove-right)
(define-key global-map (kbd "C-<right>") 'windmove-left)
;; Swap buffers: M-<up> etc.
(define-key global-map (kbd "M-<up>"   ) 'buf-move-up)
(define-key global-map (kbd "M-<down>" ) 'buf-move-down)
(define-key global-map (kbd "M-<right>") 'buf-move-right)
(define-key global-map (kbd "M-<left>" ) 'buf-move-left)
;; ;; Tile
;; (define-key global-map (kbd "C-\\") 'tiling-cycle) ; accepts prefix number
;; (define-key global-map (kbd "C-M-<up>") 'tiling-tile-up)
;; (define-key global-map (kbd "C-M-<down>") 'tiling-tile-down)
;; (define-key global-map (kbd "C-M-<right>") 'tiling-tile-right)
;; (define-key global-map (kbd "C-M-<left>") 'tiling-tile-left)
;; ;; Another type of representation of same keys, in case your terminal doesn't
;; ;; recognize above key-binding. Tip: C-h k C-up etc. to see into what your
;; ;; terminal tranlated the key sequence.
;; (define-key global-map (kbd "M-[ a"     ) 'windmove-up)
;; (define-key global-map (kbd "M-[ b"     ) 'windmove-down)
;; (define-key global-map (kbd "M-[ c"     ) 'windmove-right)
;; (define-key global-map (kbd "M-[ d"     ) 'windmove-left)
;; (define-key global-map (kbd "ESC <up>"   ) 'buf-move-up)
;; (define-key global-map (kbd "ESC <down>" ) 'buf-move-down)
;; (define-key global-map (kbd "ESC <right>") 'buf-move-right)
;; (define-key global-map (kbd "ESC <left>" ) 'buf-move-left)
;; (define-key global-map (kbd "ESC M-[ a" ) 'tiling-tile-up)
;; (define-key global-map (kbd "ESC M-[ b" ) 'tiling-tile-down)
;; (define-key global-map (kbd "ESC M-[ c" ) 'tiling-tile-right)
;; (define-key global-map (kbd "ESC M-[ d" ) 'tiling-tile-left)

;; 
;; el screen
;; 
;; (load "elscreen" "ElScreen" t)
;; (setq elscreen-prefix-key "\C-z")
;; (global-set-key (kbd "<f9>"    ) 'elscreen-create)
;; (global-set-key (kbd "S-<f9>"  ) 'elscreen-kill)
(winner-mode 1)
(global-set-key (kbd "s-j") `winner-undo)
(global-set-key (kbd "s-k") `winner-redo)

;; 
;; org2blog
;;

(require 'org2blog-autoloads)
(setq org2blog/wp-blog-alist
      `(("wdicc"
         :url "http://wdicc.com/xmlrpc.php"
         :username "admin"
         :keep-new-lines t
         :confirm t
         :wp-code nil
         :tags-as-categories nil)
        ))

(setq org2blog/wp-buffer-template
  "#+DATE: %s
#+OPTIONS: toc:t num:nil todo:nil pri:nil tags:nil ^:nil TeX:nil 
#+CATEGORY: Heart
#+TAGS: 
#+PERMALINK: 
#+TITLE:
\n")



;; narrowing
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)

;; 
;; diary
;;

;; (setq diary-file "~/org/diary")
;; (setq appt-issue-message t)
;; (setq mark-diary-entries-in-calendar t)

;; open a shell pop window

;; (defvar th-shell-popup-buffer nil)

;; (defun th-shell-popup ()
;;   "Toggle a shell popup buffer with the current file's directory as cwd."
;;   (interactive)
;;   (unless (buffer-live-p th-shell-popup-buffer)
;;     (save-window-excursion (shell "*Popup Shell*"))
;;     (setq th-shell-popup-buffer (get-buffer "*Popup Shell*")))
;;   (let ((win (get-buffer-window th-shell-popup-buffer))
;; 	(dir (file-name-directory (or (buffer-file-name)
;; 				      ;; dired
;; 				      dired-directory
;; 				      ;; use HOME
;; 				      "~/"))))
;;     (if win
;; 	(delete-window win)
;;       (pop-to-buffer th-shell-popup-buffer nil t)
;;       (comint-send-string nil (concat "cd " dir "\n")))))

;; (global-set-key (kbd "<f12>") 'th-shell-popup)


;; 
;; ibus
;; 

;; (require 'ibus)
;; (setq ibus-agent-file-name "~/.emacs.d/site-lisp/ibus-el-agent")
;; (setq ibus-cursor-color '("red" "blue" "limegreen"))
;; (if (not (eq system-type 'darwin))
;;     (if (and (fboundp 'daemonp) (daemonp))
;;         (add-hook 'after-make-frame-functions
;;                   (lambda (new-frame)
;;                     (select-frame new-frame)
;;                     (or ibus-mode (ibus-mode-on))))
;;       (add-hook 'after-init-hook 'ibus-mode-on)
;;       )
;;   )

(provide 'wd-misc)
