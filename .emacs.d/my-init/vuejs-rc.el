(use-package vue-mode)
(use-package vue-html-mode)

(setq vue-mode-packages
      '(vue-mode))
(setq vue-mode-excluded-packages '())
(defun vue-mode/init-vue-mode ()
  "Initialize my package"
  (use-package vue-mode))

