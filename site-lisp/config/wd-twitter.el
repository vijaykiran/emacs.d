;; 
;; twittering-mode
;; 
(require 'twittering-mode)

;; (setq twittering-oauth-use-ssl nil
;;       twittering-use-ssl nil)

(setq twittering-fill-column 60)

(setq xwl-twittering-padding-size 5)
(setq twittering-my-fill-column (- twittering-fill-column
                                   xwl-twittering-padding-size))

;; (set-face-background twittering-zebra-1-face "gray4")
;; (set-face-background twittering-zebra-2-face "gray4")

;; (set-face-foreground twittering-zebra-2-face "magenta")
;; (set-face-foreground twittering-zebra-1-face "deep sky blue")

;; (set-face-foreground twittering-uri-face "red")
;; (set-face-foreground twittering-username-face "red")


(setq twittering-retweet-format "RT @%s: %t")

(define-key twittering-mode-map (kbd "C")
      'twittering-erase-all)

(twittering-enable-unread-status-notifier)
(twittering-icon-mode)

(provide 'wd-twitter)
