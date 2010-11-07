;; ----
;; erc
;; ----

;;
;; misc
;;
(setq erc-default-coding-system '(utf-8     . utf-8)
;      erc-encoding-coding-alist '(("#eeee" . chinese-iso-8bit)))
      )
(setq erc-nick "wd"
      erc-user-full-name "wd")
(setq erc-nick-uniquifier "_")

(setq erc-ignore-list nil)
(setq erc-hide-list
      '("JOIN" "PART" "QUIT" "MODE"))

(require 'erc-nick-colors)

;; Do not make nicks as buttons
(setq erc-button-buttonize-nicks nil)

;; auto away
(require 'erc-autoaway)
;; Auto un-away
(setq erc-auto-discard-away t)

;; Channel specific prompt
(setq erc-prompt (lambda ()
                   (if (and (boundp 'erc-default-recipients)
                            (erc-default-target))
                       (erc-propertize (concat (erc-default-target) ">")
                                       'read-only t
                                       'rear-nonsticky t
                                       'front-nonsticky t)
                     (erc-propertize (concat "ERC>")
                                     'read-only t
                                     'rear-nonsticky t
                                     'front-nonsticky t))))

;; auto connect
(defun wd-erc-select ()
  (interactive)
  (unless oftc-wd-pass
    (setq oftc-wd-pass (read-passwd "irc.oftc.net password: ")))
  (erc :server "irc.oftc.net" :port 6667 :nick "wd" :password oftc-wd-pass)
  (erc :server "irc.freenode.net" :port 6667 :nick "wd_afei" :password oftc-wd-pass)
  (if (wd-at-company)
      (erc :server "www.pgsqldb.org" :port 34567 :nick "wd")
      ;; (erc :server "10.62.163.59" :port 6667 :nick "wd")
    )
)
(global-set-key (kbd "C-c n E") 'wd-erc-select)

;; auto join
(erc-autojoin-mode 1)
(setq erc-autojoin-channels-alist
      '(
        ("oftc.net"
         "#openbox-cn"
         "#arch-cn"
         "#emacs-cn")
        ("freenode.net"
         "#openresty")
        ("iioftc.net"
         "#wd")
        ("EEEE"
         "#eeee")
        ("www.pgsqldb.com"
         "#eeee"
         "#qunar")
        ))

;;
;; notify
;;

(defun erc-tray-change-state (arg)
   (if arg
       (shell-command-to-string
        "echo B > /tmp/tray_daemon_control")
     (shell-command-to-string
      "echo b > /tmp/tray_daemon_control")))

(defun erc-send-tray-notify (nick message)
    (let ((default-directory "~/"))
      (setq realnick (elt (split-string nick "!") 0))
      (wd-send-tray-notify "/data/misc/irc.png" (format "ERC: %s says" realnick) (format "%s" message))))

;; use this to auto cancel notify
;; (add-hook 'erc-send-pre-hook
;;           (lambda(s)
;;             (erc-tray-change-state nil)))
(eval-after-load 'erc
  '(progn
     (defadvice erc-send-input (before change-tray-status activate)
       (erc-tray-change-state nil))))


(require 'erc-match)
(erc-match-mode 1)
(setq erc-current-nick-highlight-type 'nick-or-keyword)
; (setq erc-keywords '("gentoo" "linux" "\\bwd\\b" "\\bwd_\\b"))
(setq erc-keywords '("\\bwd\\b" "\\bwd_\\b"))
(setq erc-pals nil)

(defvar my-erc-page-message "%s is calling your name."
  "Format of message to display in dialog box")

(defvar my-erc-page-nick-alist nil
  "Alist of nicks and the last time they tried to trigger a
notification")

(defvar my-erc-page-timeout 10
  "Number of seconds that must elapse between notifications from
the same person.")

(defun my-erc-page-popup-notification (nick message)
  (when window-system
    (erc-tray-change-state t)
    (erc-send-tray-notify nick message)
    ))

(defun my-erc-page-allowed (nick &optional delay)
  "Return non-nil if a notification should be made for NICK.
If DELAY is specified, it will be the minimum time in seconds
that can occur between two notifications.  The default is
`my-erc-page-timeout'."
  (unless delay (setq delay my-erc-page-timeout))
  (let ((cur-time (time-to-seconds (current-time)))
        (cur-assoc (assoc nick my-erc-page-nick-alist))
        (last-time))
    (if cur-assoc
        (progn
          (setq last-time (cdr cur-assoc))
          (setcdr cur-assoc cur-time)
          (> (abs (- cur-time last-time)) delay))
      (push (cons nick cur-time) my-erc-page-nick-alist)
      t)))

(defun my-erc-page-me (match-type nick message)
  "Notify the current user when someone sends a message that
matches a regexp in `erc-keywords'."
  (interactive)
  (when (and (eq match-type 'keyword)
             ;; I don't want to see anything from the erc server
             (null (string-match "\\`\\([sS]erver\\|localhost\\)" nick))
             ;; or bots
             (null (string-match "\\(bot\\|serv\\)!" nick))
             ;; or from those who abuse the system
             (my-erc-page-allowed nick))
    (my-erc-page-popup-notification nick message)))
(add-hook 'erc-text-matched-hook 'my-erc-page-me)

(defun my-erc-page-me-PRIVMSG (proc parsed)
  (let ((nick (car (erc-parse-user (erc-response.sender parsed))))
        (target (car (erc-response.command-args parsed)))
        (msg (erc-response.contents parsed)))
    (when (and (erc-current-nick-p target)
               (not (erc-is-message-ctcp-and-not-action-p msg))
               (my-erc-page-allowed nick))
      (my-erc-page-popup-notification nick "private message")
      nil)))
(add-hook 'erc-server-PRIVMSG-functions 'my-erc-page-me-PRIVMSG)

;;
;; timestamp
;;

(erc-timestamp-mode 1)

;; these codes is copied from emacswiki
(make-variable-buffer-local
 (defvar erc-last-datestamp nil))

(defun ks-timestamp (string)
  (erc-insert-timestamp-left string)
  (let ((datestamp (erc-format-timestamp (current-time) erc-datestamp-format)))
    (unless (string= datestamp erc-last-datestamp)
      (erc-insert-timestamp-left datestamp)
      (setq erc-last-datestamp datestamp))))

(setq erc-timestamp-only-if-changed-flag t
      erc-timestamp-format "%H:%M "
      erc-datestamp-format " === [%Y-%m-%d %a] ===\n" ; mandatory ascii art
      erc-fill-prefix "      "
      erc-insert-timestamp-function 'ks-timestamp)

;;
;; log
;;
(require 'erc-log)
(erc-log-mode 1)
(setq erc-log-channels-directory "~/logs"
      erc-save-buffer-on-part t
      erc-log-file-coding-system 'utf-8
      erc-log-write-after-send t
      erc-log-write-after-insert t)
(unless (file-exists-p erc-log-channels-directory)
  (mkdir erc-log-channels-directory t))

 (defun my-erc-generate-log-file-name-short (buffer &optional target
          nick server port)
   "This function uses the buffer-name as a file, with some replacing."
   (let* ((name (buffer-name buffer))
          (name (replace-regexp-in-string "|" "-" name)))
     (concat erc-log-channels-directory "/" name ".txt"))
)


(defun wd-erc-generate-log-file-name (buffer &optional target nick server port)
  "generate file name like server_target.log"
   ;(print (format "buffer:%s, target:%s, nick:%s, server:%s, port:%s" buffer target nick server port))
   (if (string= 
        (format "%s" buffer) 
        (format "%s:%s" server port))
       (concat (format "%s" server) ".log") ; server buffer
     (concat (format "%s" server) "_" (format "%s" target) ".log")))

;; 让 log 文件按照 server_target.log 这种格式保存
(setq erc-generate-log-file-name-function 'wd-erc-generate-log-file-name)

;;
;; identify
;;
(defun xwl-erc-auto-identify (server nick)
   (if (string-match "oftc.net" server)
       (erc-message "PRIVMSG"
           (format "NickServ identify %s" oftc-wd-pass)))
   (if (string-match "pgsqldb" server)
       (erc-message "PRIVMSG"
           (format "NickServ identify %s" pgsqldb-wd-pass))))

(add-hook 'erc-after-connect 'xwl-erc-auto-identify)

(defun wd-clear-erc-notify ()
  "clear all notify by erc at once"
  (interactive)
  (setq erc-modified-channels-alist nil
        erc-modified-channels-object "")
  (erc-modified-channels-update))

(global-set-key (kbd "C-c n C") 'wd-clear-erc-notify)

(provide 'wd-erc)
