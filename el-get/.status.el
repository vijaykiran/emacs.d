((anything status "installed" recipe
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
 (el-get status "installed" recipe
         (:name el-get
                :website "https://github.com/dimitri/el-get#readme"
                :description "Manage the external elisp bits and pieces you depend upon."
                :type github
                :branch "3.stable"
                :pkgname "dimitri/el-get"
                :features el-get
                :load "el-get.el"))
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
 (switch-window status "installed" recipe
                (:name switch-window
                       :description "A *visual* way to choose a window to switch to"
                       :type github
                       :pkgname "dimitri/switch-window"
                       :features switch-window))
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
