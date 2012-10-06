;;; helm-ack.el --- Ack command with helm interface

;; Copyright (C) 2012 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA <syohex@gmail.com>
;; URL: https://github.com/syohex/emacs-helm-ack
;; Version: 0.01

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(eval-when-compile
  (require 'cl))

(require 'helm)

(defgroup helm-ack nil
  "Ack command with helm interface"
  :group 'helm)

(defcustom helm-c-ack-base-command "ack --nocolor --nogroup"
  "Base command of `ack'"
  :type 'string
  :group 'helm-ack)

(defcustom helm-c-ack-auto-set-filetype t
  "Setting file type automatically"
  :type 'boolean
  :group 'helm-ack)

(defcustom helm-c-ack-insert-at-point 'word
  "Insert thing at point as search pattern.
   You can set value same as `thing-at-point'"
  :type 'symbol
  :group 'helm-ack)

(defvar helm-c-ack-context-stack nil
  "Stack for returning the point before jump")

(defun helm-c-ack-mode-to-type (mode)
  (case mode
    (actionscript-mode "ack")
    (ada-mode "ada")
    (asm-mode "asm")
    (batch-mode "batch")
    (c-mode "cc")
    (clojure-mode "clojure")
    (c++-mode "cpp")
    (csharp-mode "csharp")
    (css-mode "css")
    (emacs-lisp-mode "elisp")
    (erlang-mode "erlang")
    ((fortan-mode f90-mode) "fortran")
    (go-mode "go")
    (groovy-mode "groovy")
    (haskell-mode "haskell")
    (html-mode "html")
    (java-mode "java")
    ((javascript-mode js-mode js2-mode) "js")
    (lisp-mode "lisp")
    (lua-mode "lua")
    (makefile-mode "make")
    (objc-mode "objc")
    ((ocaml-mode tuareg-mode) "ocaml")
    ((perl-mode cperl-mode) "perl")
    (php-mode "php")
    (python-mode "python")
    (ruby-mode "ruby")
    (scala-mode "scala")
    (scheme-mode "scheme")
    (shell-script-mode "shell")
    (sql-mode "sql")
    (tcl-mode "tcl")
    ((tex-mode latex-mode yatex-mode) "tex")))

(defun helm-c-ack-type-option ()
  (let ((type (helm-c-ack-mode-to-type major-mode)))
    (if type
        (format "--type=%s" type)
      "--all")))

(defun helm-c-ack-thing-at-point ()
  (let ((str (thing-at-point helm-c-ack-insert-at-point)))
    (if (and str (typep str 'string))
        (substring-no-properties str)
      "")))

(defun helm-c-ack-init-command ()
  (format "%s %s %s"
          helm-c-ack-base-command
          (or (and helm-c-ack-auto-set-filetype (helm-c-ack-type-option)) "")
          (or (and helm-c-ack-insert-at-point (helm-c-ack-thing-at-point)) "")))

(defun helm-c-ack-save-current-context ()
  (let ((file (buffer-file-name helm-current-buffer))
        (curpoint (with-current-buffer helm-current-buffer
                    (point))))
    (push `((file  . ,file)
            (point . ,curpoint)) helm-c-ack-context-stack)))

;;;###autoload
(defun helm-ack-pop-stack ()
  (interactive)
  (let ((context (pop helm-c-ack-context-stack)))
    (unless context
      (error "Context stack is empty!!"))
    (let ((file (assoc-default 'file context))
          (curpoint (assoc-default 'point context)))
      (find-file file)
      (goto-char curpoint))))

(defun helm-c-ack-init ()
  (let ((cmd (read-string "Command: " (helm-c-ack-init-command))))
    (helm-attrset 'recenter t)
    (helm-attrset 'before-jump-hook #'helm-c-ack-save-current-context)
    (with-current-buffer (helm-candidate-buffer 'global)
      (unless (zerop (call-process-shell-command cmd nil t nil))
        (error (message "Failed: %s" cmd))))))

(defvar helm-c-ack-source
  '((name . "helm ack")
    (init . helm-c-ack-init)
    (candidates-in-buffer)
    (type . file-line)
    (candidate-number-limit . 9999)))

;;;###autoload
(defun helm-ack ()
  (interactive)
  (let ((buf (get-buffer-create "*helm ack*")))
    (helm :sources '(helm-c-ack-source) :buffer buf)))

(provide 'helm-ack)

;;; helm-ack.el ends here
