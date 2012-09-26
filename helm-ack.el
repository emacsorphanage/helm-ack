;;; helm-ack.el --- Ack command with helm interface

;; Copyright (C) 2012 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA <syohex@gmail.com>
;; URL:
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

(defvar helm-c-ack-base-command
  "ack --nocolor --nogroup")

(defvar helm-c-ack-auto-set-filetype t
  "Setting file type automatically")

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
      "")))

(defun helm-c-ack-init-command ()
  (format "%s %s "
          helm-c-ack-base-command
          (or (and helm-c-ack-auto-set-filetype (helm-c-ack-type-option)) " ")))

(defun helm-c-ack-init ()
  (let ((cmd (read-string "Command: " (helm-c-ack-init-command))))
    (with-current-buffer (helm-candidate-buffer 'global)
      (unless (zerop (call-process-shell-command cmd nil t nil))
        (error (message "Failed: %s" cmd))))))

(defvar helm-c-ack-source
  '((name . "helm ack")
    (init . helm-c-ack-init)
    (candidates-in-buffer)
    (type . file-line)
    (candidate-number-limit . 9999)))

(defvar helm-c-ack-buffer "*helm ack*")

(defun helm-ack ()
  (interactive)
  (let ((buf (get-buffer-create helm-c-ack-buffer)))
    (helm :sources '(helm-c-ack-source) :buffer buf)))

(provide 'helm-ack)

;;; helm-ack.el ends here
