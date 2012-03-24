;;
;; el-get config
;; 
(require 'el-get)

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-recipes/" 'append)

(el-get)

;;
;; color theme
;; 
(require 'color-theme-hober2)
(color-theme-hober2)
(set-face-attribute 'font-lock-comment-face nil
                    :slant 'normal)

;; (require 'color-theme-humane)
;; (color-theme-humane)

;; (require 'color-theme-solarized)
;; (color-theme-solarized-dark)
;; (require 'zenburn)
;; (color-theme-zenburn);; 
;; (require 'color-theme-tomorrow)
;; (color-theme-tomorrow-night)
;; (color-theme-tomorrow-night-bright)
;; (color-theme-tomorrow-night-eighties)
;; (color-theme-almost-monokai)
;; (color-theme-sanityinc-dark)
;; (color-theme-solarized)
;; (require 'color-theme-zenburn)
;; (color-theme-zenburn)
;; (require 'color-theme-darkmate)
;; (color-theme-darkmate)

;;
;; anything
;; 

(require 'anything-config)
(global-set-key (kbd "M-X") 'sl-anything)
(global-set-key (kbd "M-x") 'anything-M-x)

(defun sl-anything (&optional resume)
  (interactive "P")
  (if (null resume)
      (anything
       :sources '(anything-c-source-buffers-list
                  anything-c-source-recentf
                  anything-c-source-files-in-current-dir+
                  anything-c-source-buffer-not-found))
    (anything-resume)))

;;
;; snippet
;;
(require 'yasnippet)
(add-to-list 'yas/snippet-dirs "~/.emacs.d/snippets" 'append)
(yas/global-mode 1)
;; (yas/initialize)
;; (yas/load-directory "~/.emacs.d/site-lisp/yasnippets/text-mode")

;; (custom-set-faces
;;  '(ac-yasnippet-candidate-face ((t (:foreground "golden"))))
;; )


;;
;; auto complete
;;


(require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/ac-dict")
;; (require 'auto-complete-yasnippet)

;; (ac-config-default)

(defun wd-ac-config ()
  (set-default 'ac-sources
               '(ac-source-yasnippet
                 ac-source-variables
                 ac-source-symbols
                 ac-source-features
                 ac-source-functions 
                 ac-source-words-in-same-mode-buffers
                 ac-source-files-in-current-dir
                 ac-source-filename))
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
  (add-hook 'css-mode-hook 'ac-css-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))

;; (set-face-foreground ac-yasnippet-candidate-face "golden")

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

;; 
;; switch-window mode
;; 
(setq switch-window-shortcut-style 'alphabet)

;; 
;; magit
;; 

(set-face-attribute 'magit-item-highlight nil
                    :underline nil
                    :background "gray14"
                    :foreground nil
                    :inherit nil
)

(provide 'wd-el-get)
