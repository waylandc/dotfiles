;; Golang configuration

(rc/require 'go-mode)
(rc/require 'gotest)
(rc/require 'go-autocomplete)
(rc/require 'go-eldoc)
(rc/require 'company-go)

(defun go-mode-setup ()
  (setq tab-width 4)
  (setq indent-tabs-mode t)
  (add-hook 'before-save-hook 'gofmt-before-save) ; gofmt before every save
  (setq gofmt-command "goimports")  ; gofmt uses goimports
  (if (not (string-match "go" compile-command)) ; set compile command
      (set (make-local-variable 'compile-command)
	   "go build -v && go test -v && go vet"))

  (local-set-key (kbd "M-.") 'godef-jump) ; Go to definition
  (local-set-key (kbd "M-*") 'pop-tag-mark) ; Return from whence you came
  (local-set-key (kbd "M-p") 'compile) ; Invoke compiler
  (local-set-key (kbd "M-]") 'next-error) ; Go to next error (or message)
  (local-set-key (kbd "M-[") 'previous-error)) ; Go to previous error (or message)

 ;; (auto-complete-mode 1)) ; Enable auto-complete mode
(add-hook 'go-mode-hook 'go-mode-setup)

(add-hook 'go-mode-hook (lambda ()
			  (set (make-local-variable 'company-backends) '(company-go))
			  (company-mode)))


;;(with-eval-after-load 'go-mode
;;  (require 'go-autocomplete))

;; end golang configuration
