
;; Go Lang setup
(defun install-go ()
(interactive)
(if (system-is-linux)
(call-process-shell-command "sudo apt-get install golang" nil (current-buffer) nil))
(call-process-shell-command "go get -u github.com/mdempsky/gocode" nil (current-buffer) nil)
(call-process-shell-command "go get -u github.com/derekparker/delve/cmd/dlv" nil (current-buffer) nil)
(call-process-shell-command "go get -u github.com/kisielk/errcheck" nil (current-buffer) nil)
(call-process-shell-command "go get -u golang.org/x/tools/cmd/godoc" nil (current-buffer) nil))

(use-package go-mode)
(use-package company-go)
(use-package go-guru)
(use-package go-dlv)

(defun my-go-mode-hook() 
	(use-package go-snippets :ensure t)
	(go-snippets-initialize)

;;WC	(autoload 'helm-go-package "helm-go-package") ;; Not necessary if using ELPA package
	(eval-after-load 'go-mode
	'(substitute-key-definition 'go-import-add 'helm-go-package go-mode-map))
		
	(add-hook 'before-save-hook 'gofmt-before-save) 
	(setq gofmt-command "goimports") 
	(if (not (string-match "go" compile-command)) 
		(set (make-local-variable 'compile-command) "go build -v && go test -v && go vet"))

	(local-set-key (kbd "C-c m") 'gofmt)
	;; guru settings
	(go-guru-hl-identifier-mode) 
	(local-set-key (kbd "M-.") 'godef-jump) 
	(local-set-key (kbd "M-*") 'pop-tag-mark) 
	(local-set-key (kbd "M-p") 'compile) 
	(local-set-key (kbd "M-P") 'recompile) 
	(local-set-key (kbd "M-]") 'next-error) 
	(local-set-key (kbd "M-[") 'previous-error)
	;;(auto-complete-mode 1) 
	;;(yas-minor-mode-on)
)

(add-hook 'go-mode-hook (lambda ()
	(set (make-local-variable 'company-backends) '(company-go))
	(company-mode)))

(add-hook 'go-mode-hook 'my-go-mode-hook) 
