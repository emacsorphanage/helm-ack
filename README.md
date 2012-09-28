# helm-ack.el

## Introduction
`helm-ack.el` is App::ack helm interface.

## Screenshot

![helm-ack](https://github.com/syohex/emacs-helm-ack/raw/master/image/helm-ack.png)


## Requirements

* Emacs 22.1 or higher
* helm 1.0 or higher
* [App::Ack](https://metacpan.org/module/ack)

## Basic Usage

Input search word

    M-x helm-ack

Move to previous point on the stack.

    M-x helm-ack-pop-stack


## Customize

Base ack command, default is "ack --nocolor --nogroup"

    helm-c-ack-base-command

Auto insert `--type` option, default is true.

    helm-c-ack-auto-set-filetype

## Sample Configuration

```` elisp
(require 'helm-config)
(require 'helm-ack)

;; Does not insert '--type' option
(setq helm-c-ack-auto-set-filetype nil)
````
