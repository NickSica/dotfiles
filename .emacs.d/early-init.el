(when (fboundp 'startup-redirect-eln-cache)
  (startup-redirect-eln-cache
   (convert-standard-filename
    (expand-file-name  "eln-cache/" "~/.emacs.d/cache/"))))
(setq package-enable-at-startup nil)
