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
;; (define-key evil-normal-state-map "," 'evil-repeat-find-char-reverse)
;;  (define-key evil-normal-state-map (kbd "SPC") my-leader-map)
;;  (define-key my-leader-map "w" 'evil-window-vsplit))

;; Paragraph Movement
(global-set-key (kbd "s-j") 'forward-paragraph)
(global-set-key (kbd "s-k") 'backward-paragraph)

;; Searching
(global-set-key (kbd "C-x /") 'helm-projectile-ag)
(global-set-key (kbd "C-x .") 'helm-resume)

;; Functions
(global-set-key (kbd "C-.") 'repeat)
(global-set-key (kbd "C-=") 'helm-M-x)
(global-set-key (kbd "C-c f e d") (lambda ()
                                    "open emacs config"
                                    (interactive)
                                    (find-file "~/.emacs.d/init.el")))
(global-set-key (kbd "C-c f e R") (lambda ()
                                    "reload emacs config"
                                    (interactive)
                                    (load-file "~/.emacs.d/init.el")))
(global-set-key (kbd "C-c a t") 'ansi-term)
(global-set-key (kbd "C-c C-c") 'lazy-highlight-cleanup)
(global-set-key (kbd "C-c TAB") 'previous-buffer)
(global-set-key (kbd "C-x p r") 'helm-show-kill-ring)
(global-set-key (kbd "C-z") 'undo)

;; Window management
(global-set-key (kbd "C-c /") 'split-window-right)
(global-set-key (kbd "C-c \\") 'split-window-below)
(global-set-key (kbd "C-c l") 'windmove-right)
(global-set-key (kbd "C-c h") 'windmove-left)
(global-set-key (kbd "C-c k") 'windmove-up)
(global-set-key (kbd "C-c j") 'windmove-down)
(global-set-key (kbd "C-c =") 'balance-windows)

;; Org Journal
(global-set-key (kbd "C-c t n") 'org-journal-list--start)
(global-set-key (kbd "C-c t d") (lambda ()
                                  "open agenda"
                                  (interactive)
                                  (org-agenda nil "c")))
