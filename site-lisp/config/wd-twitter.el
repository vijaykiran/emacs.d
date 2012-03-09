;; 
;; twittering-mode
;; 
(require 'twittering-mode)

(setq twittering-fill-column 60)

(set-face-background twittering-zebra-1-face "black")
(set-face-background twittering-zebra-2-face "black")


(define-key twittering-mode-map (kbd "C")
      'twittering-erase-all)

(twittering-enable-unread-status-notifier)
(twittering-icon-mode)

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
      `(":home@twitter" ":replies@twitter"))

(setq twittering-accounts
      `((twitter
         (username "wd")
        '(ssl t))))

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

(defface wd-twittering-user-name-face `((t (:height 1.2 :foreground "tan"))) "" )
(setq wd-twittering-user-name-face 'wd-twittering-user-name-face)

(setq twittering-status-format
      "%FACE[wd-twittering-user-name-face]{%i} %s %g, from %f%r%R:\n%FOLD[         ]{%t}\n"
      twittering-my-status-format
      "%FACE[twittering-zebra-1-face,twittering-zebra-2-face]{%s %g, from %f%r%R:} %i\n%{%t}\n")

(setq twittering-curl-extra-parameters '("--socks5-hostname" "127.0.0.1:7070"))

(provide 'wd-twitter)
