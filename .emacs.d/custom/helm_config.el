;; Helm
(use-package helm
	     :ensure t
	     :init
		 (require 'helm-config)
	     (setq helm-M-x-fuzzy-match t
		   helm-mode-fuzzy-match t
		   helm-buffers-fuzzy-match t
		   helm-recentf-fuzzy-match t
		   helm-locate-fuzzy-match t
		   helm-semantic-fuzzy-match t
		   helm-imenu-fuzzy-match t
		   helm-completion-in-region-fuzzy-match t
		   helm-candidate-number-list 80
		   helm-split-window-in-side-p t
		   helm-move-to-line-cycle-in-source t
		   helm-echo-input-in-header-line t
		   helm-autoresize-max-height 0
		   helm-autoresize-min-height 20)
	     :config
	     (helm-mode 1)
	     (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
	     (define-key helm-map (kbd "C-z") 'helm-select-action))

(use-package helm-descbinds
  :ensure t
  :config
  (helm-descbinds-mode))


;; RipGrep
(use-package helm-rg
  :ensure t)

;; AG
(use-package helm-ag
  :ensure t)
