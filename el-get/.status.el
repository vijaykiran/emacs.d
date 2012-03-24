((ace-jump-mode status "installed" recipe
                (:name ace-jump-mode
                       :website "http://www.emacswiki.org/emacs/AceJump"
                       :description "a quick cursor location minor mode for emacs"
                       :type git
                       :url "https://github.com/winterTTr/ace-jump-mode"))
 (anything status "installed" recipe
           (:name anything
                  :website "http://www.emacswiki.org/emacs/Anything"
                  :description "Open anything / QuickSilver-like candidate-selection framework"
                  :type git
                  :url "http://repo.or.cz/r/anything-config.git"
                  :shallow nil
                  :load-path
                  ("." "extensions" "contrib")
                  :features anything))
 (auto-complete status "installed" recipe
                (:name auto-complete
                       :website "http://cx4a.org/software/auto-complete/"
                       :description "The most intelligent auto-completion extension."
                       :type github
                       :pkgname "m2ym/auto-complete"
                       :load-path "."
                       :post-init
                       (progn
                         (require 'auto-complete)
                         (add-to-list 'ac-dictionary-directories
                                      (expand-file-name "dict"))
                         (require 'auto-complete-config)
                         (ac-config-default))))
 (color-theme status "installed" recipe
              (:name color-theme
                     :description "An Emacs-Lisp package with more than 50 color themes for your use. For questions about color-theme"
                     :website "http://www.nongnu.org/color-theme/"
                     :type http-tar
                     :options
                     ("xzf")
                     :url "http://download.savannah.gnu.org/releases/color-theme/color-theme-6.6.0.tar.gz"
                     :load "color-theme.el"
                     :features "color-theme"
                     :post-init
                     (progn
                       (color-theme-initialize)
                       (setq color-theme-is-global t))))
 (color-theme-almost-monokai status "installed" recipe
                             (:name color-theme-almost-monokai
                                    :description "A beautiful, fruity, calm, yet dark color theme for Emacs."
                                    :type github
                                    :pkgname "lut4rp/almost-monokai"
                                    :depends color-theme
                                    :prepare
                                    (autoload 'color-theme-almost-monokai "color-theme-almost-monokai" "color-theme: almost-monokai" t)))
 (color-theme-sanityinc status "installed" recipe
                        (:name color-theme-sanityinc
                               :description "Two pleasant medium-contrast Emacs color themes in light and dark flavours"
                               :type github
                               :pkgname "purcell/color-theme-sanityinc"
                               :depends color-theme
                               :prepare
                               (progn
                                 (autoload 'color-theme-sanityinc-light "color-theme-sanityinc" "color-theme: sanityinc-light" t)
                                 (autoload 'color-theme-sanityinc-dark "color-theme-sanityinc" "color-theme: sanityinc-dark" t))))
 (color-theme-solarized status "removed" recipe
                        (:name color-theme-solarized
                               :description "Emacs highlighting using Ethan Schoonover's Solarized color scheme"
                               :type github
                               :pkgname "sellout/emacs-color-theme-solarized"
                               :depends color-theme
                               :prepare
                               (progn
                                 (add-to-list 'custom-theme-load-path default-directory)
                                 (autoload 'color-theme-solarized-light "color-theme-solarized" "color-theme: solarized-light" t)
                                 (autoload 'color-theme-solarized-dark "color-theme-solarized" "color-theme: solarized-dark" t))))
 (color-theme-zenburn status "installed" recipe
                      (:type github
                             :username "emacsmirror"
                             :name color-theme-zenburn
                             :type emacsmirror
                             :pkgname "zenburn-theme"
                             :description "Just some alien fruit salad to keep you in the zone"
                             :prepare
                             (progn
                               (autoload 'color-theme-zenburn "zenburn" "Just some alien fruit salad to keep you in the zone." t)
                               (defalias 'zenburn #'color-theme-zenburn))))
 (el-get status "installed" recipe
         (:name el-get
                :website "https://github.com/dimitri/el-get#readme"
                :description "Manage the external elisp bits and pieces you depend upon."
                :type github
                :branch "3.stable"
                :pkgname "dimitri/el-get"
                :features el-get
                :load "el-get.el"))
 (emms status "removed" recipe
       (:name emms
              :description "The Emacs Multimedia System"
              :type git
              :url "git://git.sv.gnu.org/emms.git"
              :info "doc"
              :load-path
              ("./lisp")
              :features emms-setup
              :build
              `(,(format "mkdir -p %s/emms " user-emacs-directory)
                ,(concat "make EMACS=" el-get-emacs " SITEFLAG=\"--no-site-file -L " el-get-dir "/emacs-w3m/ \"" " autoloads lisp docs"))
              :depends emacs-w3m))
 (magit status "installed" recipe
        (:name magit
               :website "https://github.com/magit/magit#readme"
               :description "It's Magit! An Emacs mode for Git."
               :type github
               :pkgname "magit/magit"
               :info "."
               :build
               ("make all")
               :build/darwin
               `(,(concat "PATH="
                          (shell-quote-argument invocation-directory)
                          ":$PATH make all"))))
 (org2blog status "installed" recipe
           (:name org2blog
                  :description "Blog from Org mode to wordpress"
                  :type github
                  :pkgname "punchagan/org2blog"
                  :depends xml-rpc-el
                  :features org2blog))
 (php-mode-improved status "installed" recipe
                    (:name php-mode-improved
                           :description "Major mode for editing PHP code. This is a version of the php-mode from http://php-mode.sourceforge.net that fixes a few bugs which make using php-mode much more palatable"
                           :type emacswiki
                           :load
                           ("php-mode-improved.el")
                           :features php-mode))
 (switch-window status "installed" recipe
                (:name switch-window
                       :description "A *visual* way to choose a window to switch to"
                       :type github
                       :pkgname "dimitri/switch-window"
                       :features switch-window))
 (twittering-mode-xwl status "installed" recipe
                      (:name twittering-mode-xwl
                             :website "git://github.com/xwl/twittering-mode"
                             :description "Major mode for Twitter, fork by xwl"
                             :type github
                             :pkgname "xwl/twittering-mode"
                             :features twittering-mode
                             :compile "twittering-mode.el"))
 (xml-rpc-el status "installed" recipe
             (:name xml-rpc-el
                    :description "An elisp implementation of clientside XML-RPC"
                    :type bzr
                    :url "lp:xml-rpc-el"))
 (yasnippet status "installed" recipe
            (:name yasnippet
                   :website "https://github.com/capitaomorte/yasnippet.git"
                   :description "YASnippet is a template system for Emacs."
                   :type github
                   :pkgname "capitaomorte/yasnippet"
                   :features "yasnippet"
                   :pre-init
                   (unless
                       (or
                        (boundp 'yas/snippet-dirs)
                        (get 'yas/snippet-dirs 'customized-value))
                     (setq yas/snippet-dirs
                           (list
                            (concat el-get-dir
                                    (file-name-as-directory "yasnippet")
                                    "snippets"))))
                   :post-init
                   (put 'yas/snippet-dirs 'standard-value
                        (list
                         (list 'quote
                               (list
                                (concat el-get-dir
                                        (file-name-as-directory "yasnippet")
                                        "snippets")))))
                   :compile nil
                   :submodule nil)))
