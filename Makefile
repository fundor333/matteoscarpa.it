.DEFAULT_GOAL := help
BASEURL ?= https://matteoscarpa.it/
PORT ?= 1313

.PHONY: help serve serve-drafts build check new new-mostra mod-tidy mod-update clean

help: ## Mostra questo elenco di comandi
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

serve: ## Avvia il server locale (include mostre future, esclude i draft)
	hugo server --buildFuture --port $(PORT) --disableFastRender

serve-drafts: ## Avvia il server locale includendo anche i contenuti in draft
	hugo server -D --buildFuture --port $(PORT) --disableFastRender

build: clean ## Build di produzione in public/ (esclude i draft, include le mostre future)
	hugo --gc --minify --buildFuture --baseURL "$(BASEURL)"

check: ## Build di prova per individuare warning/errori prima del push
	hugo --gc --minify --buildFuture --baseURL "$(BASEURL)" --printPathWarnings --printUnusedTemplates

new-mostra: ## Crea una nuova mostra: make new-mostra NAME=nome-mostra
	@if [ -z "$(NAME)" ]; then echo "Uso: make new-mostra NAME=nome-mostra"; exit 1; fi
	hugo new content mostre/$(NAME)/index.md

mod-tidy: ## Rigenera go.sum in base al modulo tema importato in hugo.toml
	hugo mod tidy

mod-update: ## Aggiorna il tema hugo-theme-gallery all'ultima versione disponibile
	hugo mod get -u github.com/nicokaiser/hugo-theme-gallery/v4
	hugo mod tidy

clean: ## Rimuove gli artefatti di build locali
	rm -rf public resources .hugo_build.lock
