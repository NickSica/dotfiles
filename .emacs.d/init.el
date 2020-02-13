;; Package Configs
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("org"   . "https://orgmode.org/elpa/") t)
(package-initialize)
(package-refresh-contents t)

;; Bootstrap 'use-package'
(unless(package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

;; This will make sure the packages are always updated
(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(setq-default cursor-type 'bar)

;; Load other config files
(load "~/.emacs.d/custom/keybindings.el")
(load "~/.emacs.d/custom/config.el")
(load "~/.emacs.d/custom/helm_config.el")
(load "~/.emacs.d/custom/org_mode.el")

;; PATH
(let((path (shell-command-to-string ". ~/.zshrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path
	(append
	 (split-string-and-unquote path ":")
	 exec-path)))

;; Some term enhancement
(defadvice term-sentinel (around my-advice-term-sentinel (proc msg))
  (if(memq (process-status proc) '(signal exit))
      (let((buffer (process-buffer proc)))
	ad-do-it
	(kill-buffer buffer))
    ad-do-it))
(ad-activate 'term-sentinel)

(defadvice ansi-term (before force-bash)
  (interactive (list "/bin/zsh")))
(ad-activate 'ansi-term)

;; Evil Mode
;;(use-package evil
;;  :ensure t
;;  :init
;;  (setq evil-search-module 'evil-search)
;;  (setq evil-ex-complete-emacs-commands nil)
;;  (setq evil-vsplit-window-right t)
;;  (setq evil-split-window-below t)
;;  (setq evil-shift-round nil)
;;  (setq evil-want-C-u-scroll t)
;;  (setq evil-disable-insert-state-bindings t)
;;  :config
;;  (evil-mode)
;;  (defvar my-leader-map (make-sparse-keymap)
;;    "Keymap for \"leader key\" shortcuts.")
;;  (define-key evil-normal-state-map "," 'evil-repeat-find-char-reverse)
;;  (define-key evil-normal-state-map (kbd "SPC") my-leader-map)
;;  (define-key my-leader-map "w" 'evil-window-vsplit))

;; Anzu for search matching
(use-package anzu
	     :ensure t
	     :config
	     (global-anzu-mode 1)
	     (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
	     (global-set-key [remap query-replace] 'anzu-query-replace))

;; Projectile
(use-package projectile
	     :ensure t
	     :init
	     (setq projectile-require-project-root nil)
	     (setq projectile-completion-system 'helm)
	     :config
	     (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
	     (setq projectile-globally-ignored-directories
		   (append '("*.cquery_cached_index" "*.ccls-cache")
			   projectile-globally-ignored-directories))
	     (projectile-mode 1))
(projectile-register-project-type 'meson '("meson.build"))

;; Helm Projectile
(use-package helm-projectile
	     :ensure t
	     :init
	     (setq helm-projectile-fuzzy-match t)
	     :config
	     (helm-projectile-on))

;; All The Icons
(use-package all-the-icons
	     :ensure t)

;; Which Key
(use-package which-key
	     :ensure t
	     :init
	     (setq which-key-separator " ")
	     (setq which-key-prefix-prefix "+")
	     :config
	     (which-key-mode))

;;; Auto indent and add new lines automatically
(setq next-line-add-newlines t)
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Flycheck
(use-package flycheck
	     :ensure t
	     :init
	     (global-flycheck-mode))
(use-package flycheck-pos-tip
  :ensure t
  :init
  (with-eval-after-load 'flycheck
	(flycheck-pos-tip-mode)))

;; Company mode
(use-package company
	     :ensure t
	     :init
	     (setq company-minimum-prefix-length 2)
	     ;; (setq company-auto-complete nil)
	     (setq company-idle-delay .1)
	     (setq company-require-match 'never)
		 (setq company-tooltip-align-annotations 't)
		 (setq company-show-numbers t)
	     (setq company-frontends
		   '(company-pseudo-tooltip-unless-just-one-frontend
		     company-preview-frontend
		     company-echo-metadata-frontend))
      	     (setq tab-always-indent 'complete)
	     (defvar completion-at-point-functions-saved nil)
	     :config
	     (global-company-mode t)
	     (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
	     (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
	     (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
	     (define-key company-active-map (kbd "<backtab>") 'company-select-previous)
	     (define-key company-mode-map [remap indent-for-tab-command] 'company-indent-for-tab-command)
	     (defun company-indent-for-tab-command(&optional arg)
	       (interactive "P")
	       (let((completion-at-point-functions-saved completion-at-point-functions)
		    (completion-at-point-functions '(company-complete-common-wrapper)))
		 (indent-for-tab-command arg)))
	     (defun company-complete-common-wrapper()
	       (let((completion-at-point-functions completion-at-point-functions-saved))
		 (company-complete-common))))
;; (use-package company-box
;;   :ensure t
;;   :hook (company-mode . company-box-mode))
;; (setq company-box-icons-unknown (all-the-icons-faicon "question-circle"))
;; (setq company-box-icons-elisp
;; 	  '((all-the-icons-faicon "tag" :face font-lock-function-name-face) ;; Function
;; 		(all-the-icons-faicon "cog" :face font-lock-variable-name-face) ;; Variable
;; 		(all-the-icons-faicon "cube" :face font-lock-constant-face) ;;Feature
;; 		(all-the-icons-material "color_lens" :face font-lock-doc-face))) ;; Face
;; (setq company-box-icons-yasnippet (all-the-icons-faicon "bookmark"))
;; (setq company-box-icons-lsp
;; 	  '((1 . (all-the-icons-faicon "text-height")) ;; Text
;; 		(2 . ((all-the-icons-faicon "tags") :face font-lock-function-name-face)) ;; Method
;; 		(3 . ((all-the-icons-faicon "tag") :face font-lock-function-name-face)) ;; Function
;; 		(4 . ((all-the-icons-faicon "tag") :face font-lock-function-name-face)) ;; Constructor
;; 		(5 . ((all-the-icons-faicon "cog") :foreground "#FF9800")) ;; Field
;; 		(6 . ((all-the-icons-faicon "cog") :foreground "#FF9800")) ;; Variable
;; 		(7 . ((all-the-icons-faicon "cube") :foreground "#7C4DFF")) ;; Class
;; 		(8 . ((all-the-icons-faicon "cube") :foreground "#7C4DFF")) ;; Interface
;; 		(9 . ((all-the-icons-faicon "cube") :foreground "#7C4DFF")) ;; Module
;; 		(10 . ((all-the-icons-faicon "cog") :foreground "#FF9800")) ;; Property
;; 		(11 . (all-the-icons-material "settings_system_daydream")) ;; Unit
;; 		(12 . ((all-the-icons-faicon "cog") :foreground "#FF9800")) ;; Value
;; 		(13 . ((all-the-icons-material "storage") :face font-lock-type-face)) ;; Enum
;; 		(14 . ((all-the-icons-material "closed_caption") :foreground "#009688")) ;; Keyword
;; 		(15 . (all-the-icons-material "closed_caption")) ;; Snippet
;; 		(16 . ((all-the-icons-material "color_lens") :face font-lock-doc-face)) ;; Color
;; 		(17 . (all-the-icons-faicon "file-text-o")) ;; File
;; 		(18 . (all-the-icons-material "refresh")) ;; Reference
;; 		(19 . (all-the-icons-faicon "folder-open")) ;; Folder
;; 		(20 . ((all-the-icons-material "closed_caption") :foreground "#009688")) ;; EnumMember
;; 		(21 . ((all-the-icons-faicon "square") :face font-lock-constant-face)) ;; Constant
;; 		(22 . ((all-the-icons-faicon "cube") :face font-lock-type-face)) ;; Struct
;; 		(23 . (all-the-icons-faicon "calendar")) ;; Event
;; 		(24 . (all-the-icons-faicon "square-o")) ;; Operator
;; 		(25 . (all-the-icons-faicon "arrows")))) ;;TypeParameter

;; Quickrun
(use-package quickrun
  :ensure t
  :init
  (global-set-key (kbd "s-<return>") 'quickrun))

;; Spell check
(use-package langtool
  :ensure t
  :config
  (setq langtool-java-classpath "/usr/share/java/languagetool:/usr/share/java/languagetool/*")
  (setq langtool-language-tool-jar "/usr/share/java/languagetool/languagetool-commandline.jar"))

;; Magit
(use-package magit :ensure t)

;; A hack for fixing projectile with ag/rg
;; Source: https://github.com/syohex/emacs-helm-ag/issues/283
(defun helm-projectile-ag (&optional options)
  "Helm version of projectile-ag."
  (interactive (if current-prefix-arg (list (read-string "option: " "" 'helm-ag--extra-options-history))))
  (if (require 'helm-ag nil  'noerror)
      (if (projectile-project-p)
          (let ((helm-ag-command-option options)
                (current-prefix-arg nil))
            (helm-do-ag (projectile-project-root) (car (projectile-parse-dirconfig-file))))
        (error "You're not in a project"))
    (error "helm-ag not available")))

(load "~/.emacs.d/custom/lang_config.el")
(load "~/.emacs.d/custom/ligatures.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (zenburn-theme which-key use-package tern spaceline smartparens quickrun org-bullets org-autolist moody modern-cpp-font-lock minions magit lsp-ui lsp-javascript-typescript langtool js2-mode hide-mode-line helm-rg helm-projectile helm-descbinds helm-ag haskell-mode general flycheck-pos-tip elpy elm-mode eglot doom-themes doom-modeline company-lsp company-box ccls auctex anzu ace-jump-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
