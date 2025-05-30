(beacon-mode 1)

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 18 :weight 'light)
      doom-variable-pitch-font (font-spec :family "Iosevka Nerd Font" :size 18 :weight 'light))
(setq doom-theme 'doom-gruvbox)

;; Add local .bin to path
(setq exec-path (append exec-path (list (expand-file-name "~/.bin"))))
(setq exec-path (append exec-path (list (expand-file-name "~/go/bin"))))

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(defun jon-scroll-down()
  "Scroll down."
  (interactive)
  (evil-scroll-down nil)
  (evil-scroll-line-to-center nil)
  )

(defun jon-scroll-up()
  "Scroll down."
  (interactive)
  (evil-scroll-up nil)
  (evil-scroll-line-to-center nil)
  )

(defun jon-next-match()
  "Next Match"
  (interactive)
  (evil-ex-search-next nil)
  (evil-scroll-line-to-center nil)
  )

(defun jon-previous-match()
  "Previous Match"
  (interactive)
  (evil-ex-search-previous nil)
  (evil-scroll-line-to-center nil)
  )

(evil-define-key 'normal 'global (kbd "C-d") 'jon-scroll-down)
(evil-define-key 'normal 'global (kbd "C-u") 'jon-scroll-up)
(evil-define-key 'normal 'global (kbd "n") 'jon-next-match)
(evil-define-key 'normal 'global (kbd "N") 'jon-previous-match)

;; (defvar-local jon-format-on-save-enabled t
;;   "Whether formatting on save is enabled in this buffer.")

;; (defun jon-toggle-format-on-save ()
;;   "Toggle format-on-save via before-save-hook."
;;   (interactive)
;;   (if jon-format-on-save-enabled
;;       (progn
;;         (remove-hook 'before-save-hook #'ws-butler-before-save t)
;;         (setq jon-format-on-save-enabled nil)
;;         (ws-butler-mode -1)
;;         (message "Format on save disabled"))
;;     (add-hook 'before-save-hook #'format-buffer nil t)
;;     (ws-butler-mode 1)
;;     (setq jon-format-on-save-enabled t)
;;     (message "Format on save enabled")))


;; (map! :leader
;;       :desc "Toggle format on save"
;;       "t D" #'jon-toggle-format-on-save)

;;;; ORG MODE

(setq org-directory "~/org/"
      org-agenda-files (list "inbox.org"))

(after! org
  (setq
   org-agenda-start-with-log-mode t
   org-log-done 'time
   org-log-into-drawer t
   org-return-follows-link t
   org-clock-mode-line-total 'today
   org-agenda-hide-tags-regexp "."
   org-agenda-prefix-format
   '((agenda . " %i %-12:c%?-12t% s")
     (todo   . " %i %-12:c")
     (tags   . " %i %-12:c")
     (search . " %i %-12:c"))
   org-todo-keywords '((sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "PAUSED(p)" "|" "DONE(d)" "CANCELLED(c)" ))
   org-capture-templates `(("m" "Meeting" entry (file "refile.org")
                            "* MEETING with %? :MEETING:
\n%U
\n** Attendees
\n-
\n** Meeting Notes      :NOTE:
\n-
\n** Next Steps
\n\n"
                            :clock-in t :clock-resume t :jump-to-captured t)
                           ("i", "Inbox" entry (file "inbox.org")
                            ,(concat "* TODO %?\n" "/Entered on/ %U")))
   org-agenda-custom-commands
   '(("g" "Get Things Done (GTD)"
      ((agenda ""
               ((org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline))
                (org-agenda-span 'day)
                (org-agenda-use-time-grid t)
                (org-agenda-start-day "0d")
                (org-deadline-warning-days 0)))
       (agenda nil
               ((org-agenda-entry-types '(:deadline))
                (org-agenda-use-time-grid nil)
                (org-agenda-format-date "")
                (org-deadline-warning-days 7)
                (org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp "\\* \\(STARTED\\|TODO\\)"))
                (org-agenda-overriding-header "\nDeadlines")))
       (todo "TODO"
             ((org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline))
              (org-agenda-prefix-format "  %-12:c [%e] ")
              (org-agenda-overriding-header "\nTasks\n")))
       (tags-todo "inbox"
                  ((org-agenda-prefix-format "  %?-12t% s")
                   (org-agenda-overriding-header "\nInbox\n")))
       (tags "CLOSED>=\"<today>\""
             ((org-agenda-overriding-header "\nCompleted today\n"))))))
   org-refile-use-outline-path 'file
   org-outline-path-complete-in-steps nil
   org-refile-targets '(("projects.org" :regexp . "\\(?:\\(?:Note\\|Task\\)s\\)"))))


(defun jon-after-todo-state-change (&rest ignore)
  (let ((state (org-get-todo-state)))
    (cond
     ((string= state "STARTED")
      (org-clock-in))
     ((member state '("PAUSED" "DONE" "CANCELLED"))
      (org-clock-out)))))

(add-hook 'org-after-todo-state-change-hook #'jon-after-todo-state-change)

(setq visual-fill-column-width 110
      visual-fill-column-center-text t)

(add-hook! 'org-mode #'visual-line-mode)
(add-hook! 'org-mode-hook 'mixed-pitch-mode)

(require 'org-faces)
(dolist (face '((org-level-1 . 1.2)
                (org-level-2 . 1.1)
                (org-level-3 . 1.05)
                (org-level-4 . 1.0)
                (org-level-5 . 1.1)
                (org-level-6 . 1.1)
                (org-level-7 . 1.1)
                (org-level-8 . 1.1)))
  (set-face-attribute (car face) nil :font "Iosevka Nerd Font" :weight 'medium :height (cdr face)))
(set-face-attribute 'org-document-title nil :font "Iosevka Nerd Font" :weight 'bold :height 1.3)
;; Make sure certain org faces use the fixed-pitch face when variable-pitch-mode is on
(set-face-attribute 'org-block nil :foreground nil :inherit 'doom-font)
(set-face-attribute 'org-table nil :inherit 'doom-font)
(set-face-attribute 'org-formula nil :inherit 'doom-font)
(set-face-attribute 'org-code nil :inherit '(shadow doom-font))
(set-face-attribute 'org-verbatim nil :inherit '(shadow doom-font))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face doom-font))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face doom-font))
(set-face-attribute 'org-checkbox nil :inherit 'doom-font)

(defun jon/org-present-start()
  (setq-local header-line-remap (face-remap-add-relative 'header-line :height 4.0 :background "#282828"))
  (setq-local default-remap (face-remap-add-relative 'default :height 1.3))
  (setq header-line-format " ")
  (org-display-inline-images)
  (display-line-numbers-mode 0)
  (visual-fill-column-mode 1)
  (org-toggle-pretty-entities)
  )

(defun jon/org-present-end()
  (face-remap-remove-relative header-line-remap)
  (face-remap-remove-relative default-remap)
  (setq header-line-format nil)
  (org-remove-inline-images)
  (display-line-numbers-mode 1)
  (visual-fill-column-mode 0)
  )

(defun jon/org-present-prepare-slide(buffer-name heading)
  (org-overview)
  (org-show-entry)
  (org-show-children))

(add-hook! 'org-present-mode-hook 'jon/org-present-start)
(add-hook! 'org-present-mode-quit-hook 'jon/org-present-end)
(add-hook! 'org-present-after-navigate-functions 'jon/org-present-prepare-slide)


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
