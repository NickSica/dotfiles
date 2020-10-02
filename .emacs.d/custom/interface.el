;; Splash Screen
(setq inhibit-startup-screen t)

;; Font Configs
(setq default-frame-alist '(("Cascadia Code 12")))
(set-face-attribute 'default nil :font "CascadiaCode" :height 120)

;; UI Configs
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode 1)

;; Smooth Scroll
(pixel-scroll-mode 1)
(setq scroll-step 1)

(setq-default cursor-type 'bar)

(use-package dashboard
  :ensure t
  :config
  ;; for daemon
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  (dashboard-setup-startup-hook))

(use-package centaur-tabs
  :ensure t
  :demand
  :config
  (centaur-tabs-mode t)
  (centaur-tabs-headline-match)
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-set-bar 'under)
  ;; To get underline to display correctly on non-spacemacs
  (setq x-underline-at-descent-line t)
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-gray-out-icons t)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>"  . centaur-tabs-forward))

;; Show matching parens
(setq show-paren-delay 0)
(show-paren-mode 1)

;; Smartparens
(use-package smartparens
  :ensure t
  :config
  (require 'smartparens-config)
  (smartparens-global-mode 1))

(use-package treemacs
  :ensure t
  :defer t)

;;(use-package treemacs-evil
;;  :after treemacs evil
;;  :ensure t)

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

;; All The Icons
(use-package all-the-icons
  :ensure t)

;; Theme
(use-package doom-themes
  :ensure t
  :custom
  (doom-themes-enable-italic t)
  (doom-themes-enable-bold t)
  :config
  (load-theme 'doom-city-lights t)
  (doom-themes-neotree-config)
  (doom-themes-org-config)
  ;; Modeline
  (use-package doom-modeline
    :ensure t
    :custom
    (doom-modeline-buffer-file-name-style)
    (doom-modeline-icon t)
    (doom-modeline-major-mode-icon t)
    (doom-modeline-minor-modes nil)
    :hook
    (after-init . doom-modeline-mode)
    :config
    (set-cursor-color "cyan")
    (line-number-mode 0)
    (column-number-mode 0)))
;;(use-package zenburn-theme
;;  :ensure t
;;  :config
;;  (load-theme 'zenburn t)
;;  (let((line (face-attribute 'mode-line :underline)))
;;  (set-face-attribute 'mode-line          nil :overline   line)
;;  (set-face-attribute 'mode-line-inactive nil :overline   line)
;;  (set-face-attribute 'mode-line-inactive nil :underline  line)
;;  (set-face-attribute 'mode-line          nil :box        nil)
;;  (set-face-attribute 'mode-line-inactive nil :box        nil)
;;  (set-face-attribute 'mode-line-inactive nil :background "#f9f2d9")))

;; Modeline
(use-package moody
  :ensure t
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))
(use-package minions
  :ensure t
  :config
  (minions-mode 1))


