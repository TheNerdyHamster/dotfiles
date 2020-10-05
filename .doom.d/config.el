(getenv "PATH")

(setq user-full-name "Leo Rönnebro"
      user-mail-address "leo.ronnebro@hamsterapps.net")

(eval-after-load
  'company
  '(add-to-list 'company-backends #'company-omnisharp))

(defun custom-csharp-mode-setup ()
  (omnisharp-mode)
  (company-mode)
  (flycheck-mode)

  (setq indent-tabs-mode nil)
  (setq c-syntactic-indentation t)
  (c-set-style "ellemtel")
  (setq c-basic-offset 4)
  (setq truncate-lines t)
  (setq tab-width 4)
  (setq evil-shift-width 4)

  (electric-pair-local-mode 1) ;; Emacs 25

  (local-set-key (kbd "C-c R") 'dotnet-run)
  (local-set-key (kbd "C-c r r") 'omnisharp-run-code-action-refactoring)
  (local-set-key (kdb "C-c f") 'omnisharp-code-format-entire-file)
  (local-set-key (kbd "C-c C-c") 'recompile))

(add-hook 'csharp-mode-hook 'custom-csharp-mode-setup t)

(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 13)
      doom-variable-pitch-font (font-spec :family "sans" :size 13))

(setq doom-theme 'doom-one)

(after! org
  (setq org-directory "~/Documents/org/")
  (setq org-agenda-files '("~/Documents/org/agenda.org"))
  (setq org-log-done 'time)
  (setq org-log-done 'note)
  (setq org-todo-keywords '((sequence "TODO(t)" "PROJ(p)" "IMPORTANT(i)" "WAIT(w)" "|" "DONE(d)" "CANCELLED(c)" )))
  (require 'org-bullets)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
)

(use-package! org-super-agenda
    :after org-agenda
    :init
    (setq org-super-agenda-groups '((:name "Today"
                                        :time-grid t
                                        :scheduled today)
                                    (:name "Due today"
                                        :deadline today)
                                    (:name "Important"
                                        :priority "A")
                                    (:name "Due soon"
                                        :deadline future)
                                    (:name "Big Outcomes"
                                        :tag "bo")
                                    ))
    :config
    (org-super-agenda-mode)
)

(setq display-line-numbers-type 't)
(global-set-key "\C-x\ t" 'toggle-truncate-lines)
:w

(setq projectile-project-search-path '("~/code/"))

(defun prefer-horizontal-split ()
  (set-variable 'split-height-threshold nil t)
  (set-variable 'split-width-threshold 40 t)) ; make this as low as needed
(add-hook 'markdown-mode-hook 'prefer-horizontal-split)
