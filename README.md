# Warning List
Список компаний с выявленными признаками нелегальной деятельности на финансовом рынке по данным [Банка России](https://www.cbr.ru/inside/warning-list/). Скрипт скачивает XLSX с сайта банка, конвертирует в CSV и складывает локально в `data/full.csv` и `data/sites.csv` соответственно.

Установить гемы:
```
bundle install
```

Обновить список:
```
bundle exec ruby update.rb
```