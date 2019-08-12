
(use-package company :ensure t)
(use-package racer :ensure t)
(use-package eldoc :ensure t)
(use-package flycheck :ensure t)
(use-package flycheck-rust :ensure t)
(use-package rust-mode
  :ensure t
  :config
  (add-hook 'flycheck-mode-hook 'flycheck-rust-setup))

;(use-package racer :ensure t)

;(setq flymake-rust-use-cargo nil)

;(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'rust-mode-hook #'company-mode)
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'rust-mode-hook #'eldoc-mode)
(add-hook 'rust-mode-hook
  '(lambda ()
;    (setq racer-cmd (concat (getenv "HOME") "/.cargo/bin/racer"))
    (setq racer-cmd (concat "/nix/store/a6j0ii4v0a628gakmcl15ibykrgg57yn-racer-2.0.14/bin/racer"))
    (setq racer-rust-src-path (concat (getenv "HOME") "/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src"))
      (local-set-key (kbd "TAB") #'company-indent-or-complete-common)
   )
)

;(require 'rust-mode)
;(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
;(setq company-tooltip-align-annotations t)


