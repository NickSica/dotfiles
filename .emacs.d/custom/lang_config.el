;;;;;;;;;;;;;;;;;;;;;;;
;; Language Supports ;;
;;;;;;;;;;;;;;;;;;;;;;;

;; Find a project via projectile
(defun nick/projectile-proj-find-function(dir)
  (let((root (projectile-project-root dir)))
    (and root (cons 'transient root))))
(with-eval-after-load 'project
  (add-to-list 'project-find-functions
	       'nick/projectile-proj-find-function))

(setq company-backends
      (cons 'company-capf
	    (remove 'company-capf company-backends)))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package verilog-mode
  :ensure t
  :config
;;  (add-hook 'verilog-mode-hook '(lambda ()
;;				  (setq compilation-error-regexp-alist (delete 'gnu compilation-error-regexp-alist))))
  (setq verilog-indent-level             2
	verilog-indent-level-module      4
	verilog-indent-level-declaration 2
	verilog-indent-level-behavioral  2
	verilog-indent-level-directive   2
	verilog-case-indent              2

	verilog-auto-newline             nil
	verilog-auto-indent-on-newline   t
	verilog-tab-always-indent        t
	verilog-minimum-comment-distance 10
	verilog-indent-begin-after-if    t
	verilog-auto-lineup              nil
	verilog-align-ifelse             nil
	verilog-auto-endcomments         t
	verilog-tab-to-comment           nil
	verilog-date-scientific-format   t))

;; LSP shit starts here
(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook (
	 (prog-major-mode . lsp-prog-major-mode-enable)
	 (vhdl-mode . lsp)
	 (verilog-mode . lsp)
	 (c++-mode . lsp)
	 (c-mode . lsp)
	 (python-mode . lsp))
  :config
  (setq lsp-prefer-flymake nil)
  (setq lsp-clients-clangd-args '("-j=4" "-background-index" "-log=error")))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (setq lsp-ui-doc-enable t
	lsp-ui-peek-enable t
	lsp-ui-doc-position 'top
	lsp-ui-doc-include-signature t
	lsp-ui-sideline-enable nil
	lsp-ui-flycheck-enable t
	lsp-ui-flycheck-list-position 'right
	lsp-ui-flycheck-live-reporting t
	lsp-ui-peek-enable t
	lsp-ui-peek-list-width 60
	lsp-ui-peek-peek-height 25
	eldoc-echo-area-use-multiline-p nil))

(use-package company-lsp
  :ensure t
  :requires company
  :commands company-lsp
  :config
  (push 'company-lsp company-backends)
  (setq company-transformers nil
	company-lsp-async t
	company-lsp-cache-candidates nil))

;; VHDL
;;(lsp-register-client (make-lsp-client :new-connection (lsp-stdio-connection '("vhdl-tool" "lsp"))
;;				      :major-modes '(vhdl-mode)
;;				      :language-id "VHDL"
;;				      :server-id 'lsp-vhdl-mode))

;; C/C++
(setq tab-width 4
      c-default-style "linux"
      c-basic-offset 4
      lsp-clients-clangd-executable (executable-find "clangd"))


;; Python
(defvar pyls (executable-find "pyls")
  "Python Language Server executable path.")


;; JavaScript/Typescript
(defvar js-ts (executable-find "javascript-typescript-langserver")
  "Javascript/Typescript Language Server path.")

(use-package js2-mode
	     :ensure t
	     :init
	     '(js2-mode . (js-ts "--strict")))

(use-package typescript-mode
	     :ensure t
	     :init
	     '(typescript-mode . (js-ts "--strict")))


;; ;; Haskell
;; (defvar haskell-exe (executable-find "REPLACE"))
;; (use-package haskell-mode
;;   :ensure t)
;; (add-to-list 'eglot-server-programs
;; 	     '(haskell-mode . (haskell-exe "")))

;; ;; Latex
;; (use-package auctex
;;   :ensure t
;;   :init
;;   (setq TeX-auto-save t)
;;   (setq TeX-parse-self t)
;;   (setq-default TeX-master nil)
;;   (setq reftex-plug-into-AUCTeX t)
;;   :config
;;   (use-package reftex
;;     :ensure t
;;     :config
;;     (add-hook 'LaTeX-mode-hook 'turn-on-reftex))
;;   (add-hook 'LaTeX-mode-hook 'visual-line-mode)
;;   (add-hook 'LaTeX-mode-hook 'flyspell-mode)
;;   (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode))

;; LSP for JavaScript and TypeScript
;; (use-package lsp-javascript-typescript
;; 	     :ensure t
;; 	     :init
;; 	     (add-to-list 'js-mode-hook #'lsp-javascript-typescript-enable)
;; 	     (add-to-list 'typescript-mode-hook #'lsp-javascript-typescript-enable))



