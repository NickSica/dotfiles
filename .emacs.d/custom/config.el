;; Splash Screen
(setq inhibit-startup-screen t)
(setq initial-scratch-message ";; Happy Hacking")

;; Font Configs
(set-face-attribute 'default nil :font "IosevkaCustom Semibold" :background "#3F3F3F" :foreground "#DCDCCC" :height 120)

;; UI Configs
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode 1)

;; Smooth Scroll
(pixel-scroll-mode 1)
(setq scroll-step 1)

;; Other Configs
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Show matching parens
(setq show-paren-delay 0)
(show-paren-mode 1)

;; Smartparens
(use-package smartparens
  :ensure t
  :config
  (require 'smartparens-config)
  (smartparens-global-mode 1))

;; Theme
(use-package zenburn-theme
	     :ensure t
	     :config
	     (load-theme 'zenburn t)
	     (let((line (face-attribute 'mode-line :underline)))
	       (set-face-attribute 'mode-line          nil :overline   line)
	       (set-face-attribute 'mode-line-inactive nil :overline   line)
	       (set-face-attribute 'mode-line-inactive nil :underline  line)
	       (set-face-attribute 'mode-line          nil :box        nil)
	       (set-face-attribute 'mode-line-inactive nil :box        nil)
	       (set-face-attribute 'mode-line-inactive nil :background "#f9f2d9")))

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
