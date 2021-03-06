;; 
;; twittering-mode
;; 
(require 'twittering-mode)

(add-to-list 'exec-path "/usr/local/bin" 'append)

(setq twittering-use-master-password t)

(setq twittering-fill-column 60)
;; (setq twittering-my-fill-column 30)

;; 设置成黑色，自动切换颜色有问题
(set-face-background twittering-zebra-1-face "black")
(set-face-background twittering-zebra-2-face "black")

;; notify me at status bar when there is new tweet
(twittering-enable-unread-status-notifier)
;; show icon in tweet
(twittering-icon-mode 1)

(setq twittering-retweet-format "RT @%s: %t"
      twittering-use-native-retweet t)

(setq twittering-new-tweets-count-excluding-me t
      twittering-new-tweets-count-excluding-replies-in-home t
      twittering-timer-interval 300
      )

;; Disable URI handling in twittering, let's use goto-address-mode instead.
;; (setq twittering-regexp-uri "^^$")
;; (setq twittering-regexp-uri  "\\(https?://[-_.!~*'()a-zA-Z0-9;/?:@&=+$,%#]+\\)")


;; FIXME: in 23.2, who the hell autoload create-animated-image?? this exists in
;; 24 only.
(when (and (eq window-system 'mac) (< emacs-major-version 24))
  (defalias 'create-animated-image 'create-image))

(setq twittering-tinyurl-service 'toly)

(setq twittering-initial-timeline-spec-string
      `(":home@twitter" ":replies@twitter"
        ":home@sina" ":replies@sina" ":mentions@sina"
        ))

(defface wd-twittering-user-name-face `((t (:height 1.4 :foreground "LightSalmon"))) "" )
(setq wd-twittering-user-name-face 'wd-twittering-user-name-face)

(defface wd-twittering-other-face `((t (:foreground "cadet blue"))) "" )
(setq wd-twittering-other-face 'wd-twittering-other-face)

(defface wd-twittering-quoted-face `((t (:foreground "indian red"))) "" )
(setq wd-twittering-quoted-face 'wd-twittering-quoted-face)

(setq twittering-accounts
      `((twitter
         (ssl t)
         (quotation before)
         ;; (status-format
         ;;  "%i %FACE[wd-twittering-user-name-face]{%s} %FACE[wd-twittering-other-face]{%g, from %f}\n%FOLD[         ]{%t}\n%FOLD[         ]{%r%R}\n")
         ;; (my-status-format
         ;;  "%FACE[wd-twittering-user-name-face]{%s} %FACE[wd-twittering-other-face]{%g, from %f} %i\n%FOLD[         ]{%t}\n%FOLD[         ]{%r%R}\n")
         )
        (sina
         (quotation after)
         ;; (status-format
         ;;  "%i %FACE[wd-twittering-user-name-face]{%s} %FACE[wd-twittering-other-face]{%g, from %f}\n%FOLD[         ]{%t}\n%FOLD[         ]{%r%R}\n")
         ;; (my-status-format
         ;;  "%FACE[wd-twittering-user-name-face]{%s} %FACE[wd-twittering-other-face]{%g, from %f} %i\n%FOLD[         ]{%t}\n%FOLD[         ]{%r%R}\n")
         ))
)

(setq twittering-image-external-viewer-command
      (case system-type
        ((darwin) "open")
        ((gnu/linux) "xdg-open")
        ((windows-nt) "")))

(setq twittering-use-icon-storage t)

(add-hook 'twittering-mode-hook
          (lambda()
            ;; (goto-address-mode 1)
            (set-face-foreground twittering-uri-face "lemon chiffon")
            ))

(define-key twittering-mode-map (kbd "h") 'twittering-refresh)
(define-key twittering-mode-map (kbd "t") 'twittering-toggle-thumbnail)
(define-key twittering-mode-map (kbd "R") 'twittering-retweet)
(define-key twittering-mode-map (kbd "O") 'twittering-organic-retweet)
(define-key twittering-mode-map (kbd "C") 'twittering-erase-all)
(define-key twittering-mode-map (kbd "u") 'twittering-switch-to-unread-timeline)
(define-key twittering-mode-map (kbd "@") 'twittering-reply-to-user)
(define-key twittering-mode-map (kbd "C-c @") 'twittering-reply-all)

(setq twittering-status-format
      "%i %FACE[wd-twittering-user-name-face]{%s} %FACE[wd-twittering-other-face]{%g, from %f}\n%FOLD[         ]{%t}\n%FOLD[         ]{%r%R}\n"
      twittering-my-status-format
      "%FACE[wd-twittering-user-name-face]{%s} %FACE[wd-twittering-other-face]{%g, from %f} %i\n%FOLD[         ]{%t}\n%FOLD[         ]{%r%R}\n"
)

;; (setq twittering-status-format
;;       "%i %FACE[wd-twittering-user-name-face]{%s} %FACE[wd-twittering-other-face]{%g, from %f:}\n%FOLD[       ]{%t}\n%r%R\n")

(setq twittering-curl-socks-proxy '("--socks5-hostname" "127.0.0.1:7070")
      twittering-uri-regexp-to-proxy "twitter.com")


(provide 'wd-twitter)
