;; 
;; twittering-mode
;; 
(require 'twittering-mode)

(setq twittering-fill-column 60)
;; (setq twittering-my-fill-column 30)

;; 设置成黑色，自动切换颜色有问题
(set-face-background twittering-zebra-1-face "black")
(set-face-background twittering-zebra-2-face "black")


(define-key twittering-mode-map (kbd "C")
      'twittering-erase-all)

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
(setq twittering-regexp-uri "^^$")

;; FIXME: in 23.2, who the hell autoload create-animated-image?? this exists in
;; 24 only.
(when (and (eq window-system 'mac) (< emacs-major-version 24))
  (defalias 'create-animated-image 'create-image))

(setq twittering-tinyurl-service 'toly)

(setq twittering-initial-timeline-spec-string
      `(":home@twitter" ":replies@twitter"
        ":home@sina" ":replies@sina" ":mentions@sina"
        ))

(setq twittering-accounts
      `((twitter
         (username "wd")
        '(ssl t))
))

(setq twittering-image-external-viewer-command
      (case system-type
        ((darwin) "open")
        ((windows-nt) "")))

(setq twittering-use-icon-storage t)

(add-hook 'twittering-mode-hook
          (lambda()
            (goto-address-mode 1)
            (set-face-foreground twittering-uri-face "lemon chiffon")
            ))

(define-key twittering-mode-map (kbd "C")
      'twittering-erase-all)

(define-key twittering-mode-map (kbd "u")
      'twittering-switch-to-unread-timeline)

(defface wd-twittering-user-name-face `((t (:height 1.4 :foreground "LightSalmon"))) "" )
(setq wd-twittering-user-name-face 'wd-twittering-user-name-face)

(defface wd-twittering-other-face `((t (:foreground "dark slate grey"))) "" )
(setq wd-twittering-other-face 'wd-twittering-other-face)


(setq twittering-status-format
      "%i %FACE[wd-twittering-user-name-face]{%s} %FACE[wd-twittering-other-face]{%g, from %f}\n%FOLD[         ]{%t}\n%FOLD[         ]{%r%R}\n"
      twittering-my-status-format
      "%FACE[wd-twittering-user-name-face]{%s} %FACE[wd-twittering-other-face]{%g, from %f} %i\n%FOLD[         ]{%t}\n%FOLD[         ]{%r%R}\n"
)

;; (setq twittering-status-format
;;       "%i %FACE[wd-twittering-user-name-face]{%s} %FACE[wd-twittering-other-face]{%g, from %f:}\n%FOLD[       ]{%t}\n%r%R\n")

(setq twittering-curl-extra-parameters '("--socks5-hostname" "127.0.0.1:7070"))

(provide 'wd-twitter)
