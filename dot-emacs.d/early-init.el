(when (fboundp 'startup-redirect-eln-cache)
  (startup-redirect-eln-cache
   (convert-standard-filename
    (expand-file-name "cache/eln-cache/" user-emacs-directory))))
(setq package-enable-at-startup nil)
