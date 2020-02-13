(defun enhance-ui-for-orgmode()
  "Enhance UI for orgmode."
  (org-bullets-mode 1)
  (org-autolist-mode 1)
  (linum-mode nil)
  (dolist(face '(org-level-1 org-level-2 org-level-3 org-level4 org-level-5))
    set-face-attribute face nil
    :height 1.0
    :background nil))

;; Additional OrgMode Packages
(use-package org-autolist
  :ensure t)
(use-package org-bullets
  :ensure t)

;; ;; OrgMode Configs
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
                                                   (org-agenda-skip-if nil '(scheduled deadline))))))
                   ))))
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
