;;
;; emms
;;


(require 'emms-setup)
(emms-standard)
;; no cli volume setup tools in windows
;(require 'emms-volume)
;; autodetect musci files id3 tags encodeing
(require 'emms-i18n)
;; auto-save and import last playlist
(require 'emms-history)

(setq emms-repeat-playlist 1)

(setq emms-playlist-buffer-name "*EMMS Playlist*"
      emms-source-file-default-directory "/data/music/"
      emms-playing-time-style 'bar
      emms-info-asynchronously nil)


(emms-default-players)
(setq emms-player-mpg321-command-name "mpg123")
(require 'emms-mode-line-icon)
(emms-mode-line-enable)

;;  mode line
(setq emms-mode-line-mode-line-function 'xwl-emms-mode-line-playlist-current)
(setq emms-mode-line-titlebar-function nil)

(defun xwl-emms-mode-line-playlist-current ()
  "Format the currently playing song."
  (let* ((track (emms-playlist-current-selected-track))
         (type (emms-track-type track))
         (name (emms-track-name track))
         (artist (emms-track-get track 'info-artist))
         (title (emms-track-get track 'info-title)))
    (concat emms-mode-line-icon-before-format
            (emms-propertize "NP:" 'display emms-mode-line-icon-image-cache)
            (format "[ %s ]"
                    (cond
                     ((and artist title)
                      (concat artist " - " title))
                     (title
                      title)
                     ((eq type 'file)
                      (file-name-sans-extension (file-name-nondirectory name)))
                     (t
                      (concat (symbol-name type) ":" name)))))))

;; playlist
(require 'emms-last-played)
(setq emms-last-played-format-alist
      '(((emms-last-played-seconds-today) . "%a %H:%M")
(604800 . "%a %H:%M") ; this week
((emms-last-played-seconds-month) . "%d")
((emms-last-played-seconds-year) . "%m/%d")
(t . "%Y/%m/%d")))

(defun xwl-emms-track-description-function (track)
  "Return a description of the current track."
  (let* ((name (emms-track-name track))
         (type (emms-track-type track))
         (short-name (file-name-nondirectory name))
         (play-count (or (emms-track-get track 'play-count) 0))
         (last-played (or (emms-track-get track 'last-played) '(0 0 0)))
         (empty "..."))
    (prog1
        (case type
          ((file url)
           (let* ((artist (or (emms-track-get track 'info-artist) empty))
                  (year (emms-track-get track 'info-year))

                  (playing-time (or (emms-track-get track 'info-playing-time) 0))
                  (min (/ playing-time 60))
                  (sec (% playing-time 60))

                  (album (or (emms-track-get track 'info-album) empty))

                  (tracknumber (or (emms-track-get track 'info-tracknumber) ""))

                  (short-name (file-name-sans-extension (file-name-nondirectory name)))
                  (title (or (emms-track-get track 'info-title) short-name))
                  (ext (file-name-extension name))

                  ;; last track
                  (ltrack xwl-emms-playlist-last-track)
                  (lartist (or (and ltrack (emms-track-get ltrack 'info-artist))
                               empty))
                  (lalbum (or (and ltrack (emms-track-get ltrack 'info-album))
                              empty))

                  (same-album-p (and (not (string= lalbum empty))
                                     (string= album lalbum))))

             ;; (format "%10s %3d %-20s%-50s%-40s%-12s%-10s%s"
             ;;         (emms-last-played-format-date last-played)
             ;;         play-count
             ;;         artist

             ;;         ;; Combine indention, tracknumber, title.
             ;;         ;; (format "%s%s%-40s"
             ;;         (concat
             ;;          (if same-album-p ; indention by album
             ;;              (setq xwl-emms-playlist-last-indent
             ;;                    (concat " " xwl-emms-playlist-last-indent))
             ;;            (setq xwl-emms-playlist-last-indent "\\")
             ;;            "")

             ;;          (if (string= tracknumber "") "" (format "%2s." tracknumber))

             ;;          title)

             ;;         ;; album
             ;;         (cond ((string= album empty) empty)
             ;;               ;; (same-album-p " ")
             ;;               (t (concat "《" album "》")))

             ;;         (or year empty)
             ;;         (if (or (> min 0) (> sec 0))
             ;;             (format "%02d:%02d" min sec)
             ;;           empty)

             ;;         ext

             ;;         )))

             (format "%-20s %-30s %-40s %s"
                     artist
                     ;; Combine indention, tracknumber, title.
                     ;; (format "%s%s%-40s"
                     (concat
                      (if same-album-p ; indention by album
                          (setq xwl-emms-playlist-last-indent
                                (concat " " xwl-emms-playlist-last-indent))
                        (setq xwl-emms-playlist-last-indent "\\")
                        "")

                      (if (string= tracknumber "") "" (format "%2s." tracknumber))

                      title)

                     ;; album
                     (cond ((string= album empty) empty)
                           ;; (same-album-p " ")
                           (t (concat "《" album "》")))

                     (if (or (> min 0) (> sec 0))
                         (format "%02d:%02d" min sec)
                       empty)
                     )))

          ((url)
           (concat (symbol-name type)
                   ":"
                   (decode-coding-string
                    (encode-coding-string name 'utf-8)
                    'gbk)))
          (t
           (format "%-3d%s"
                   play-count
                   (concat (symbol-name type) ":" name))))

      (setq xwl-emms-playlist-last-track track))))

(eval-after-load 'emms
  '(progn
     (setq xwl-emms-playlist-last-track nil
           xwl-emms-playlist-last-indent "\\"
           emms-track-description-function 'xwl-emms-track-description-function)
     ))


(global-set-key (kbd "C-c e x") 'emms-start)
(global-set-key (kbd "C-c e v") 'emms-stop)

(global-set-key (kbd "C-c e n") 'emms-next)
(global-set-key (kbd "C-c e p") 'emms-previous)

(global-set-key (kbd "C-c e e") 'emms-history-load)

(require 'emms-info-libtag)
(setq emms-info-functions '(emms-info-libtag))
(setq emms-cache-file "~/.emacs.d/emms/emms-cache"
      emms-history-file "~/.emacs.d/emms/emms-history")

;; coding settings
(setq
;      emms-info-mp3info-coding-system 'gbk
;      emms-info-libtag-coding-system 'gbk
      emms-cache-file-coding-system 'utf-8-emacs
      emms-history-file-coding-system emms-cache-file-coding-system
      emms-i18n-default-coding-system '(no-conversion . no-conversion))
(add-hook 'emms-player-started-hook
          'wd-notify-track-info)

(defun wd-notify-track-info ()
   "notify track info in xinwindow"
   (let* (
          (empty "")
          (artist (or (emms-track-get track 'info-artist) empty))

          (year (emms-track-get track 'info-year))

          (tracknumber (or (emms-track-get track 'info-tracknumber) ""))

          (playing-time (or (emms-track-get track 'info-playing-time) 0))
          (min (/ playing-time 60))
          (sec (% playing-time 60))

          (album (or (emms-track-get track 'info-album) empty))

          (short-name (file-name-sans-extension (file-name-nondirectory name)))
          (title (or (emms-track-get track 'info-title) short-name))
          )
     (wd-send-tray-notify "/data/misc/emms.jpg"
                          (format "%s - %s" artist title)
                          (format "%s %s %s"
                                  year
                                  (cond ((string= album empty) empty)
                                        ;; (same-album-p " ")
                                        (t (concat "《" album "》")))

                                  (if (or (> min 0) (> sec 0))
                                      (format "%02d:%02d" min sec)
                                    empty)
                                  ))
     ))

;当播放完当前的歌曲时随机选择下一首歌曲
(add-hook 'emms-player-finished-hook 'emms-random)

(provide 'wd-emms)