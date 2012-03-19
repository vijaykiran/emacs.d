;;
;; el-get config
;; 
(require 'el-get)

(el-get 'sync)

;;
;; color theme
;; 
;; (require 'color-theme-hober2)
;; (color-theme-hober2)
;; (require 'color-theme-humane)
;; (color-theme-humane)

;; (require 'color-theme-solarized)
;; (color-theme-solarized-dark)
;; (require 'zenburn)
;; (color-theme-zenburn)
(require 'color-theme-tomorrow)
;; (color-theme-tomorrow-night)
(color-theme-tomorrow-night-bright)
;; (color-theme-tomorrow-night-eighties)


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
;; org2blog
;;

;; (require 'org2blog-autoloads)
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



(provide 'wd-el-get)
