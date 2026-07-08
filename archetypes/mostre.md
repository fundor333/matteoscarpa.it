---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
description: ""
params:
  data_fine: "{{ .Date | time.Format "2006-01-02" }}"
  luogo: ""
  luogo_url: ""
  sort_by: "Date"
  sort_order: "asc"
draft: true
---

Descrizione lunga della mostra.
