(use-package lsp-mode
  :ensure t  )

(defun go-execute ()
  (interactive)
  (require 'compile)
  (let ((command (format "go run %s" buffer-file-name)))
    (compilation-start command)))

(use-package go-mode
  :ensure t
  :mode "\\.go^\\'"
  ;; :hook
  ;; (go-mode . 'lsp-deferred)
  ;; (before-save . 'gofmt-before-save)
  :custom
  (tab-width 4)
  (company-idle-delay 0.3)
  (gofmt-command "goimports")
  :bind ("C-c C-c" . 'go-execute)
  :config
  (add-hook 'go-mode-hook 'lsp-deferred)
  (add-hook 'before-save-hook 'gofmt-before-save))

(use-package company-go
  :ensure t
  :hook (go-mode . (lambda ()
                     (add-to-list (make-local-variable 'company-backends) '(company-go company-files company-yasnippet company-capf)))))
(provide 'init-go)
