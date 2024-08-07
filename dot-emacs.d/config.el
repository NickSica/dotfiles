(setq native-comp-async-report-warnings-errors nil)
(setq native-compile-prune-cache t)
;; Use a hook so the message doesn't get clobbered by other messages.
(add-hook 'emacs-startup-hook
        (lambda ()
          (message "Emacs ready in %s with %d garbage collections."
                   (format "%.2f seconds"
                           (float-time
                            (time-subtract after-init-time before-init-time)))
                   gcs-done)))

(setq straight-base-dir "~/.emacs.d/cache/")
;; TEMPORARY FIX UNTIL STRAIGHT IS FIXED THIS WILL BREAK SOON
(setq straight-repository-branch "develop")
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "cache/straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Use straight.el for setup
(straight-use-package 'use-package)

(use-package straight
  :custom (straight-use-package-by-default t))

(use-package esup
  :ensure t)

;; Change the user-emacs-directory to keep unwanted things out of ~/.emacs.d
(setq url-history-file (expand-file-name "cache/url/history/" user-emacs-directory))
(setq vc-follow-symlinks t)

;; Use no-littering to automatically set common paths to the new user-emacs-directory
(use-package no-littering
  :init
  (setq no-littering-etc-directory
        (expand-file-name "cache/config/" user-emacs-directory))
  (setq no-littering-var-directory
        (expand-file-name "cache/data/" user-emacs-directory)))

;; Keep customization settings in a temporary file (thanks Ambrevar!)
(setq custom-file
      (if (boundp 'server-socket-dir)
          (expand-file-name "custom.el" server-socket-dir)
        (expand-file-name (format "emacs-custom-%s.el" (user-uid)) temporary-file-directory)))
(load custom-file t)

(setq make-backup-files nil)
(setq auto-save-default nil)

;; Escape cancels all
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Rebind C-u since evil-mode uses it for scrolling
(global-set-key (kbd "C-M-u") 'universal-argument)

(use-package undo-tree
  :init
  (setq undo-tree-auto-save-history nil)
  (global-undo-tree-mode 1))

(use-package goto-chg)

(setq evil-want-keybinding nil)
(setq evil-want-integration t)
(use-package evil
  :init
  (setq evil-respect-visual-line-mode t)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-want-fine-undo t)
  (setq evil-undo-system 'undo-tree)
  (setq evil-search-module 'evil-search)
  :config
  (evil-mode 1)

  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-d") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line))

(use-package evil-numbers
  :config
  (define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt))

(use-package evil-collection
  :after evil
  :init
  (setq evil-collection-company-use-tng nil)
  :custom
  ;; Is this a bug in evil-collection?
  (setq evil-collection-bind-tab-p nil)
  :config
  (evil-collection-init))

;; Treat '_' as a word character
(modify-syntax-entry ?_ "w")
(modify-syntax-entry ?- "w")

(use-package which-key
  ;(diminish 'which-key-mode)
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3))

(use-package general
  :config
  (general-evil-setup t)

  (general-create-definer sica/leader-key-def
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (general-create-definer sica/ctrl-c-keys
    :prefix "C-c"))

      ;(require 'general)
(sica/leader-key-def
  "t"   '(:ignore t :which-key "toggles")
  "b"   '(:ignore t :which-key "buffers")
  "bd"  'kill-this-buffer
  "bk"  'kill-buffer
  "bn"  'evil-next-buffer
  "bp"  'evil-prev-buffer
  ","   'consult-buffer)

(setq inhibit-startup-screen t)
(set-face-attribute 'default nil :font "CaskaydiaCoveNerdFont" :height 140)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(global-display-line-numbers-mode 1)
(save-place-mode 1)
(global-auto-revert-mode 1)
(set-fringe-mode 10)

(pixel-scroll-precision-mode 1)
(setq-default cursor-type 'bar)

(setq-default indent-tabs-mode nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;;(global-whitespace-mode 1)

;;(use-package dtrt-indent
;;  :config
;;  (dtrt-indent-global-mode 1))

(use-package dashboard
  :config
  ;; for daemon
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  (dashboard-setup-startup-hook))

(use-package centaur-tabs
  :config
  (centaur-tabs-mode t)
  (centaur-tabs-headline-match)
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-set-bar 'under)
  ;; To get underline to display correctly on non-spacemacs
  (setq x-underline-at-descent-line t)
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-gray-out-icons t)
  (sica/leader-key-def
    "cp" 'centaur-tabs-backward
    "cn" 'centaur-tabs-forward))

(setq show-paren-delay 0)
(show-paren-mode 1)

(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-strict-mode t)
  (smartparens-global-mode t)
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
  (sp-local-pair 'org-mode "[" nil :actions nil)
  (sp-local-pair 'verilog-mode "'" nil :actions nil)
  (sp-pair "{" nil :post-handlers '(("||\n[i]" "RET"))))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package all-the-icons-dired)
(use-package dired-single)
(use-package dired-ranger)
(use-package dired-collapse)
(use-package dired
  :straight nil
  :config
  (setq dired-listing-switches "-agho --group-directories-first"
        dired-omit-files "^\\.[^.].*"
        dired-omit-verbose nil
        dired-hide-details-hide-symlink-targets nil
        delete-by-moving-to-trash t)

  (autoload 'dired-omit-mode "dired-x")

  (add-hook 'dired-load-hook
            (lambda ()
              (interactive)
              (dired-collapse)))

  (add-hook 'dired-mode-hook
            (lambda ()
              (interactive)
              (dired-omit-mode 1)
              (dired-hide-details-mode 1)
              (unless (or dw/is-termux
                          (s-equals? "/gnu/store/" (expand-file-name default-directory)))
                (all-the-icons-dired-mode 1))
              (hl-line-mode 1)))

  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "H" 'dired-omit-mode
    "l" 'dired-single-buffer
    "y" 'dired-ranger-copy
    "X" 'dired-ranger-move
    "p" 'dired-ranger-paste))

(use-package dired-rainbow
  :after dired
  :config
  (dired-rainbow-define-chmod directory "#6cb2eb" "d.*")
  (dired-rainbow-define html "#eb5286" ("css" "less" "sass" "scss" "htm" "html" "jhtm" "mht" "eml" "mustache" "xhtml"))
  (dired-rainbow-define xml "#f2d024" ("xml" "xsd" "xsl" "xslt" "wsdl" "bib" "json" "msg" "pgn" "rss" "yaml" "yml" "rdata"))
  (dired-rainbow-define document "#9561e2" ("docm" "doc" "docx" "odb" "odt" "pdb" "pdf" "ps" "rtf" "djvu" "epub" "odp" "ppt" "pptx"))
  (dired-rainbow-define markdown "#ffed4a" ("org" "etx" "info" "markdown" "md" "mkd" "nfo" "pod" "rst" "tex" "textfile" "txt"))
  (dired-rainbow-define database "#6574cd" ("xlsx" "xls" "csv" "accdb" "db" "mdb" "sqlite" "nc"))
  (dired-rainbow-define media "#de751f" ("mp3" "mp4" "mkv" "MP3" "MP4" "avi" "mpeg" "mpg" "flv" "ogg" "mov" "mid" "midi" "wav" "aiff" "flac"))
  (dired-rainbow-define image "#f66d9b" ("tiff" "tif" "cdr" "gif" "ico" "jpeg" "jpg" "png" "psd" "eps" "svg"))
  (dired-rainbow-define log "#c17d11" ("log"))
  (dired-rainbow-define shell "#f6993f" ("awk" "bash" "bat" "sed" "sh" "zsh" "vim"))
  (dired-rainbow-define interpreted "#38c172" ("py" "ipynb" "rb" "pl" "t" "msql" "mysql" "pgsql" "sql" "r" "clj" "cljs" "scala" "js"))
  (dired-rainbow-define compiled "#4dc0b5" ("asm" "cl" "lisp" "el" "c" "h" "c++" "h++" "hpp" "hxx" "m" "cc" "cs" "cp" "cpp" "go" "f" "for" "ftn" "f90" "f95" "f03" "f08" "s" "rs" "hi" "hs" "pyc" ".java"))
  (dired-rainbow-define executable "#8cc4ff" ("exe" "msi"))
  (dired-rainbow-define compressed "#51d88a" ("7z" "zip" "bz2" "tgz" "txz" "gz" "xz" "z" "Z" "jar" "war" "ear" "rar" "sar" "xpi" "apk" "xz" "tar"))
  (dired-rainbow-define packaged "#faad63" ("deb" "rpm" "apk" "jad" "jar" "cab" "pak" "pk3" "vdf" "vpk" "bsp"))
  (dired-rainbow-define encrypted "#ffed4a" ("gpg" "pgp" "asc" "bfe" "enc" "signature" "sig" "p12" "pem"))
  (dired-rainbow-define fonts "#6cb2eb" ("afm" "fon" "fnt" "pfb" "pfm" "ttf" "otf"))
  (dired-rainbow-define partition "#e3342f" ("dmg" "iso" "bin" "nrg" "qcow" "toast" "vcd" "vmdk" "bak"))
  (dired-rainbow-define vc "#0074d9" ("git" "gitignore" "gitattributes" "gitmodules"))
  (dired-rainbow-define-chmod executable-unix "#38c172" "-.*x.*"))

(use-package treemacs
  :defer t)

(use-package treemacs-evil
  :after treemacs evil)

(use-package treemacs-projectile
  :after treemacs projectile)

(use-package treemacs-icons-dired
  :after treemacs dired
  :config
  (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after treemacs magit)

;; All The Icons
(use-package all-the-icons)

(use-package doom-themes
:custom
(setq doom-themes-enable-italic t
  doom-themes-enable-bold t)
:config
  (load-theme 'doom-moonlight t)
  ;;(load-theme 'doom-city-lights t)
  ;;(load-theme 'doom-badger t)
  (doom-themes-neotree-config)
  (doom-themes-org-config))

(use-package minions
  :hook (doom-modeline-mode . minions-mode))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :custom
  (setq
  doom-modeline-lsp t
  doom-modeline-github t
  doom-modeline-minor-modes t
  doom-modeline-persp-name nil
  doom-modeline-buffer-file-name-style 'truncate-except-project
  doom-modeline-icon t
  doom-modeline-major-mode-icon t)
  :config
  (set-cursor-color "cyan")
  (line-number-mode t)
  (column-number-mode t))

(use-package diminish)

(use-package undo-tree
  :config
  (global-undo-tree-mode))

(use-package counsel-projectile)

(use-package projectile
  ;(diminish 'projectile-mode)
  :bind
  ("C-c p" . projectile-command-map)
  :config
  (projectile-mode)
  :init
  (setq projectile-switch-project-action #'projectile-dired))

;; Find a project via projectile
(defun nick/projectile-proj-find-function(dir)
  (let((root (projectile-project-root dir)))
    (and root (cons 'transient root))))
(with-eval-after-load 'project
  (add-to-list 'project-find-functions
               'nick/projectile-proj-find-function))

(use-package savehist
  :init
  (savehist-mode)
  :custom
  (setq history-length 25))

(defun sica/minibuffer-backward-kill (arg)
  "When minibuffer is completing a file name delete up to parent
      folder, otherwise delete a character backward"
  (interactive "p")
  (if minibuffer-completing-file-name
      (if (string-match-p "/." (minibuffer-contents))
          (zap-up-to-char (- arg) ?/)
        (delete-minibuffer-contents))
    (delete-backward-char arg)))

;; Completion menu
(use-package vertico
  :bind (:map vertico-map
              ("C-j" . vertico-next)
              ("C-k" . vertico-previous)
              ("C-f" . vertico-exit)
              :map minibuffer-local-map
              ("M-h" . backward-kill-word)
              ("<Backspace>" . sica/minibuffer-backward-kill))
  :custom
  (custom-set-faces '(vertico-current ((t (:background "#3a3f5a")))))
  (vertico-cycle t)
  :init
  (vertico-mode))

;; Provides useful completion commands
(use-package consult
  :custom
  (autoload 'projectile-project-root "projectile")
  (setq consult-project-root-function #'projectile-project-root)

  (setq completion-in-region-function #'consult-completion-in-region)

  :bind (("C-s" . consult-line)
         ("C-M-l" . consult-imenu)
         ("C-M-j" . persp-switch-to-buffer*)

         :map minibuffer-local-map
         ("C-r" . consult-history)))

(use-package marginalia
  :after vertico
  :custom
  (setq
   marginalia-annotators '(marginalia-annotators-heavy
                           marginalia-annotators-light
                           nil))
  :init
  (marginalia-mode))

(use-package consult-lsp
  :after consult)

(use-package cape)

;; Completion in region
(use-package corfu
  :straight (:host github :repo "minad/corfu")
  :bind (:map corfu-map
              ("C-j" . corfu-next)
              ("C-k" . corfu-previous)
              ("TAB" . corfu-next)
              ("S-TAB" . corfu-previous)
              ("C-f" . corfu-insert))
  :custom
  (corfu-cycle t)
  (corfu-preselect-first nil)
  :init
  (global-corfu-mode))

(setq tab-always-indent 'complete)
(setq c-tab-always-indent 'complete)

(use-package yasnippet
  :ensure
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (add-hook 'text-mode-hook 'yas-minor-mode))

;; Improved candidate filtering
(use-package orderless
  :init
  (setq completion-styles '(orderless partial-completion)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))
  ;; Hide commands in M-x which don't apply to the current mode
  ;(setq read-extended-command-predicate #'command-completion-default-include-p))

(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package helpful
  :bind
  ([remap describe-function] . helpful-function)
  ([remap describe-symbol] . helpful-symbol)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key))

(defun enhance-ui-for-orgmode()
  "Enhance UI for orgmode."
  (org-bullets-mode 1)
  (org-autolist-mode 1)
  (setq tab-width 2)
  (dolist(face '(org-level-1 org-level-2 org-level-3 org-level4 org-level-5))
    (set-face-attribute (car face) nil
                        :height 1.0
                        :background nil)))

(use-package org-autolist)
(use-package org-bullets)

(add-to-list 'org-structure-template-alist
       '("o" "#+TITLE: ?\n#+DATE: "))

(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

(add-hook 'org-mode-hook 'enhance-ui-for-orgmode)

(defun filter-org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.
    PRIORITY may be one of the characters ?A, ?B, or ?C."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
    (pri-value (* 1000 (- org-lowest-priority priority)))
    (pri-current (org-get-priority (thing-at-point 'line t))))
  (if (= pri-value pri-current)
    subtree-end
    nil)))

(setq org-agenda-window-setup 'only-window)
(setq org-agenda-custom-commands
    '(("c" "Custom agenda view"
     ((tags "PRIORITY=\"A\""
        ((org-agenda-overriding-header "High-priority unfinished tasks:")
         (org-agenda-skip-function '(org-agenda-skip-if nil '(todo done)))))
          (agenda "")
          (alltodo ""
               ((org-agenda-skip-function '(or (filter-org-skip-subtree-if-priority ?A)
                               (org-agenda-skip-if nil '(scheduled deadline))))))))))
(setq org-return-follows-link t)
(setq org-hide-emphasis-markers t)
(setq org-html-validation-link nil)
(setq org-todo-keywords
    '((sequence "TODO" "WORKING" "HOLD" "|" "DONE")))
(setq org-todo-keyword-faces
    '(("TODO"    . "#eb4d4b")
    ("WORKING" . "#f0932b")
    ("HOLD"    . "#eb4d4b")
    ("DONE"    . "#6ab04c")))

;;(use-package magit
;;:ensure t
;;:custom
;;(setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; NOTE: Make sure to configure a GitHub token before using this package!
;; - https://magit.vc/manual/forge/Token-Creation.html#Token-Creation
;; - https://magit.vc/manual/ghub/Getting-Started.html#Getting-Started
;;(use-package forge)

;; PATH
(let((path (shell-command-to-string ". ~/.zshrc; echo -n $PATH")))
(setenv "PATH" path)
(setq exec-path
    (append
     (split-string-and-unquote path ":")
     exec-path)))

;; Some term enhancement
;(defadvice term-sentinel (around my-advice-term-sentinel (proc msg))
;(if(memq (process-status proc) '(signal exit))
;  (let((buffer (process-buffer proc)))
;    ad-do-it
;    (kill-buffer buffer))
;  ad-do-it))
;(ad-activate 'term-sentinel)

(defadvice ansi-term (before force-bash)
(interactive (list "/bin/zsh")))
(ad-activate 'ansi-term)

;; Anzu for search matching
(use-package anzu
       :config
       (global-anzu-mode 1)
       (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
       (global-set-key [remap query-replace] 'anzu-query-replace))

;; Flycheck
(use-package flycheck
       :init
       (global-flycheck-mode))
(use-package flycheck-pos-tip
:init
(with-eval-after-load 'flycheck
    (flycheck-pos-tip-mode)))

(use-package quickrun
  :init
  (global-set-key (kbd "s-<return>") 'quickrun))

(use-package langtool
  :config
  (setq langtool-java-classpath "/usr/share/java/languagetool:/usr/share/java/languagetool/*")
  (setq langtool-language-tool-jar "/usr/share/java/languagetool/languagetool-commandline.jar"))

(setq-default tab-width 4)
(setq electric-indent-mode nil)
;; Auto indent and add new lines automatically
(setq next-line-add-newlines t)
(define-key global-map (kbd "RET") 'newline-and-indent)
(define-key evil-motion-state-map (kbd "C-u") 'evil-scroll-up)
(defun sica/all-major-mode-setup()
(list (modify-syntax-entry ?_ "w")
      (modify-syntax-entry ?- "w")))

;;(add-hook 'after-change-major-mode-hook 'sica/all-major-mode-setup)
(add-hook 'after-change-major-mode-hook
          (lambda () (list (modify-syntax-entry ?_ "w")
      (modify-syntax-entry ?- "w"))))

(sica/leader-key-def
  "i" '(:ignore t :which-key "indent")
  "ij" 'newline
  "s"   '(:ignore t :which-key "lang specific")
  "sc"  '(:ignore t :which-key "C/C++")
  "sci" 'c-indent-line-or-region
  "sr"  '(:ignore t :which-key "Rust")
  "srs" 'lsp-rust-analyzer-status
  "srf" 'rustic-format-buffer)

(use-package flycheck
  :init (global-flycheck-mode))

;;(use-package prog-major-mode
;;  :hook (progr-major-mode . dtrt-indent-mode))
(defun sica/lsp-compl-mode-setup ()
  (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
        '(orderless)))
  ;(setq-local completion-at-point-functions (list (cape-capf-buster
  ;                                                 #'lsp-completion-at-point))))
  ;(add-to-list 'completion-at-point-functions #'cape-capf-buster)
  ;(add-to-list 'completion-at-point-functions #'cape-file)
  ;(add-to-list 'completion-at-point-functions #'cape-tex)
  ;(add-to-list 'completion-at-point-functions #'cape-dabbrev)
  ;(add-to-list 'completion-at-point-functions #'cape-keyword))

(use-package lsp-mode
  :commands lsp
  :hook ((lsp-completion-mode . sica/lsp-compl-mode-setup)
         (prog-major-mode . lsp-prog-major-mode-enable)
         (vhdl-mode . lsp-deferred)
         (verilog-mode . lsp-deferred)
         (c++-mode . lsp-deferred)
         (c-mode . lsp-deferred)
         (cuda-mode . lsp-deferred)
         (java-mode . lsp-deferred)
         (latex-mode . lsp-deferred)
         (python-mode . lsp-deferred)
         (web-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration)
         (go-mode . lsp-deferred)
         (rustic-mode . lsp-deferred))
  :bind (:map evil-insert-state-map
              ("TAB" . indent-for-tab-command)
              ("M-TAB" . tab-to-tab-stop)
              ;("TAB" . tab-to-tab-stop)
              ;("M-TAB" . indent-for-tab-command)
              :map evil-normal-state-map
              ("TAB" . indent-for-tab-command))
  :init
  (sica/leader-key-def
    "l" '(:ignore t :which-key "lsp")
    "ld" 'xref-find-definitions
    "lr" 'xref-find-references
    "ln" 'lsp-ui-find-next-reference
    "lp" 'lsp-ui-find-prev-reference
    "ls" 'counsel-imenu
    "le" 'lsp-ui-flycheck-list
    "lS" 'lsp-ui-sideline-mode
    "lX" 'lsp-execute-code-action)
  ;;"M-?" lsp-find-references
  ;;("C-c C-c l" . flycheck-list-errors)
  ;;("C-c C-c r" . lsp-rename)
  ;;("C-c C-c q" . lsp-workspace-restart)
  ;;("C-c C-c Q" . lsp-workspace-shutdown)
  :custom
  (lsp-use-plists t)
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-rust-analyzer-server-display-inlay-hints t)
  (lsp-completion-provider :none)
  (lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-clangd-binary-path "/usr/bin/clangd")
  (lsp-file-watch-threshold 1500)
  (lsp-enable-which-key-integration t)
  (lsp-enable-on-type-formatting nil)
  (lsp-enable-indentation nil)
  (read-process-output-max (* 1024 1024))
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  (lsp-keep-workspace-alive nil))

(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-sideline-show-hover nil)
  (setq lsp-ui-doc-position 'bottom)
  (lsp-ui-doc-show))

(use-package lsp-treemacs
  :after (lsp-mode treemacs)
  :config
  (lsp-treemacs-sync-mode 1))

(use-package dap-mode
  :after lsp-mode
  :custom
  (dap-auto-configure-features '(sessions locals controls tooltip))
  :config
  (dap-mode 1)
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  (dap-ui-controls-mode 1))

(use-package tree-sitter
  :straight nil
  :after flycheck-mode
  :config
  (global-tree-sitter-mode))
;; TODO: Check up on this after emacs 30
(use-package treesit-auto
  :config
  (setq treesit-auto-install t)
  (global-treesit-auto-mode))

  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(defun sica/verilog-mode-hook()
  (setq tab-width 2))

(custom-set-variables
 '(lsp-clients-svlangserver-launchConfiguration "verilator -sv --lint-only -Wall")
 '(lsp-clients-svlangserver-formatCommand "verible-verilog-format"))

;; Project specific settings go in .dir-locals.el- might be fine here
;;((verilog-mode (lsp-clients-svlangserver-includeIndexing . ("src/**/*.{sv,svh}"))
;;(lsp-clients-svlangserver-excludeIndexing . ("src/test/**/*.{sv,svh}"))))
;;(lsp-clients-svlangserver-workspace-additional-dirs . ("/some/lib/path"))))

(add-to-list 'auto-mode-alist
             '("\\.s?v\\'" . verilog-mode))

(use-package verilog-mode
  :hook (verilog-mode . sica/verilog-mode-hook)
  :config
  :bind (:map verilog-mode-map
              ("DEL" . 'evil-delete-backward-char-and-join))
  :config
  (setq verilog-indent-level 2)
  (setq verilog-indent-level-behavioral 2)
  (setq verilog-indent-level-declaration 2)
  (setq verilog-indent-level-directive 2)
  (setq verilog-indent-level-module 2)
  (setq verilog-indent-begin-after-if nil)
  (setq verilog-case-indent 2)
  (setq verilog-auto-lineup nil)
  (setq verilog-auto-newline nil)
  (setq verilog-indent-lists nil))

;;(lsp-register-client (make-lsp-client :new-connection (lsp-stdio-connection '("vhdl-tool" "lsp"))
;;                                      :major-modes '(vhdl-mode)
;;                                      :language-id "VHDL"
;;                                      :server-id 'lsp-vhdl-mode))

(defun sica/elisp-hook()
  (setq tab-width 2))

(use-package emacs-lisp-mode
  :straight nil
  :after flycheck-mode
  :hook ((emacs-lisp-mode . flycheck-mode)
         (emacs-lisp-mode . sica/elisp-hook)))

(sica/leader-key-def
  "e"   '(:ignore t :which-key "emacs")
  "eb"  '(eval-buffer :which-key "eval buffer")
  "ed"  '((lambda ()
            (interactive)
            (find-file "~/.emacs.d/config.org"))
          :which-key "open emacs config")
  "eR"  '((lambda ()
            (interactive)
            (load-file "~/.emacs.d/init.el"))
          :which-key "reload emacs config")
  "et"  '(ansi-term :which-key "ansi term")
  "ec"  '(lazy-highlight-cleanup :which-key "lazy highlight cleanup")
  "eo"  '(:ignore t :which-key "org")
  "eon" '(org-jornal-list--start :which-key "journal list start")
  "eod" '((lambda ()
            (interactive)
            (org-agenda nil "c"))
          :which-key "open agenda"))

(sica/leader-key-def
  :keymaps '(visual)
  "er" '(eval-region :which-key "eval region"))

(defun sica/rustic-mode-hook ()
  (setq tab-width 4)
  (setq indent-tabs-mode nil))

(setq rust-ts-mode-hook rust-mode-hook)
; TODO: treesitter
(use-package rustic
  :hook (rustic-mode . sica/rustic-mode-hook)
  ;; comment to disable rustfmt on save
  :config
  (require 'dap-gdb-lldb)
  (setq rustic-format-on-save t)
  (setq rustic-format-on-save-method 'rustic-format-buffer)
  (setq rustic-rustfmt-bin "/usr/bin/rustfmt")
  (dap-register-debug-template "Rust::GDB Run Configuration"
                               (list :type "gdb"
                                     :request "launch"
                                     :name "GDB::Run"
                                     :gdbpath "rust-gdb"
                                     :target nil
                                     :cwd nil)))

(use-package go-mode
  :config
  (require 'dap-go))

(defun sica/c-mode-hook ()
  (setq tab-width 4)
  (setq c-basic-offset 4)
  (setq c-default-style "linux")
  (when (and (stringp buffer-file-name)
             (string-match "\\.sm\\'" buffer-file-name))
    (setq tab-width 2)
    (setq c-basic-offset 2)
    (setq indent-tabs-mode nil)))

(add-to-list 'auto-mode-alist '("\\.cu\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.c\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cc\\'" . c++-mode))

(setq c-ts-mode-hook c-mode-hook)
(setq c++-ts-mode-hook c++-mode-hook)

(use-package c-mode
  :straight nil
  :hook (c-mode . sica/c-mode-hook)
  :bind (:map c-mode-map
              ("DEL" . evil-delete-backward-char-and-join))
  :config
  (require 'dap-lldb))


(use-package c++-mode
  :straight nil
  :hook (c++-mode . sica/c-mode-hook)
  :config
  (require 'dap-cpptools))
  ;;(define-key c-mode-base-map (kbd "TAB") 'tab-to-tab-stop)

; Use python-base-mode for hooks
(use-package python-mode
  :config
  (require 'dap-python))

(use-package lsp-java
  :config
  (require 'dap-java))

(defun sica/set-js-indentation ()
  (setq-default js-indent-level 2)
  (setq-default evil-shift-width js-indent-level)
  (setq-default tab-width 2))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))


(use-package js2-mode
  :init
  '(js2-mode . (js-ts "--strict"))

  ;; Use js2-mode for Node scripts
  (add-to-list 'magic-mode-alist '("#!/usr/bin/env node" . js2-mode))

  ;; Don't use built-in syntax checking
  (setq js2-mode-show-strict-warnings nil)

  ;; Set up proper indentation in JavaScript and JSON files
  (add-hook 'js-base-mode-hook #'sica/set-js-indentation))

(use-package typescript-mode
  :init
  '(typescript-mode . (js-ts "--strict"))
  :config
  (setq typescript-indent-level 2))

(use-package vue-mode
  :init
  '(typescript-mode . (js-ts "--strict"))
  :config
  (setq typescript-indent-level 2)
  (setq vue-indent-level 2))

(use-package emmet-mode)
(use-package web-mode)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))

(defun sica/web-mode-hook ()
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-css-indent-offset 2)
    (setq web-mode-code-indent-offset 2)
    (setq-local indent-tabs-mode nil)
)

; TODO: uncomment when web ts mode
;(setq web-ts-mode-hook web-mode-hook)

(add-hook 'web-mode-hook #'sica/web-mode-hook)

;;(defvar haskell-exe (executable-find "REPLACE"))
;;(use-package haskell-mode)
;;(add-to-list 'eglot-server-programs
;;             '(haskell-mode . (haskell-exe "")))

; TODO: revisit for treesitter mode hooks
(defcustom tex-my-viewer
  "zathura --fork -s -x \"emacsclient --eval '(progn (switch-to-buffer  (file-name-nondirectory \"'\"'\"%{input}\"'\"'\")) (goto-line %{line}))'\""
  "PDF Viewer for TeX documents. You may want to fork the viewer so that it detects when the same document is launched twice, and persists when Emacs gets closed.

Simple command:

  zathura --fork

We can use

  emacsclient --eval '(progn (switch-to-buffer  (file-name-nondirectory \"%{input}\")) (goto-line %{line}))'

to reverse-search a pdf using SyncTeX. Note that the quotes and double-quotes matter and must be escaped appropriately."
:safe 'stringp)

(use-package tex
  :straight auctex
  :init
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (setq TeX-PDF-mode t))

(use-package reftex
  :init
  (setq reftex-plug-into-AUCTeX t)
  :config
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (add-hook 'LaTeX-mode-hook 'visual-line-mode)
  (add-hook 'LaTeX-mode-hook 'flyspell-mode)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode))

(setq gc-cons-threshold 800000)
