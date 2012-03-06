;; 
;; twittering-mode
;; 
(require 'twittering-mode)

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

;; (setq twittering-allow-insecure-server-cert t)

;; Also in `gtap', don't set `secure' to "secure: always", use "optional" or
;; "disable", instead.

;; (add-hook 'twittering-edit-mode-hook (lambda ()
;;                                        ;; (flyspell-mode 1)
;;                                        ;; (visual-line-mode 1)
;;                                        (save-excursion
;;                                          (fill-region (point-min) (point-max)))))

;; (add-hook 'twittering-mode-hook (lambda ()
;;                                   (setq cursor-type nil)
;;                                   (hl-line-mode 1)
;;                                   (when (eq system-type 'windows-nt)
;;                                     (setq line-spacing 5))))

;; Disable URI handling in twittering, let's use goto-address-mode instead.
(setq twittering-regexp-uri "^^$")

(eval-after-load 'twittering-mode
  '(progn
     (define-key twittering-mode-map (kbd "C-c C-SPC") 'twittering-switch-to-unread-timeline)

     (twittering-enable-unread-status-notifier)

     (set-face-background twittering-zebra-1-face "gray24")
     (set-face-background twittering-zebra-2-face "gray22")
     ))

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

(setq twittering-status-filter 'xwl-twittering-status-filter)
(defun xwl-twittering-status-filter (status)
  (let ((spec-string (twittering-current-timeline-spec-string)))
    (not (or
          ;; Hide duplicated retweets
          (let ((rt (twittering-is-retweet? status))
                (table (twittering-current-timeline-referring-id-table)))
            (when (and rt table (not (string= spec-string ":mentions@sina")))
              (not (string= (gethash (assqref 'id rt) table)
                            (assqref 'id status)))))
          (when (string= spec-string ":public@socialcast")
            (member (assqref 'screen-name (assqref 'user status))
                    '("VarunPrakash"
                      "Nokia Conversations - Posts"
                      "Ovi by Nokia"
                      "datainsight")))))))

(setq twittering-use-icon-storage t)

(provide 'wd-twitter)
